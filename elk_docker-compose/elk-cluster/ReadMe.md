###  elasticsearch kibana 集群部署


1.修改内核参数
```
sysctl -w  vm.max_map_count=655350
sysctl -w  fs.file-max=65536
```

2.编辑/etc/security/limits.conf 
```
*　　soft　　nofile　　65536
*　　hard　　nofile　　65536
*   soft    nproc    65535
*   hard    nproc    65535
*   soft    memlock  unlimited
*   hard    memlock  unlimited
```

3.其它优化项
```
echo 2048 > /proc/sys/net/core/somaxconn 每一个端口最大的监听队列的长度
echo never > /sys/kernel/mm/transparent_hugepage/enabled 关闭透明页功能
vm.max_map_count=655350      限制一个进程可以拥有的VMA(虚拟内存区域)的数量
fs.file-max = 65536     
```

4. 启动
```
docker-compuse  -f xxx.yaml up
http://ip:9200
http://ip:5601
```

```
docker-compose up
docker-compose  -f xxx.yaml down --rmi local
docker-compose  -f xxx.yaml down  -v
docker-compose  -f xxx.yaml rm
```

### 总结
当今软件部署方式千变万化，当需求是快速部署elasticsearch kibana集群，并且没有添加任何额外收集日志组件，干干净净，那么此docker-compose.yaml可用

