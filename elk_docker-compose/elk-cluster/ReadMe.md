## 基于docker-compose部署elk


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
