### filebeat 收集容器日志

* 收集日志agent: 作用是收集并格化日志， 可以是fluentd,可以是fluent-bit,可以是轻量的filebeat,可以是重量级的logstash agent功能(logstash也有收集日志的agent收集功能和日志格式化，当然也可以用logstash日志格式化后再发送给elasticsearch集群以减轻日志聚合层压力)。

* 中间缓存层： 作用是减轻日志聚合层压力， 可以是redis, 可以是kafka,可以是flume,不过flume一般对接hdfs,也就是hadoop集群。
* 日志聚合层： 作用是日志聚合，日志丰富，日志格式化，可以是logstash server功能。
* elasticsearch: 作用是日志检索，日志存储。
* kibana:   作用是visulize界面展示。

由于是测试环境，这里利用filebeat收集容器宿主机下/var/lib/docker/containers/*/*.log日志直接发送给elasticsearch,最后通过kibana进行展示。

```
docker-compose up
docker-compose  -f xxx.yaml down --rmi local
docker-compose  -f xxx.yaml down  -v  #  同时删除容器卷
docker-compose  -f xxx.yaml rm
```

### 总结
1 多次修改docker-compose并多次执行docker-compose启动容器有可能造成容器卷数据混乱报错，可以执行docker-compose  -f xxx.yaml down  -v同时删除卷再up

2 多练习多总结，去日良多
