# 代码说明
```
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: demoapp
spec:
  hosts:
  - demoapp
  http:
  - name: canary
    match:
    - headers:
        x-canary:
          exact: "true"   # 匹配来源标头带x-canary: true
    route:
    - destination:
        host: demoapp
        subset: v11
      headers:
        request:
          set:
            User-Agent: Chrome   #  路由到上游时添加User-Agent： Chrome标头
        response:
          add:
            x-canary-202: "true-202"    # 响应回客户端时添加标头
  - name: default
    headers:
      response:      # 默认响应回客户端时添加的标头
        add:
          X-Envoy: test
    route:
    - destination:
        host: demoapp
        subset: v10
```

# 验证

```
root@client /# curl -H  "x-canary: true" demoapp:8080
iKubernetes demoapp v1.1 !! ClientIP: 127.0.0.6, ServerName: demoappv11-77755cdc65-qljf8, ServerIP: 10.244.2.97!
root@client /#
```

# 总结
无
