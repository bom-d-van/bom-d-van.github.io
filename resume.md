# Xiaofan Hu's Resume

## Summary

* Name: Xiaofan Hu
* Email: xiaofan.xhu@gmail.com
* GitHub: https://github.com/bom-d-van
* Blog: https://www.xhu.buzz/

Graduate of HuiZhou University, majored in Network Engineering with a Bachelor of Science. Three and a half years of Go web application development, three years of Ruby on Rails experiences.

Skills: Go, Linux, C, Bash, SQL (MySQL/PostgreSQL), Redis, JS (ReactJS/jQuery/Backbone/ExtJS/etc), Ruby (RoR)
Experience, EBPF, SLO, SRE, EBPF, uwsgi, Perl

## October 2017 - July 2022 (Booking.com Amsterdam)

Title: Developer / Senior Developer

Keywords: Time Series Database, Go, Perl, Large scale distributed systems, Site Reliability Engineering, Kubernetes, Helm, System Programming

Achievements:

* Scaling large scale distributed time series systems (Graphite)
  * By adopting Facebook Gorilla compression algorithm, design and implement a new file format for compression that were able reduces disk space usage from 30% - 70%.
  * Design and implementing a new index algorithm by using [NFA+DFA algorithms introduced by Russ Cox](https://swtch.com/~rsc/regexp/regexp1.html) that is able to support 10 - 40 millions uniq metric paths with low indexing overhead and low tail latencies.
  * Introducing a quota subsystem for reliability and control that are able efficiently
* Scaling large scale distributed config management system
  * Scale the API backend to support 60k endpoints
  * Define and implement SLI and SLO for monitoring propagation latencies, usage and scale RPS on a per role basis.
* Site reliability engineering
  * uwsgi plugin
* Production Troubleshooting
* Push and scale a fast partner signup channel

## September 2016 - August 2017 (UCloud Shanghai)

Title: Web Development Engineer

Maintain and develop the traffic control system which is an important part of networking control, using C++,
Go, Bash etc. Responsibilities and Experiences included:

* Develop an accounting system for bandwidth usage monitoring and operations
* Use Quagga and Keepalived to implement Redis high availability across different data centers in the same region
* Develop new ingress traffic control feature in
* System problems on-call, writing up scripts for data consistency checking and log error monitoring

## September 2014 - March 2016 (The Plant Hangzhou) / March 2016 - August 2016 (The Plant Tokyo)

Title: Developer

Mainly Worked and maintained two EC projects in Go and a few other smallish projects like product recommendations (by using Mahout), and a react project. Responsibilities and Experiences included:

* 3D bin packing algorithm
* Order and Payment(first GMO, then migrated to Stripe) User register/login, products management
* Memory leak problem fixes
* Unit/Integration tests
* System deployment and maintenance etc

Product Links: https://analoguelife.com/ Aussie Parking: https://aussieparking.com.au/

## May 2013 - September 2014 (The Plant Hangzhou)

Title: Developer

Worked on Qortex, a communication web application designed and made for high performance teams. Experiences and Personal highlights included:

* VirtualBox Packaging with auto-updates support for Enterprise users Go package management (Pak)
* Deployment/migration automation script (developed later into Harp) Email processing/sending (Beanstalkd, SMTP)
* Chatting (Ejabberd Integration) API maintenance

Qortex Links: https://qortex.com/about https://qortex.com/enterprise

## May 2010 - Feb 2013 Student Developer in Wando Lab, HuiZhou University

Involved in the design and development of two ERP (Enterprise Resource Planning) systems in RoR and Ext JS. It's a great learning experience and an excellent environment for helping improve programming and collaboration skills.

## Open Source Projects

* Go-Carbon: Graphite Storage in Go.
* Harp: A Go application deployment tool.
* bin packing: A Golang 3D Bin Packing Implementation
* AssetTube: A tool fingerprinting and serving asset files for Go Web applications.
* CHTTP: A stupid and incomplete http/http2 C implementation, built for learning C.
* Pak: A Go package version management tool.
* plperf
