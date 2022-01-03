# Some bpftrace scripts using perldtrace

Table of Contents

* [Common pitfalls/caveats](#common-pitfalls-caveats)
* [Track the 30 most frequent sub routine calls in the current most active uwsgi process](#track-the-30-most-frequent-sub-routine-calls-in-the-current-most-active-uwsgi-process)
* [Get wallclocks of all subroutines of a specific module/package in the current most active uwsgi process](#get-wallclocks-of-all-subroutines-of-a-specific-module-package-in-the-current-most-active-uwsgi-process)
* [uwsgi restart: packages wallclocks](#uwsgi-restart-packages-wallclocks)
* [uwsgi restart: subroutine wallclocks](#uwsgi-restart-subroutine-wallclocks)
* [Unwind perl stacktrace on kernel events](#unwind-perl-stacktrace-on-kernel-events)
* [Using uwsgi_request on new request](#using-uwsgi-request-on-new-request)
* [Enabling perldtrace](#enabling-perldtrace)

These are a collection of bpftrace scritpts using [perldtrace](https://perldoc.perl.org/perldtrace.html), used in the context running perl app using uwsgi.

## [Common pitfalls/caveats](#common-pitfalls-caveats)

* Lost event and BPFTRACE_STRLEN
* The need of a pid and uwsgi multi-processes
    * Because there is a semaphore guarding the perl dtrace calls, we have to start bpftrace command per uwsgi process, which is basically the cpu core counts on the baremetal server
* Kernel version (4.19 works great, I had many pains in the beginning on 4.9 that I always avoid them)
* 512 bytes of stack size limit, so sometimes we have to live with truncated string.
* Misaligned stack access off: there are many reasons causing this issue. When specifying `BPFTRACE_STRLEN`, it's better to use values like `64 (int % 8 == 0)`
* [`sub__return/loading__file/loaded__file`](https://github.com/Perl/perl5/blob/blead/mydtrace.h#L17) is reusing `sub__entry`’s semaphore, which means we need an empty `sub__entry` probe even when tracing `sub__return/loading__file/loaded__file`

Scripts/Examples

## [Track the 30 most frequent sub routine calls in the current most active uwsgi process](#track-the-30-most-frequent-sub-routine-calls-in-the-current-most-active-uwsgi-process)

```
pid=`ps -eo pcpu,pid,cmd | grep uw[s]gi | sort -nr | sed 's/^ \+//' | sed 's/ \+/ /' | cut -d ' ' -f 2 | head -1`

BPFTRACE_STRLEN=256 sudo bpftrace -p $pid -e '
usdt:/usr/lib64/libperl.so:sub__entry {
        @calls[pid, str(arg3), str(arg0)] = count();
}

interval:s:5 {
        printf("----"); print(@calls, 30); clear(@calls);
}
'
Get wallclocks of a specific subroutine in the current most active uwsgi process
Using A::Perl::Package->a_sub_routine as an example:

function clean_up {
    echo 'exit: sudo pkill bpftrace'
    sudo pkill bpftrace
    exit 0
}

trap clean_up INT TERM EXIT

while true; do

pid=`ps -eo pcpu,pid,cmd | grep uw[s]gi | sort -nr | sed 's/^ \+//' | sed 's/ \+/ /' | cut -d ' ' -f 2 | head -1`

echo "tracing $pid ---"

sudo BPFTRACE_STRLEN=64 bpftrace -p $pid -e '
usdt:/usr/lib64/libperl.so:sub__entry {
        if (str(arg3) == "A::Perl::Package" && str(arg0) == "a_sub_routine") {
                @start = nsecs;
        }
}

usdt:/usr/lib64/libperl.so:sub__return {
        if (str(arg3) == "A::Perl::Package" && str(arg0) == "a_sub_routine") {
                printf("%d %s::%s %d\n", '$pid', str(arg3), str(arg0), nsecs - @start);
                @start = 0;
        }
}
'

sleep 2

done
```

## [Get wallclocks of all subroutines of a specific module/package in the current most active uwsgi process](#get-wallclocks-of-all-subroutines-of-a-specific-module-package-in-the-current-most-active-uwsgi-process)

Using DBI as a example:

```
function clean_up {
    echo 'exit: sudo pkill bpftrace'
    sudo pkill bpftrace
    exit 0
}

trap clean_up INT TERM EXIT

while true; do

pid=`ps -eo pcpu,pid,cmd | grep uw[s]gi | sort -nr | sed 's/^ \+//' | sed 's/ \+/ /' | cut -d ' ' -f 2 | head -1`

echo "tracing $pid ---"

sudo BPFTRACE_STRLEN=64 bpftrace -p $pid -e '
usdt:/usr/lib64/libperl.so:sub__entry {
        if (str(arg3, 3) == "DBI") {
                @start_ts[arg3, arg0, arg2] = nsecs;
        }
}

usdt:/usr/lib64/libperl.so:sub__return {
        if (str(arg3, 3) == "DBI" && @start_ts[arg3, arg0, arg2] > 0) {
                @latencies['$pid', str(arg3), str(arg0), arg2] = hist(nsecs - @start_ts[arg3, arg0, arg2]);
                delete(@start_ts[arg3, arg0, arg2]);
        }
}

interval:s:5 {
        print(@latencies);
        clear(@latencies);
}

interval:s:30 { exit(); }

END { clear(@start_ts); print(@latencies); clear(@latencies); }
'

sleep 2

done
```

## [uwsgi restart: packages wallclocks](#uwsgi-restart-packages-wallclocks)

```
function clean_up {
    echo 'exit: sudo pkill bpftrace'
    sudo pkill bpftrace
    exit 0
}

trap clean_up INT TERM EXIT

mkdir -p uwsgi_restart_wallclock_by_package

sudo bpftrace -e '
  tracepoint:syscalls:sys_enter_execve /str(args->filename) == "/usr/sbin/uwsgi"/ { printf("%d\n", pid) }
  uretprobe:/usr/sbin/uwsgi:uwsgi_fork /retval > 0/ { printf("%d\n", retval); }
' |

while read -r pid; do

if [[ "$pid" =~ Attaching* ]]; then
    continue;
fi

echo "tracing $pid"

BPFTRACE_STRLEN=64 BPFTRACE_MAP_KEYS_MAX=12800 bpftrace -p $pid -e '
BEGIN { @depth = 0 }

// because loading__file/loaded__file reuses sub__entry semaphore, so we need
// to attach a empty probe here.
usdt:/usr/lib64/libperl.so:sub__entry {}

usdt:/usr/lib64/libperl.so:perl:loading__file {
    @start_ts[arg0] = nsecs;
    @total_loaded_files++;
}

usdt:/usr/lib64/libperl.so:perl:loaded__file {
    @latencies['$pid', str(arg0)] = nsecs - @start_ts[arg0];
}

END { clear(@start_ts); print(@latencies); clear(@latencies); }
' &>> uwsgi_restart_wallclock_by_package/"$pid" &

done
```

## [uwsgi restart: subroutine wallclocks](#uwsgi-restart-subroutine-wallclocks)

```
function clean_up {
    echo 'exit: sudo pkill bpftrace'
    sudo pkill bpftrace
    exit 0
}

trap clean_up INT TERM EXIT

while true; do

pid=`ps -eo pcpu,pid,cmd | grep uwsgi | sort -nr | sed 's/^ \+//' | sed 's/ \+/ /' | cut -d ' ' -f 2 | head -1`

echo "tracing $pid"

sudo BPFTRACE_STRLEN=64 bpftrace -p $pid -e '
usdt:/usr/lib64/libperl.so:sub__entry {
        @start_ts[arg3, arg0, arg2] = nsecs;
        @calls['$pid', str(arg3), str(arg0), arg2] = count();
}

usdt:/usr/lib64/libperl.so:sub__return {
        @latencies['$pid', str(arg3), str(arg0), arg2] = hist(nsecs - @start_ts[arg3, arg0, arg2]);
        delete(@start_ts[arg3, arg0, arg2]);
}

interval:s:10 {
        printf("---\n");
        print(@calls, 30);
        print(@latencies, 30);
        exit();
}

END { clear(@start_ts); clear(@calls); clear(@latencies); }
'

sleep 2

done
```

## [Unwind perl stacktrace on kernel events](#unwind-perl-stacktrace-on-kernel-events)


osq_lock as example:


```
pid=`ps -eo pcpu,pid,cmd | grep uwsgi | sort -nr | sed 's/^ \+//' | sed 's/ \+/ /' | cut -d ' ' -f 2 | head -1`

echo "tracing $pid"

sudo BPFTRACE_STRLEN=64 bpftrace -p $pid -e '
usdt:/usr/lib64/libperl.so:sub__entry {
        @depth++;
        @module[@depth] = str(arg3);
        @sub[@depth] = str(arg0);
        @line[@depth] = arg2;
}

usdt:/usr/lib64/libperl.so:sub__return {
        @depth--;
}

kprobe:osq_lock {
        if (pid == '$pid' && @line[@depth-0] > 0) {
                printf("\n");
                printf("%s %s %d\n", @module[@depth-0], @sub[@depth-0], @line[@depth-0]);
        }
}

kprobe:osq_lock {
        if (pid == '$pid' && @line[@depth-1] > 0) {
                printf("%s %s %d\n", @module[@depth-1], @sub[@depth-1], @line[@depth-1]);
        }
}

kprobe:osq_lock {
        if (pid == '$pid' && @line[@depth-2] > 0) {
                printf("%s %s %d\n", @module[@depth-2], @sub[@depth-2], @line[@depth-2]);
        }
}

kprobe:osq_lock {
        if (pid == '$pid' && @line[@depth-3] > 0) {
                printf("%s %s %d\n", @module[@depth-3], @sub[@depth-3], @line[@depth-3]);
        }
}

END { clear(@module); clear(@sub); clear(@line); }
'
```

## [Using uwsgi_request on new request](#using-uwsgi-request-on-new-request)

```
sudo bpftrace -e '
struct uwsgi_request {
    char padding[192];
    char *uri;
    uint16_t uri_len;
};


uprobe:/usr/lib64/libperl.so:psgi_response {
    printf("%s\n", str(((uwsgi_request*)arg0)->uri));
}
' -v
```

## [Enabling perldtrace](#enabling-perldtrace)

Some simple commands to install bpftrace:

Note: make sure that your kernel is >= 4.19. Things doesn't work as smooth for lower kernel versions.

```
sudo yum install bpftrace "kernel-devel-uname-r == $(uname -r)"
```
