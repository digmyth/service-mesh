#  场景说明
仅是类似客户端、前端应用、后端应用的逻辑例子

```
kubectl apply -f 01-demoapp-deploy.yaml
kubectl apply -f 02-deploy-proxy.yaml
```

# 网格内验证
网格内启动一个容器当客户端发起请求
```
# kubectl run client  --image=ikubernetes/admin-box -it --rm --restart=Never -n smi  --command -- /bin/bash
If you don't see a command prompt, try pressing enter.
root@client /#  curl demoappv10:8080
iKubernetes demoapp v1.0 !! ClientIP: 127.0.0.6, ServerName: demoappv10-75db87664c-dfdbl, ServerIP: 10.244.1.133!
root@client /# curl 127.0.0.1:15000/listeners
root@client /# curl 127.0.0.1:15000/clusters
root@client /# while true;do curl demoappv10:8080;sleep 0.$RANDOM;done  #  回到kiali看图

root@client /# while true;do curl proxy/hostname ;sleep 0.$RANDOM;done
```

# 总结
无
