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
```
