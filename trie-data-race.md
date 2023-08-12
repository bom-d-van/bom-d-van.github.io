
# data race, memory barrier, cache coherence, and friends/enemies

## articles

* [Benign Data Races: What Could Possibly Go Wrong?](http://web.archive.org/web/20200221181312/https://software.intel.com/en-us/blogs/2013/01/06/benign-data-races-what-could-possibly-go-wrong)
* [Dealing with Benign Data Races the C++ Way](https://bartoszmilewski.com/2014/10/25/dealing-with-benign-data-races-the-c-way/)
* [Position Paper: Nondeterminism is unavoidable, but data races are pure evil](https://www.hpl.hp.com/techreports/2012/HPL-2012-218.pdf)
* [Race Condition vs. Data Race](https://blog.regehr.org/archives/490)
* [A Deep Dive into Database Concurrency Control](https://www.alibabacloud.com/blog/a-deep-dive-into-database-concurrency-control_596779)
* [Atomic vs. Non-Atomic Operations](https://preshing.com/20130618/atomic-vs-non-atomic-operations/)
* https://stackoverflow.com/questions/61914041/what-happens-when-reading-or-writing-concurrently-without-a-mutex
* https://stackoverflow.com/questions/2599238/are-memory-barriers-necessary-for-atomic-reference-counting-shared-immutable-dat
* [Lock-Free Code: A False Sense of Security](http://www.talisman.org/~erlkonig/misc/herb+lock-free-code/p1-lock-free-code--a-false-sense-of-security.html)

* [Write barriers in the Go garbage collector](https://ihagopian.com/posts/write-barriers-in-the-go-garbage-collector/)

* [If aligned memory writes are atomic, why do we need the sync/atomic package?](https://dave.cheney.net/2018/01/06/if-aligned-memory-writes-are-atomic-why-do-we-need-the-sync-atomic-package)

* [Memory Ordering in Modern Microprocessors, Part I](https://www.linuxjournal.com/article/8211)

## random discussions

* [doc: define how sync/atomic interacts with memory model #5045](https://github.com/golang/go/issues/5045)
