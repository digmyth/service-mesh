# 场景说明
简单地把一个网格内应用发布到网格外， 用域名接入外部流量的初学例子

# 例子中的绑定IP
例子中的svc开放到外网，除了NodePort外，还有可以添加externalIPs实现，此IP绑定域名kiali.done.com就可以访问了
```
# kubectl edit  svc/istio-ingressgateway -n istio-system
spec:
  allocateLoadBalancerNodePorts: true
  clusterIP: 10.111.198.43
  clusterIPs:
  - 10.111.198.43
  externalIPs:
  - 10.18.0.148
  externalTrafficPolicy: Cluster
  internalTrafficPolicy: Cluster
  ipFamilies:
```

# 基本操作
```
kubectl get crds 
kubectl api-resources
kubectl api-resources --api-group=networking.istio.io
kubectl explain gw.spec    # servers定义侦听器
kubectl get pods -n istio-system --show-labels | grep gateway
istioctl apply -f kiali-gateway.yaml
istioctl proxy-status
ingw=(kubectl get pods -n istio-system -l app=istio-ingressgateway -o jsonpath={.items[0].metadata.name})
istioctl proxy-config  listeners $ingw.istio-system
istioctl proxy-config  routes $ingw.istio-system
```

# virtual Service
```
#  virtual Service用于定义ingressgateway中的哪一个虚拟主机
kubectl explain vs.spec
有gateways字段代表vs生效范围仅网格入口gateway,无gateways字段代表vs生效范围仅网格内部，以下定义代表即生效于网格入口gateway,又生效网格内部
# gateways:
    - kiali-gateway
    - mesh
```

#destination.Rule
```
spec.http.route.destination.host代表svc所组成的cluster,与k8s svc同名（因为在网格内k8s svc会自动生成Listener[ingressgateway除外]、Cluster）
可以看出网格内DestinationRule本身默认存在，只有在实现高级网络流量管理功能时才需明确定义出destinationRule

```
# 命令
```
# kubectl get vs -n istio-system
istioctl proxy-config  routes $ingw.istio-system


##
kubectl create ns smi
kubectl label namespace smi istio-injection=enabled
kubectl create deployment demoappv10 --image=ikubernetes/demoapp:v1.0 --replicas=3 --dry-run=client -o yaml
kubectl create service clusterip demoappv10 --tcp=8080:8080 --dry-run=client -o yaml
```
# 总结
kubectl apply -f . 代码中的例子，通过域名kiali.done.com可访问到 kiali UI
