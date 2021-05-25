##  envoy egress proxy测试

[root@k8smaster http-egress]# docker exec    -it   httpegress_envoy_1   sh 
跟据语法定义访问ik8s.io 有多个后端应用，可以看出轮询效果
```
~ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
155: eth0@if156: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP 
    link/ether 02:42:ac:1f:00:04 brd ff:ff:ff:ff:ff:ff
    inet 172.31.0.4/16 brd 172.31.255.255 scope global eth0
       valid_lft forever preferred_lft forever
~ # curl  -H  "host: www.ik8s.io" 127.0.0.1
This is a website server by a Go HTTP server.
~ # curl  -H  "host: www.ik8s.io" 127.0.0.1/hostname
Hostname: 11bbc59d9753.
~ # curl  -H  "host: www.ik8s.io" 127.0.0.1/hostname
Hostname: 2a6eb8a78247.
```
跟据语法定义访问k8scast.cn 只有一个后端应用，不会有轮询效果

```
/ # curl  -H "host: www.k8scast.cn" 127.0.0.1
This is a website server by a Go HTTP server.
/ # curl  -H "host: www.k8scast.cn" 127.0.0.1/hostname
Hostname: 2a6eb8a78247.
/ # curl  -H "host: www.k8scast.cn" 127.0.0.1/hostname
Hostname: 2a6eb8a78247.
```
