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
gitlab-runner  register --non-interactive --executor "shell"  --url http://gitlab.done.com:8085/  --registration-token "iKFYZpD3-a9tWDHdBGMn" --description"runner test" --tag-list  "build,deploy" --run-untagged=true --locked=false --access-level "not_protected"
```


### 使用



###  总结
无
