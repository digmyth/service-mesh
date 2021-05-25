
## front-proxy示例
有时docker-compose.yaml的版本version: "3.3“有兼容性问题，可以跟据环境适当作出调整.

启动示例
```
docker-compose up -d
```

跟据docker-compose.yaml中的定义映射，可以在宿主机访问得到相应结果，说明代理成功
```
version: "3.3"
services:

  front-envoy:
    build:
      context: .
      dockerfile: Dockerfile-frontenvoy
    networks:
      - envoymesh
    ports:
      - "8080:8080"    # http://ip:8080/service/1
      - "8443:8443"    # https//ip:8443/service/1
      - "8001:8001"    # http://ip:8001  admin接口
```

## 参考

参考链接：  https://www.envoyproxy.io/docs/envoy/latest/start/sandboxes/front_proxy.html

所需配置文件除官方提供的下载链接外，完整可参考github envoy仓库
https://github.com/envoyproxy/envoy/tree/main/examples/front-proxy

