# 场景说明
网格内客户端、前端应用(直接转发给后端来做模拟)、后端应用（多个版本便于定义destinationRule subset子集）的场景例子

- 部署了同一个应用，v10/v11两个版本
- 由于`destinationrule-demoapp.yaml`定义了负载均衡器子集，所以两个版本应用的svc也不需要了，只要一个总的demoapp svc就可以了
- 前端再部署一个前端proxy服务用于接收请求后转发到URL http://demoapp 
- 访问http://proxy默认访问v10,  http://proxy/canary访问到v11
- 文件编号0-7 用于网格内部访问
- 文件编号7-8 用于网格外部特定域名访问
```
root@tnode01:~/demoapp# kubectl run client  --image=ikubernetes/admin-box -it --rm --restart=Never -n smi  --command -- /bin/bash
If you don't see a command prompt, try pressing enter.
root@client /#  curl  proxy   # v1.0
root@client /#  curl  proxy/canary v1.1
```


# 外部特定域名访问
istio-ingressgateway定义
```
# cat 07-gateway-proxy.yaml
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: proxy-gateway
  namespace: istio-system        # 要指定为ingress gateway pod所在名称空间
spec:
  selector:
    app: istio-ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "fe.done.com"
```

istio-ingressgateway对应vs
```
# 08-virtualservice-proxy.yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: proxy
spec:
  hosts:
  - "fe.done.com"                     # 对应于gateways/proxy-gateway
  gateways:
  - istio-system/proxy-gateway       # 相关定义仅应用于Ingress Gateway上
  #- mesh
  http:
  - name: default
    route:
    - destination:
        host: proxy

```

应用下
```
kubectl apply -f  07-gateway-proxy.yaml   # istio-system名称空间
kubectl apply -f  08-virtualservice-proxy.yaml -n smi   # 网格名称空间
```
# 总结
* 在subset子集的加持下，就不必为每个demoapp版本创建一个svc
* 注意部署时有相应的网格名称空间

