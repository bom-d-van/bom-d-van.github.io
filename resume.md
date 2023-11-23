# Xiaofan Hu's Resume

## Summary

* Name: Xiaofan Hu
* Email: xiaofan.xhu@gmail.com
* Phone: +86 15224019502
* GitHub: https://github.com/bom-d-van
* Blog: https://www.xhu.buzz/

I'm seasoned and humbled software developer, with extensive experiences and skills of building systems (be it web applications or low level system tooling). I like solving hard problems and I enjoy meaningful works. I'm easy to talk to, extremely communicative, and supportive of colleagues and company strategies.

* Programming languages: Go, C, C++, Bash, Perl, Java, JS, Ruby, Python, Rust.
* Tech: Linux, TSDB (Graphite), SQL DB (MySQL/PostgreSQL), Kubernetes, Container/Docker, Redis, Ruby on Rails, EBPF, SLI/SLO, SRE, uWSGI, Puppet, Protobuf/GRPC, ReactJS/jQuery/Backbone/ExtJS/etc.

## September 2022 - Now (Deeproute.ai Shenzhen, China)

* Title: Senior Developer
* Company scale: 500+
* Tech: Go, Kubernetes, Traefik, External-DNS/dnscmd, PKCS11, OpenTelemetry, Salt, Terraform, MAAS, AliCloud

Achievements:

* Kubernetes Infra
  * Integrated Kubernetes Ingress DNS name registration in Private DNS server
    * Implemented a DNS server (as the rfc2136 provider for external-dns) running on a windows DNS server
  * Implemented infra and migrations logics of helm2 to helm3
  * Implemented microservice traffic routing (dabbed as "swimlane") using traefik IngressRoute on Kubernetes.
* Infra As Code (IAC) and Gitops
  * Implemented the infra IAC logics using saltstack for managing both on-board systems on autonomous vehicles and servers
  * Implemented a terraform DNS providers for DNS records provision
  * Extended the MAAS terraform provider to improve our internal IAC management process.
* Implemented a MTLS proxy daemon, root and device certificate protection using nvpkcs11.
* SRE duty: firefighting, server management, etc.
  * Identified and resolved a networking issues between 2 Kubernetes clusters (traced down packets being dropped on the client side due to NIC firmware bugs)
  * Debugged latency and connectivity issues of artifact repository tools like nexus and harbor
* Artifact Repository Management (Nexus and internal tooling)
  * Manage and scale nexus infra
  * Design and implemented a scalable apt/debian package repository (tinydeb)

## October 2017 - July 2022 (Booking.com Amsterdam, Netherlands)

* Title: Developer/Senior Developer
* Company scale: 2,000+ Tech/10,000+ Total
* Tech: Time Series Database, Go, Perl, Large Scale Distributed Systems, Site Reliability Engineering, Kubernetes, Helm, System Programming, Ansible, Puppet, Java

Achievements:

* Scaling large scale distributed time series systems (Graphite)
  * Scale: 1k+ servers, 1+ PB SSD storage, 500+ million uniq metrics, 2k+ QPS, 30m+ data points per second on ingestion.
  * Research, design and implement a new file format that enables compression, based on [the Facebook Gorilla compression algorithm](https://www.vldb.org/pvldb/vol8/p1816-teller.pdf) and achieves the disk space usage reduction of 30% - 70% (different cluster behaviors differently).
  * Design and implementing a new index algorithm by adopting [NFA+DFA algorithms introduced by Russ Cox](https://swtch.com/~rsc/regexp/regexp1.html) that is able to support 10 - 40 millions uniq metric paths with low indexing overhead and low tail latencies.
  * Design and implement a [lockless and concurrent trie indexing](https://www.xhu.buzz/ctrie/ctrie.html) that were able to reduce memory usage and supports real time indexing
  * Design and implement a highly performant [Quota subsystems](https://github.com/go-graphite/go-carbon/pull/420) that is able to reduce the noisy neighbor effect in a multi-tenant environment and achieves efficient resource management and control
  * Optimize the rebalance tool for the systems, by introducing [a self-regulated mechanism using health check and jitters](https://github.com/go-graphite/buckytools/pull/26), the changes has produced faster and adjustable sync rate and enhances observability.
* Scaling and maintaining a large scale distributed config management system
  * Scale: 8k RPS, 1300+ backend systems and 60k+ client end points depending on the system
  * Scaling the API backend to support high concurrency and high availability
  * Define and implement SLI and SLO metrics, including Availability, Propagation Latency, Error Rate, Request distributions across different backends and roles, etc.
  * Optimize Perl clients
* Site Reliability Engineering
  * Maintain multiple medium and small backend roles (servers ranging from 10 to 100s), debug production issues and being on-call.
  * Design and implement an internal auto-capacity testing system targeting envoy based systems by interacting with an internal control plane API.
  * Design and implement an uWSGI timeout callback mechanism for logging automation that's called [Graceful Harakiri](https://github.com/unbit/uwsgi/pull/2212).
  * Research and implement EBPF based tooling for [debugging production issues](https://www.xhu.buzz/bpftrace/debug_osq_lock.html)
  * Debug and resolve a [storage leakage Bug](https://github.com/hashicorp/vault/issues/11178) in Hashicorp Vault production system.
* Develop and scale a new fast partner signup channel/product.

## September 2016 - August 2017 (UCloud Shanghai, China)

* Title: Web Development Engineer
* Company scale: 500+
* Tech: Go, Bash, C++, Linux, TC, Networking, DPDK

Achievements:

Maintain and develop the traffic control system which is an important part of networking control, using C++,
Go, Bash etc. Responsibilities and Experiences included:

* Develop an accounting system for bandwidth usage monitoring and operations
* Use Quagga and Keepalived to implement Redis high availability across different data centers in the same region
* Develop new ingress traffic control feature in
* System problems on-call, writing up scripts for data consistency checking and log error monitoring

## May 2013 - August 2016 (The Plant Hangzhou, China/Tokyo, Japan)

* Title: Developer
* Company scale: 50+
* Tech: Go, Bash, Ruby on Rails, Linux

Achievements:

* Mainly worked and maintained two EC projects in Go and a few other smallish projects like product recommendations (by using Mahout), and a react project. Responsibilities and Experiences included:
  * Research and implement a [3D Bin Packing](https://github.com/bom-d-van/binpacking) algorithm and achieves optimized packaging cost estimation
  * Order and Payment(first GMO, then migrated to Stripe) User register/login, products management
  * Memory leak problem fixes
  * Unit/Integration tests
  * System deployment and maintenance etc
* Worked on Qortex, a communication platform designed and made for high performance teams. Experiences and Personal highlights included:
  * VirtualBox Packaging with auto-updates support for Enterprise users
  * Go package management (Pak)
  * Deployment/migration automation script (developed later into Harp)
  * Email processing/sending (Beanstalkd, SMTP)
  * Chatting (Ejabberd Integration) API maintenance

## May 2010 - Feb 2013 Student Developer in Wando Lab, HuiZhou University

Involved in the design and development of two ERP (Enterprise Resource Planning) systems in RoR and Ext JS. It's a great learning experience and an excellent environment for helping improve programming and collaboration skills.

## Open Source Projects

* [Go-Carbon](https://github.com/go-graphite/go-carbon): Graphite Storage in Go.
* [Harp](https://github.com/bom-d-van/harp): A Go application deployment tool.
* [3D Bin Packing](https://github.com/bom-d-van/binpacking): A Golang 3D Bin Packing Implementation
* [AssetTube](https://github.com/theplant/assettube): A tool for fingerprinting and serving asset files for Go Web applications.
* [CHTTP](https://github.com/bom-d-van/chttp): A stupid and incomplete http/http2 C implementation, built for learning C.
* [plperf](https://github.com/bom-d-van/plperf): A tracing program for uwsgi+perl environment, using ebpf and perl dtrace, in Go.
* [Pak](https://github.com/theplant/pak): A Go package version management tool.

## Education

Bachelor of Network Engineering, from September 2009 till June 2013, at Huizhou University of Guangdong China.
