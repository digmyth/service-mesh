# 故障注入
- 延迟故障： 延迟后策略是超时
- 中断故障： 中断后策略是重试

# 代码说明
```
   fault:
      abort:
        percentage:
          value: 20   # 百分之20流量发生中断故障
        httpStatus: 555
  - name: default
    route:
    - destination:
        host: demoapp
        subset: v10
    fault:
      delay:
        percentage:
          value: 20   # 百分之20流量发生延迟故障
        fixedDelay: 3s
```

# 在proxy Envoy设置服务任性容错策略
```
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: proxy
spec:
  hosts:
  - "fe.magedu.com"                     # 对应于gateways/proxy-gateway
  gateways:
  - istio-system/proxy-gateway       # 相关定义仅应用于Ingress Gateway上
  #- mesh
  http:
  - name: default
    route:
    - destination:
        host: proxy
    timeout: 1s
    retries:
      attempts: 5
      perTryTimeout: 1s
      retryOn: 5xx,connect-failure,refused-stream

```

# 验证


# 总结
无
