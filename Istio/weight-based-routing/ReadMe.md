#  清理redirect
清理redirect 对proxy内外规则的合并，再往下做实验，避免干扰
kubectl delete -f  05_url-redirect-and-rewrite/virtualservice-proxy.yaml  -n smi
kubectl apply -f 04-proxy-gateway/virtualservice-proxy.yaml -n smi

# 基于权重做流量分割配置
之前定义过同名的VirtualService, 叫name: demoapp, 现在virtualservice-demoapp.yaml里仅添加weight字段再apply复盖之前的VS即可
kubectl apply -f  06-weight-based-routing/virtualservice-demoapp.yaml -n smi 

# 测试


# 总结
无 
