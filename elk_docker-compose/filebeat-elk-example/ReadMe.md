### filebeat 收集容器日志

* 收集日志agent: 作用是收集并格化日志， 可以是fluentd,可以是fluent-bit,可以是轻量的filebeat,可以是重量级的logstash agent功能(logstash也有收集日志的agent收集功能和日志格式化，当然也可以用logstash日志格式化后再发送给elasticsearch集群以减轻日志聚合层压力)
* 中间缓存层： 作用是减轻日志聚合层压力， 可以是redis, 可以是kafka,可以是flume,不过flume一般对接hdfs,也就是hadoop集群
* 日志聚合层： 作用是日志聚合，日志丰富，日志格式化，可以是logstash server功能
* elasticsearch: 作用是日志检索，日志存储
* kibana:   作用是visulize界面展示

由于是测试环境，没有在收集日志agent与
