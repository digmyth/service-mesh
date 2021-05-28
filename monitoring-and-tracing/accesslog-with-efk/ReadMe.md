### envoy 访问日志
accesslog-with-elk是把 front-envoy访问日志通过filebeat传送给elasticsearch,再通过kibana展示

工作流程： 
1  开放front-envoy日志输出
2  这个日志会记录到front-envoy容器内的日志文件
3  ront-envoy容器内的日志文件会被映射到宿主机/var/lib/docker/container/*/*.log envoy的日志文件
4  filebeat会把这些/var/lib/docker/container/*/*.log文件全部传送到elasticsearch
5  http://kibana_ip:5601 创建filebeat-* 索引， 返回discover就可以看到curl访问的日志

测试时需要找到front-envoy容器IP
```
[root@k8smaster accesslog-with-efk]# docker exec  accesslogwithefk_front-envoy_1  ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
463: eth0@if464: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP 
    link/ether 02:42:ac:1b:00:05 brd ff:ff:ff:ff:ff:ff
    inet 172.27.0.5/16 brd 172.27.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```

curl模拟访问过程产生日志
```
while true;do curl  -s 172.27.0.5;sleep 0.$[$RANDOM%10];done
```

最后就是可以看到curl访问 envoy产生的日志

### 总结
日后总结，学习
