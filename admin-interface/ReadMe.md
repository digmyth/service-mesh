##  envoy管理接口
```
[root@k8smaster admin-interface-ingress]# curl 192.168.1.40:8001/help
admin commands are:
  /: Admin home page
  /certs: print certs on machine
  /clusters: upstream cluster status
  /config_dump: dump current Envoy configs (experimental)
  /contention: dump current Envoy mutex contention stats (if enabled)
  /cpuprofiler: enable/disable the CPU profiler
  /drain_listeners: drain listeners
  /healthcheck/fail: cause the server to fail health checks
  /healthcheck/ok: cause the server to pass health checks
  /heapprofiler: enable/disable the heap profiler
  /help: print out list of admin commands
  /hot_restart_version: print the hot restart compatibility version
  /init_dump: dump current Envoy init manager information (experimental)
  /listeners: print listener info
  /logging: query/change logging levels
  /memory: print current allocation/heap usage
  /quitquitquit: exit the server
  /ready: print server state, return 200 if LIVE, otherwise return 503
  /reopen_logs: reopen access logs
  /reset_counters: reset all counters to zero
  /runtime: print runtime values
  /runtime_modify: modify runtime values
  /server_info: print server version/status information
  /stats: print server stats
  /stats/prometheus: print server stats in prometheus format
  /stats/recentlookups: Show recent stat-name lookups
  /stats/recentlookups/clear: clear list of stat-name lookups and counter
  /stats/recentlookups/disable: disable recording of reset stat-name lookup names
  /stats/recentlookups/enable: enable recording of reset stat-name lookup names
```

```
curl 192.168.1.40:8001/server_info
 "node": {
  "id": "",
  "cluster": "",
  "dynamic_parameters": {},
  "user_agent_name": "envoy",
  "user_agent_build_version": {
   "version": {
    "major_number": 1,
    "minor_number": 18,
    "patch": 3
   },
   "metadata": {
    "ssl.version": "BoringSSL",
    "revision.status": "Clean",
    "revision.sha": "98c1c9e9a40804b93b074badad1cdf284b47d58b",
    "build.type": "RELEASE"
   }
   。。。
```

```
curl 192.168.1.40:8001/stats
cluster.web_cluster.circuit_breakers.high.cx_open: 0
cluster.web_cluster.circuit_breakers.high.cx_pool_open: 0
cluster.web_cluster.circuit_breakers.high.rq_open: 0
cluster.web_cluster.circuit_breakers.high.rq_pending_open: 0
cluster.web_cluster.circuit_breakers.high.rq_retry_open: 0
cluster.web_cluster.default.total_match_count: 44
cluster.web_cluster.lb_healthy_panic: 0
cluster.web_cluster.lb_local_cluster_not_ok: 0
cluster.web_cluster.lb_recalculate_zone_structures: 0
cluster.web_cluster.lb_subsets_active: 0
cluster.web_cluster.lb_subsets_created: 0
cluster.web_cluster.lb_subsets_fallback: 0
```

```
curl 192.168.1.40:8001/stats?format=json
curl 192.168.1.40:8001/stats?format=prometheus
curl 192.168.1.40:8001/stats?filter=^listener
curl 192.168.1.40:8001/stats?filter=^cluster
```
这里我把管理接口地址设为0.0.0.0并映射宿主机端口进行外部访问，这是不安全的做法，因为这个管理接口拥有对集群的删除添加功能权限极高
