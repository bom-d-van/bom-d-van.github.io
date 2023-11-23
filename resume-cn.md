# 胡小帆简历

## 基本信息

* 姓名：胡小帆
* 学历：惠州学院大学本科网络工程（2009年9月 - 2013年6月）
* 电话：+86 15224019502
* 邮箱：xiaofan.xhu@gmail.com
* GitHub: https://github.com/bom-d-van
* 博客： https://www.xhu.buzz/

我有近十年的互联网及软件开发和运维的工作经验，涵盖了前中后端，高可用，高流量分布式系统的开发和维护，既有从零到一实现项目的经验，也治理和拓展过大型分布式和复杂系统。

* 编程语言：Go, C, C++, Bash, Perl, Java, JS, Ruby, Python, Rust.
* 相关技术：Linux, TSDB (Graphite), SQL DB (MySQL/PostgreSQL), Kubernetes, Container/Docker, Redis, Ruby on Rails, EBPF, SLI/SLO, SRE, uWSGI, Puppet, Protobuf/GRPC, ReactJS/jQuery/Backbone/ExtJS/etc.

## 主要工作经验

## 2022年9月 - 现在 (元戎启行 中国深圳)

* 职位: 高级研发工程师
* 公司规模：400+研发
* 技术栈: Go, Kubernetes, Traefik, External-DNS/dnscmd, PKCS11, OpenTelemetry, Salt, Terraform, MAAS, AliCloud

主要经验:

* Kubernetes Infra
  * 通过dnscmd对接Windows DNS Server和External-DNS的rfc2136 provider的服务接口，实现K8S服务的域名在内网DNS服务器注册自动化
  * 将公司内部k8s项目使用的helm2升级到helm3，过程中需要设计和实现迁移逻辑和向后兼容现有部署逻辑
  * 通过Traefik IngressRoute实现微服务泳道功能
* Infra As Code (IAC) and GitOps
  * 设计和实现了通过saltstack同步管理车载系统和服务器系统的配置管理的Infra逻辑
  * 设计和实现了terraform dns provider用于管理内网和阿里云的内部域名
  * 拓展了terraform-maas支持更多的MAAS资源管理
* 设计和实现了一个MTLS服务代理，用于管理和使用通过nvpkcs11加解密的服务根证书和设备证书
* SRE duty: firefighting, server management, etc.
  * Debug K8S集群间的网络问题和IO问题（网卡固件bug和系统盘和数据盘无物理隔离）
  * Debug K8S服务的延时和连通性问题
* Artifact仓库管理 (Nexus和内部工具实现)
  * 管理托管于Nexus的Artifactory仓库，Debug各种服务问题和做水平扩容
  * 设计和实现一个更高性能的APT/Debian Package仓库(tinydeb)用于替换Nexus的APT仓库功能，有10倍以上的性能优化

### 2017年10月 - 2022年7月 (Booking.com 荷兰阿姆斯特丹)

* 职位：研发工程师/高级研发工程师
* 公司规模：2000+研发/10000+非研发
* 技术栈: Time Series Database, Go, Perl, C, Large Scale Distributed Systems, Site Reliability Engineering, Kubernetes, Helm, System Programming, Ansible, Puppet, Java

主要经验:

* 研发和维护高可用大型分布式时序数据库Go-Graphite（存储和查询方向）
  * 规模：1千多台服务器，PB级数据量(SSD)，5亿Unique Metrics (3 replicas)，2k+ QPS，3千万data points每秒的Ingestion
  * 设计和实现了基于[Facebook的Gorilla论文](https://www.vldb.org/pvldb/vol8/p1816-teller.pdf)中描述的Gorilla[时序数据压缩算法的新存储文件结构](https://www.xhu.buzz/how-to-shrink-whisper-files/)，达到了30%-70%的压缩率。
  * 设计和实现了基于Russ Cox的DFA算法的[Globbing查询算法的前缀树索引](https://www.xhu.buzz/to-glob-10m-metrics-using-trie-and-dfa/)，实现了高性能的索引效率和低延迟的查询，支持单台服务器高效索引10-40 Millions Metrics。
  * 设计和实现了[Lockless and concurrent 前缀树索引](https://www.xhu.buzz/ctrie/ctrie.html)，减少了数据库内存消耗，支持实时索引新数据
  * 设计和实现了高性能的[Quota子系统](https://github.com/go-graphite/go-carbon/pull/420)，减少了多租户系统中的Noisy Neighbour和实现有效资源管理和控制
  * 优化了集群Rebalancing tool，引入了[基于health check的自调节速率机制](https://github.com/go-graphite/buckytools/pull/26)，在避免导致服务器负载过高的情况下优化了sync的速率以及提高了系统可监控性。
* 扩展和维护高可用配置分发系统 (Scaling large scale distributed config management system)
  * 规模：8k RPS, 支持1300多个后端系统和6万多个客户端节点
  * 拓展API后端支持高并发和高可用
  * 定义和实行SLI和SLO，包括Availability, Propagation Latency, Error Rate, 后端系统请求分布情况等
  * 优化Perl客户端
* Site Reliability Engineering
  * 运维管理多个中小型后端系统(规模从10到100多台服务器)，debug和oncall各种生产环境问题
  * 实现了针对公司内部envoy控制面的自动压测系统
  * 实现了uwsgi上超时回调机制用于收集线上系统异常时间和日志：[Graceful Harakiri](https://github.com/unbit/uwsgi/pull/2212)
  * 研发和使用EBPF工具debug[在线上产系统问题](https://www.xhu.buzz/bpftrace/debug_osq_lock.html)
  * Debug和解决了Hashicorp Vault生产系统的[存储泄漏的Bug](https://github.com/hashicorp/vault/issues/11178)
* 研发和拓展新fast partner signup channel

### 2016年9月 - 2017年8月 (UCloud 中国上海)

* 职位：研发工程师
* 公司规模：500+
* 技术栈: Go, Bash, C++, Linux, TC, Networking, DPDK

主要经验:

* 维护和研发公司云平台的基于Linux tc的流量控制系统。
* 研发了带宽操作的对账系统。
* 使用Quagga和Keepalived实现了Redis的跨机房高可用
* 研发新的ingress流量控制下发服务
* 研发数据一致性检测的脚本和错误日志监控

### 2013年5月 - 2016年8月 (The Plant 中国杭州/日本东京)

* 职位：研发工程师
* 公司规模：50+
* 技术栈: Go, Bash, Ruby on Rails, Linux

主要经验:

* 研发和维护了两个电子商务相关的项目
  * 调研和实现了一个[3D Bin Packing](https://github.com/bom-d-van/binpacking)算法，自动化了打包成本计算并优于人工结果
  * 集成基于Mahout的产品推荐算法
  * 对GMO和Stripe的订单和支付系统的集成
  * 用户注册登陆，产品管理模块的研发
  * 生产系统的内存泄露问题的调查和解决
  * 单元测试和集成测试
  * 基于React的前端开发
* 办公协作系统Qortex的部分功能的开发
  * 基于Virtual Box的企业版系统的打包和部署的自动化
  * 开发和部署的自动化
  * 基于SMTP和Beanstalkd的邮件系统的集成和处理
  * 基于Ejabberd聊天子系统的集成和开发

### 2010年5月 - 2013年2月 (惠州学院Wando实验室)

参与两个ERP系统的设计和研发。主要技术栈是Ruby on Rails和ExtJS。

## 开源项目

* [Go-Carbon](https://github.com/go-graphite/go-carbon): Graphite Storage in Go.
* [Harp](https://github.com/bom-d-van/harp): A Go application deployment tool.
* [3D Bin Packing](https://github.com/bom-d-van/binpacking): A Golang 3D Bin Packing Implementation
* [AssetTube](https://github.com/theplant/assettube): A tool for fingerprinting and serving asset files for Go Web applications.
* [CHTTP](https://github.com/bom-d-van/chttp): A stupid and incomplete http/http2 C implementation, built for learning C.
* [plperf](https://github.com/bom-d-van/plperf): A tracing program for uwsgi+perl environment, using ebpf and perl dtrace, in Go.
* [Pak](https://github.com/theplant/pak): A Go package version management tool.
