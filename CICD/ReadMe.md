跟据马哥公开课学习书写

```
kubectl create secret generic ssh-secret  \
   --type='kubernetes.io/ssh-auth'  \
   --from-file=ssh-privatekey=/root/.ssh/id_rsa \
   --from-file=ssh-publickey=/root/.ssh/id_rsa.pub \
   --from-file=known_hosts=/root/.ssh/known_hosts \
   --dry-run=client -oyaml > secret.yaml
```

```
kubectl apply -f secret.yaml
```


```
tkn task list
tkn task start --showlog hello
tkn taskrun list
tkn taskrun logs xxx-taskrun
kubectl get taskrun/xxxx -o yaml

```
