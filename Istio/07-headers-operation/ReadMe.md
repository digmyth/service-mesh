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
- 请求报文带上标头，返回的报文也打上了x-canary-202: true-202 标头，成功的

```
root@client /# curl -I  -H  "x-canary: true" demoapp:8080
HTTP/1.1 200 OK
content-type: text/html; charset=utf-8
content-length: 113
server: envoy
date: Wed, 01 Jun 2022 11:37:16 GMT
x-envoy-upstream-service-time: 3
x-canary-202: true-202
```

- 浏览器类型是不是我们定义的,默认流量的User-Agent: curl/7.67.0, 匹配上特定标头流量会被重新改写user-agent, 验证成功的
```
root@client /# curl    demoapp:8080/user-agent
User-Agent: curl/7.67.0
root@client /# curl   -H  "x-canary: true" demoapp:8080/user-agent
User-Agent: Chrome
```

- 默认返回流量也带标头
```
root@client /# curl  -I   demoapp:8080/user-agent
HTTP/1.1 200 OK
content-type: text/html; charset=utf-8
content-length: 24
server: envoy
date: Wed, 01 Jun 2022 11:43:42 GMT
x-envoy-upstream-service-time: 33
x-envoy: test
```


# 总结
无
