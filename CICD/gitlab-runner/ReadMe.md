### 安装
安装gitlab-runner
```
https://docs.gitlab.com/runner/install/linux-repository.html
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
apt update
root@u22-025:~# apt-cache madison gitlab-runner
gitlab-runner |     15.3.0 | https://packages.gitlab.com/runner/gitlab-runner/ubuntu jammy/main amd64 Packages
gitlab-runner |     15.2.1 | https://packages.gitlab.com/runner/gitlab-runner/ubuntu jammy/main amd64 Packages
gitlab-runner |     15.2.0 | https://packages.gitlab.com/runner/gitlab-runner/ubuntu jammy/main amd64 Packages
gitlab-runner |     15.1.1 | https://packages.gitlab.com/runner/gitlab-runner/ubuntu jammy/main amd64 Packages
gitlab-runner |     15.1.0 | https://packages.gitlab.com/runner/gitlab-runner/ubuntu jammy/main amd64 Packages
gitlab-runner |     15.0.1 | https://packages.gitlab.com/runner/gitlab-runner/ubuntu jammy/main amd64 Packages
gitlab-runner |     15.0.0 | https://packages.gitlab.com/runner/gitlab-runner/ubuntu jammy/main amd64 Packages
root@u22-025:~# apt-get install gitlab-runner=15.2.0
```

注册gitlab-runner
```
token获取  gitlab your project/setting/cicd/runner
```
```
gitlab-runner  register --non-interactive --executor "shell"  --url http://gitlab.done.com:8085/  \
--registration-token "iKFYZpD3-a9tWDHdBGMn" --description"runner test" --tag-list  "build,deploy"  \
--run-untagged=true --locked=false --access-level "not_protected"
```

生成配置文件config.toml
```
root@gitlab:~# cat  /etc/gitlab-runner/config.toml
concurrent = 1
check_interval = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "runner test"
  url = "http://git02.done.com/"
  id = 1
  token = "j4AGhPAVHjYyc6gGPXX2"
  token_obtained_at = 2022-09-15T07:03:24Z
  token_expires_at = 0001-01-01T00:00:00Z
  executor = "shell"
  [runners.custom_build_dir]
  [runners.cache]
    [runners.cache.s3]
    [runners.cache.gcs]
    [runners.cache.azure]

```

### 使用
* 1  gitlab-runner机安装java，并/etc/profile配置JAVA_HOME
* 2  gitlab-runner机安装maven并修改阿里源
* 3  gitlab-runner机安装docker,并配置/etc/docker/certs.d证书和/home/gitlab-runner/.docker/config.json账号密码以push镜像到harbor仓库,usermod -aG docker gitlab-runner
* 4  gitlab-runner机安装argocd客户端命令
* 5  gitlab-runner机安装测试sudo -u gitlab-runner  -H docker info
* 6  编辑.gitlab-ci.yml测试，mvn,build,push,argocd sync 4个步骤串起来

###  总结
无
