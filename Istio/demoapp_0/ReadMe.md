# 使用
```
kubectl apply -f 01-demoapp-deploy.yaml
kubectl apply -f 02-deploy-proxy.yaml
# kubectl run client  --image=ikubernetes/admin-box -it --rm --restart=Never -n smi  --command -- /bin/bash
If you don't see a command prompt, try pressing enter.
root@client /#  curl demoappv10:8080
iKubernetes demoapp v1.0 !! ClientIP: 127.0.0.6, ServerName: demoappv10-75db87664c-dfdbl, ServerIP: 10.244.1.133!
root@client /# curl 127.0.0.1:15000/listeners
root@client /# curl 127.0.0.1:15000/clusters
root@client /# while true;do curl demoappv10:8080;sleep 0.$RANDOM;done  #  回到kiali看图

#  curl  proxy  #  一样可以访问
```

# 总结
无
