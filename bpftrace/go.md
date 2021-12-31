[Index](https://www.xhu.buzz/)

# Using bpftrace on Go programs

This is a simple post about a few insights and tricks when using bpftrace to debug a Go program with uprobe.

A simple bpftrace program targeting go program could look like this:

```bash
bpftrace -e 'uprobe:$binary_path:$func_symbol_name {
    printf("%d\n", sarg0)
}'
```

There are two parts that we need to figure out when writing a bpftrace script for Go program:

1. Target symbol name
2. Arguments order and its memory layout on the stack

## Target symbol name

Unlike c programs, after compilation, a function or method name in a Go program could become somewhat complex like: `github.com/hashicorp/vault/vault.(*BarrierView).Put`.

It could be tricky to write it all out. One trick is to use readelf or objdump to list the interested funcs or methods and just copy it:

```bash
$ readelf -sW /bin/vault | grep -i BarrierView
...
210267: 0000000003be6c00   331 FUNC    GLOBAL DEFAULT    1 github.com/hashicorp/vault/vault.(*BarrierView).Put
...
```

## Arguments: order and memory layout

Arguments are passed over the stack, accessed by bpftraace keywords like: sarg0, sarg1, etc. (This might not be true for future version of Go as the language is also moving to a register-based calling convention, with this coming changes, we can use regular accessor like arg0.)

Non-primitive types like string, struct, slice, and interface, if not pointer, is the same as passing as multiple arguments to the function or method. The number of the actual arguments depends on how many members with in a struct, sliceHeader, etc.

Method is like function, but with the receiver as the first argument.

Order of the arguments is started from left to right in the source code definition, and zero-indexed.

uretprobe is currently not safe to use due to Go runtime dynamically resizes stack.

## Pseudo-code example

```
type StringHeader struct {
    Data uintptr
    Len  int
}

func fooStr1(str string) { ... }
func fooStr2(data *byte, len int) { ... }

type SliceHeader struct {
    Data uintptr
    Len  int
    Cap  int
}

func fooSlice1(slice []int) { ... }
func fooSlice2(data *int, len, cap int) { ... }

type interfaceHeader struct {
    tab  uintptr
    data uintptr
}

func fooInterface1(ctx context.Context) { ... }
func fooInterface1(tab, data uintptr) { ... }
```

In the above pseudo-code, fooStr1 has the same function signatures as fooStr2, so do fooSlice1 and fooSlice2, fooInterface1 and fooInterface2.

```
type foo struct {
  p1 int
  p2 int
}

func fooPtr(f *foo, a1 int) (r1 int) { ... }
func (f *foo) ptr(a1 int) (r1 int) { ... }

func fooPlain(f foo, a1 int) (r1 int) { ... }
func (f foo) plain(a1 int) (r1 int) { ... }
```

In the example above, after compilation, fooPtr has the same functional signature as foo.Ptr does. Same for fooPlain and foo.Plain.

For the fooPlain and (f foo).plain above, the order of their arguments on the stack would looks like this:

```
// 0x40
//      <- r1
// 0x38
//      <- a1     (sarg2)
// 0x30
//      <- foo.p2 (sarg1)
// 0x28
//      <- foo.p1 (sarg0)
// 0x20
```

## Real world example

The function signatures and struct definitions bellow are taken from https://github.com/hashicorp/vault.

```
// func (v *BarrierView) Put(ctx context.Context, entry *logical.StorageEntry) error
//
// type StorageEntry struct {
//	Key      string
//	Value    []byte
//	SealWrap bool
// }

The bpftrace script bellow would trace every function calls to BarriwerView.Put and prints out the arguments.
sudo BPFTRACE_STRLEN=164 bpftrace -e '
    struct storage_entry {
        char* key;
        uint64_t klen;
        char* value;
        uint64_t vlen;
        uint64_t vcap;
    };

    // sarg0 is *BarrierView
    // sarg1,2 is context.Context
    uprobe:/bin/vault:"github.com/hashicorp/vault/vault.(*BarrierView).Put" {
        printf(
            "BarrierView.Put: %s\n",
            str(
                ((struct storage_entry*)sarg3)->key,
                ((struct storage_entry*)sarg3)->klen
            )
        );
    }

    uprobe:/bin/vault:"github.com/hashicorp/vault/vault.(*BarrierView).Put" {
        printf(
            "BarrierView.Put: %s\n",
            str(
                ((struct storage_entry*)sarg3)->value,
                ((struct storage_entry*)sarg3)->vlen
            )
        );
    }
'

# example output
#
# BarrierView.Put: h8fcaf0c55276ff6024bcef153a5e1ed8fb6ae19694dd0c20da8f61d6edd4bc10
# BarrierView.Put: {"lease_id":"auth/container/approle/login/xxx","client_token":"xxx","token_typ
# ...
```

References:

* https://github.com/iovisor/bpftrace/blob/master/docs/reference_guide.md
* https://research.swtch.com/interfaces
