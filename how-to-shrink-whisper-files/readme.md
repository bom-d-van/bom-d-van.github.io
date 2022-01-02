# How to shrink whisper files for fun and profit

(originally written at June 17, 2019)

Table of Contents

* [What is a whisper file?](#what-is-a-whisper-file)
* [The Gorilla algorithm](#the-gorilla-algorithm)
* [Whisper + Compression = CWhisper](#whisper-compression-c-whisper)
  * [Why introduce blocks?](#why-introduce-blocks)
* [Tradeoff](#tradeoff)
* [Test result on production](#test-result-on-production)

The problem we’re trying to solve is making whisper files smaller. The profit we’ll get from doing this is increased storage capacity of our graphite clusters.

To achieve this, a new file format needs to be designed and implemented from scratch - writing bits rather than bytes to files.

The fun part? End results are very rewarding. Not only is disk space reduced by ~60% - ~55% (seen in different testing environments and with different XFS configurations), but server utilities are greatly increased as well (see production test below).

## [What is a whisper file?](#what-is-a-whisper-file)

[Whisper](https://graphite.readthedocs.io/en/latest/whisper.html) is a [fixed-size database](https://www.aosabook.org/en/graphite.html), similar in design and purpose to RRD (round-robin-database). It provides fast, reliable storage of numeric data over time. Whisper allows higher-resolution (seconds per point) recent data to degrade into lower resolutions, for long-term retention of historical data.

## [The Gorilla algorithm](#the-gorilla-algorithm)

Facebook's paper [Gorilla: A Fast, Scalable, In-Memory Time Series Database](https://www.vldb.org/pvldb/vol8/p1816-teller.pdf), introduced an algorithm for efficiently compressing time-series data. According to this paper, time-series data could be saved in 1.37 bytes per data point according, which when uncompressed is 16 bytes long in size (or 12 bytes if the timestamp is saved in 32 bits, like whisper. And yes, one more thing to fix before 2038).

Since its publication, this algorithm has been adopted by Prometheus, M3, and many other notable time-series databases. This makes it easier to adopt.

![](images/image2.png)

## [Whisper + Compression = CWhisper](#whisper-compression-c-whisper)

Main format changes:

* Data is divided into blocks within the same archive
* Larger header and indexes for archives and blocks
* Round-robin over blocks rather than data points
* Rolling CRC32 over headers/indexes and blocks

To illustrate the changes simply:

Original whisper file format:

![](images/image1.png)

Compressed whisper file format (detailed example):

![](images/image3.png)

### [Why introduce blocks?](#why-introduce-blocks)

The way the decompression algorithms work is by starting from the first data point. In order to read the 100th data point, all 99 data points before it need to be decompressed.

Therefore:

* Faster read (no need to decompress unnecessary data points)
* More resistant to disk corruptions (failures could be contained by block boundary)

## [Tradeoff](#tradeoff)

So what's the trade off we are making here in order to shrink files?

* Timestamps have to be increasing only
* Unlike standard format, old data points can't be easily rewritten by changing the timestamp in write requests because it's no longer data point addressable
* Data points are assumed as 2 bytes long at metric creation in CWhisper. But over time, if 2 bytes are not enough for the specified retention policy, then resizing is required and will be done automatically

## [Test result on production](#test-result-on-production)

The test result on one of our clusters is good and conclusive. It outperforms the classic whisper format on almost all grounds like disk space usage, cpu usage and memory usage - and even shorter time-to-disk if we compare servers hosting the same number of metrics:

| Metrics | Whisper (standard) | CWhisper (compressed) |
|---|---|---|
| Total Metrics | 50.6 Millions | 53.1 Millions |
| Num of Servers  | 32  | 9 |
| Disk Usage (45.75% less) | 32.28 TB | 14.77 TB |
| Total Disk Space (2.9TB Per Server) | 92.8 TB | 26.1 TB |
| Theoretical Capacity Per Server (Metrics) | ~4.5 Millions | ~10.43 Millions |

Source code:

* [go-whisper](https://github.com/go-graphite/go-whisper/)
* [CWhisper PR](https://github.com/go-graphite/go-whisper/pull/1)
