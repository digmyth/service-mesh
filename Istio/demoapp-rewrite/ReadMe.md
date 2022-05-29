# rewrite和redirect区别
- rewrite重写由服务端完成，浏览器无感知的，透明的，客户端不需要做什么就能拿到结果
- redirect重定向会返回301 永久重定向，302临时重定向，客户端拿到新的URL重新发起请求才能得到结果
- 注意：  curl命令面对redirect 无能为力，它不会重新发起请求来拿到结果，不过可以用curl -I 看返回的标头进行分析

#  部署backend服务
```
#kubectl apply -f  01-deploy-backend.yaml
# curl  http://backend:8082
```
# 部署新的 proxy virtualService
```
# kubectl  delete vs/proxy -n smi   # 此前定义过外部proxy vs,需要合并在新的vs里
# kubectl apply -f  02-virtualservice-proxy.yaml  -n smi  # 合并后的
```
# 验证
网格内部客户端容器
```
curl proxy
curl proxy/canary
curl -I proxy/backend   #  拿到重定向结果
```

网格外部
```
curl fe.doone.com
```

#  总结

无
