###  elasticsearch kibana单点部署

```
docker-compose up
docker-compose  -f xxx.yaml down --rmi local
docker-compose  -f xxx.yaml down  -v
docker-compose  -f xxx.yaml rm
```

### 总结
当今软件部署方式千变万化，当需求是快速部署elasticsearch kibana单点，并且没有添加任何额外收集日志组件，干干净净，那么此docker-compose.yaml可用
