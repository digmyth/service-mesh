# 示例代码clone
[代码示例仓库](https://github.com/iKubernetes/knative-in-practise.git)


# 小记
- isto-ingressgateway  pods内的envoy默认只会生成与svc同名的cluster
- istio-egressgateway  pods内的envoy默认只会生成与svc同名的cluster
- 网格内部的sideCar envoy却会生成Lisenter、Routes、Cluster，所以默认可以直接访问
- 查看方法istioctl proxy-config listeners  xx_pod.xx_namespace

# 总结
马哥精品，必属精品
