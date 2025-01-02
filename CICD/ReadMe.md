根据马哥公开课学习书写

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
```
root@k8s-master:# cat 02-task-with-workspace.yaml
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: source-lister
spec:
  params:
  - name: git-repo
    type: string
    description: Git repository to be cloned
  workspaces:
  - name: source
  steps:
  - name: git-clone
    image: alpine/git:v2.36.1
    script: git clone -v $(params.git-repo) $(workspaces.source.path)/source
  - name: list-files
    image: alpine:3.16
    command:
    - /bin/sh
    args:
    - '-c'
    - 'ls $(workspaces.source.path)/source'
```

```
tkn  task start  --showlog xx -p git-repo="git@gitlab.xx.com/xx.git" -w name=source,emptyDir=""
tkn task start --showlog source-lister  -p git-repo="git@gitlab.done.com:gitlab-instance-047ae1d5/spring-helloworld.git" -w name=source,emptyDir="" -s build-bot
```

###  harbor认证
k8s node节点是docker虚拟化还好，这个按照harbor官方文档来就行，但是k8s node 是crio是不是懵逼了，这里经过验证其实是一样的，把在docker主机上的几个文件复制过来放好就行，就是这么简单
```
root@node01:~# tree  /etc/docker/
/etc/docker/
├── certs.d
│   └── harbor.done.com
│       ├── ca.cert
│       ├── ca.crt
│       ├── ca.key
│       ├── harbor.x.com.cert
│       ├── harbor.x.com.crt
│       ├── harbor.x.com.csr
│       ├── harbor.x.com.key
│       ├── tls-generate.sh
│       └── v3.ext
└── key.json
```

```
root@node01:~# tree  /root/.docker/
/root/.docker/
└── config.json
```

这样一样能认证到https://
```
crictl  pull  harbor.xxx.com/project01/spring-boot-helloworld:v0.9.2
```


