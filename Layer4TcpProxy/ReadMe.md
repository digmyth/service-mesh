##  envoy4层代理
这里是envoy 入门基础教程，示例为第一个demo示例，这个示例中docker-compose up启动起来后，直接curl  envoy_ip:80就会反向代理至8081 应用服务，说明代理是成功的

除了TcpProxy代理，还有MySQLProxy代理，相应代码片段
```
    filter_chains:
    - filters:
      - name: envoy.filters.network.mysql_proxy
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.filters.network.mysql_proxy.v3.MySQLProxy
          stat_prefix: egress_mysql
      - name: envoy.filters.network.tcp_proxy
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.filters.network.tcp_proxy.v3.TcpProxy
```
