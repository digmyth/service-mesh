# 说明

- 部署了同一个应用，v10/v11两个版本
- 由于`destinationrule-demoapp.yaml`定义了负载均衡器子集，所以两个版本应用的svc也不需要了，只要一个总的demoapp svc就可以了
- 前端再部署一个前端proxy服务用于接收请求后转发到URL http://demoapp 
- 访问http://proxy默认访问v10,  http://proxy/canary访问到v11

```
root@tnode01:~/demoapp# kubectl run client  --image=ikubernetes/admin-box -it --rm --restart=Never -n smi  --command -- /bin/bash
If you don't see a command prompt, try pressing enter.
root@client /#  curl  proxy   # v1.0
root@client /#  curl  proxy/canary v1.1
```

# 总结
在subset子集的加持下，就不必为每个demoapp版本创建一个svc


