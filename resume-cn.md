# 胡小帆简历

## 基本信息

* 姓名：胡小帆
* 邮箱：xiaofan.xhu@gmail.com
* GitHub: https://github.com/bom-d-van
* 博客： https://www.xhu.buzz/

十年互联网工作经验，从五十多人的外包产品公司，到五百多人的云服务商，再到一万多人的大型互联网公司。我有从前端，中台，再到后端的开发经验。
目前我的工作重心主要放在高可用基础架构服务，数据库内核开发，和系统编程。

主要技术： Go, Linux, C, Bash, SQL (MySQL/PostgreSQL), Redis, JS (ReactJS/jQuery/Backbone/ExtJS/etc), Ruby (RoR)
Experience, EBPF, SLO, SRE, EBPF, uwsgi, Perl, Puppet

## 2017年10月 - 2022年7月 (Booking.com 荷兰阿姆斯特丹)

职位：研发/高级研发工程师

技术栈: Time Series Database, Go, Perl, Large scale distributed systems, Site Reliability Engineering, Kubernetes, Helm, System Programming, Ansible, Puppet

主要经验:

* 研发和维护高可用大型分布式时序数据库Go-Graphite（存储和查询方向）
  * 规模：1千多台服务器，1PB+ SSD，500万Metrics，2kQPS
  * 设计和实现了基于Facebook的Gorilla论文中描述的Gorilla[时序数据压缩算法的新存储文件结构](https://www.xhu.buzz/how-to-shrink-whisper-files/)，达到了30%-70%的压缩率。
  * 设计和实现了基于Russ Cox的DFA算法[Globbing查询算法的前缀树索引](https://www.xhu.buzz/to-glob-10m-metrics-using-trie-and-dfa/)，实现了高性能的索引效率和低延迟的查询，支持单台服务器高效索引10-40 Millions Metrics。
  * 设计和实现了[并发前缀树索引](https://www.xhu.buzz/ctrie/ctrie.html)，减少了数据库内存消耗，支持实时索引新数据
  * 设计和实现了高性能的[Quota子系统](https://github.com/go-graphite/go-carbon/pull/420)，减少了多租户系统中的Noisy Neighbour和实现有效资源管理和控制
* 扩展和维护高可用配置分发系统 (Scaling large scale distributed config management system)
  * 规模：8k RPS, 支持1300多个后端系统和6万多个客户端
  * 拓展API后端支持高并发和高可用
  * 定义和实行SLI和SLO，包括Avalability, Propagation Latency, Error Rate, 后端系统请求分布情况等
  * 优化Perl客户端
* Site reliability engineering
  * 运维管理多个中小型后端系统(规模从10到100多台服务器)，debug和oncall各种生产环境问题
  * 实现了针对公司内部envoy控制面的自动压测系统
  * 实现了uwsgi上超时回调机制用于收集线上系统[Graceful Harakiri](https://github.com/unbit/uwsgi/pull/2212)
  * 研发和使用EBPF工具debug[在线上产系统问题](https://www.xhu.buzz/bpftrace/debug_osq_lock.html)
  * Debug和Resolve了Hashicorp Vault系统的[Bug](https://github.com/hashicorp/vault/issues/11178)
* 研发和拓展新fast partner signup channel

## 2016年九月 - 2017八月 (UCloud 上海)

职位：研发工程师

* 维护和研发公司云平台的基于Linux tc的流量控制系统。
* 研发了带宽操作的对账系统。
* 使用Quagga和Keepalived实现了Redis的跨机房高可用
* 研发新的ingress流量控制下发服务
* 研发数据一致性检测的脚本和错误日志监控

## 2013年五月 - 2016八月 (The Plant 杭州/东京)

职位：研发工程师

Mainly Worked and maintained two EC projects in Go and a few other smallish projects like product recommendations (by using Mahout), and a react project. Responsibilities and Experiences included:

* 3D bin packing algorithm
* Order and Payment(first GMO, then migrated to Stripe) User register/login, products management
* Memory leak problem fixes
* Unit/Integration tests
* System deployment and maintenance etc

Product Links: https://analoguelife.com/ Aussie Parking: https://aussieparking.com.au/

Worked on Qortex, a communication web application designed and made for high performance teams. Experiences and Personal highlights included:

* VirtualBox Packaging with auto-updates support for Enterprise users Go package management (Pak)
* Deployment/migration automation script (developed later into Harp) Email processing/sending (Beanstalkd, SMTP)
* Chatting (Ejabberd Integration) API maintenance

Qortex Links: https://qortex.com/about https://qortex.com/enterprise

## 2010五月 - 2013二月 (惠州大学Wando实验室)

参与两个ERP系统的设计和研发。主要技术站是Ruby on Rails和ExtJS。

## Open Source Projects

* Go-Carbon: Graphite Storage in Go.
* Harp: A Go application deployment tool.
* bin packing: A Golang 3D Bin Packing Implementation
* AssetTube: A tool fingerprinting and serving asset files for Go Web applications.
* CHTTP: A stupid and incomplete http/http2 C implementation, built for learning C.
* Pak: A Go package version management tool.
* plperf
