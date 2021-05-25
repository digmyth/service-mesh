## 启动一个envoy
这里envoy.yaml其实是envoyproxy/envoy-alpine:v1.18.3镜像自己的envoy.yaml配置文件，拿出来学习使用

测试
```
docker run -d -it  --rm  --name  envoy-prod  envoyproxy/envoy-alpine:v1.18.3
docker exec  envoy-prod  ip a
curl  http://$envoy_ip:10000  就能代理跳转至定义的后端应用
```
