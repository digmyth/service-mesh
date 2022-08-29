# Running on k8s
```
kubectl apply  -f  01-task-git-clone.yaml
kubectl apply  -f  02-task-source-build.yaml
kubectl apply  -f  03-task-build-image.yaml
kubectl apply  -f  04-pipeline-source-to-image.yaml
kubectl apply  -f  05-pipelinerun-source-to-image.yaml
```

注意：这里有2个问题
- 一个是kaniko访问harbor，默认需要kaniko提供harbor的ca.crt证书用发验证harbor发来的服务器端证书，可由参数取消验证解决
- 二个是kaniko需要解析harbor 域名才能上传镜镜，k8s默认不能解析外部域名，添加一个外部NDS服务器实现

```
# kubectl edit cm/coredns -n kube-system
apiVersion: v1
data:
  Corefile: |
    .:53 {
        errors
        health {
           lameduck 5s
        }
        ready


        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           fallthrough in-addr.arpa ip6.arpa
           ttl 30
        }
        prometheus :9153
        forward . /etc/resolv.conf {
           max_concurrent 1000
        }
        cache 30
        loop
        reload
        loadbalance
    }

    do.com:53 {
    errors
    cache 30
    forward . 10.18.0.151
    }
kind: ConfigMap
```

bind9实现外部DNS
```
cat /etc/bind/named.conf
include "/etc/bind/named.conf.default-zones";

cat /etc/bind/named.conf.default-zones
zone "do.com" {
     type master;
     file "/etc/bind/do.com";
};

cat /etc/bind/do.com
$TTL 1D
@       IN SOA  @  do.com.   (
              20181001        ; serial
                      1D      ; refresh
                      1H      ; retry
                      1W      ; expire
                      3H )    ; minimum
        NS      ns.do.com.
ns      A       10.18.0.151
www     A       10.18.0.151
mail    A       10.18.0.151
        MX 10   mail.do.com.
do.com.    A  10.18.0.151
harbor A 10.18.0.151

```

# test 
```
host -t A  harbor.done.com  dnsserver-ip
dig +short harbor.done.com  @dnsserver-ip
```

# Source to Image   from kaniko

### Kaniko
kaniko is a tool to build container images from a Dockerfile, inside a container or Kubernetes cluster.

kaniko doesn't depend on a Docker daemon and executes each command within a Dockerfile completely in userspace.
This enables building container images in environments that can't easily or securely run a Docker daemon, such as a standard Kubernetes cluster.

kaniko is meant to be run as an image: `gcr.io/kaniko-project/executor`.

#### Pushing to Docker Hub

Get your docker registry user and password encoded in base64

    echo -n USER:PASSWORD | base64

Create a `config.json` file with your Docker registry url and the previous generated base64 string

**Note:** Please use v1 endpoint. See #1209 for more details

```
{
	"auths": {
		"https://index.docker.io/v1/": {
			"auth": "xxxxxxxxxxxxxxx"
		}
	}
}
```

Configure credentials

    You can create a Kubernetes secret for your `~/.docker/config.json` file so that credentials can be accessed within the cluster.
    To create the secret, run:
        ```shell
        kubectl create secret generic docker-config --from-file=<path to .docker/config.json>
        ```

    **Note:** The type of secret must use generic, and must **not** be docker-registry.
    
 
