### 测试过程

由于是ingress,直接访问envoy中定义的envoy_ip:80端口即可
```
cd service-mesh/http-ingress;  docker-compose up 
[root@k8smaster http-ingress]# docker exec httpingress_envoy_1  ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
131: eth0@if132: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP 
    link/ether 02:42:ac:1d:00:02 brd ff:ff:ff:ff:ff:ff
    inet 172.29.0.2/16 brd 172.29.255.255 scope global eth0
       valid_lft forever preferred_lft forever
[root@k8smaster http-ingress]# curl 172.29.0.2 
This is a website server by a Go HTTP server.
[root@k8smaster http-ingress]# curl 172.29.0.2/hostname
Hostname: 6c2bbe9e367f.
```
