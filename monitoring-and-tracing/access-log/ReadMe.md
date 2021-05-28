### 开放envoy访问日志

开放envoy访问日志并格式化输出
```
filter_chains:
    - filters:
      - name: envoy.http_connection_manager
        typed_config:
          "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
          codec_type: auto
          access_log:
          - name: envoy.file_access_log
            typed_config: 
              "@type": type.googleapis.com/envoy.extensions.access_loggers.file.v3.FileAccessLog
              path: "/dev/stdout"
              json_format: {"start": "[%START_TIME%] ", "method": "%REQ(:METHOD)%", "url": "%REQ(X-ENVOY-ORIGINAL-PATH?:PATH)%", "protocol": "%PROTOCOL%", "status": "%RESPONSE_CODE%", "respflags": "%RESPONSE_FLAGS%", "bytes-received": "%BYTES_RECEIVED%", "bytes-sent": "%BYTES_SENT%", "duration": "%DURATION%", "upstream-service-time": "%RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)%", "x-forwarded-for": "%REQ(X-FORWARDED-FOR)%", "user-agent": "%REQ(USER-AGENT)%", "request-id": "%REQ(X-REQUEST-ID)%", "authority": "%REQ(:AUTHORITY)%", "upstream-host": "%UPSTREAM_HOST%", "remote-ip": "%DOWNSTREAM_REMOTE_ADDRESS_WITHOUT_PORT%"}
              #format: "[%START_TIME%] \"%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%\" %RESPONSE_CODE% %RESPONSE_FLAGS% %BYTES_RECEIVED% %BYTES_SENT% %DURATION% %RESP(X-ENVOY-UPSTREAM-SERVICE-TIME)% \"%REQ(X-FORWARDED-FOR)%\" \"%REQ(USER-AGENT)%\" \"%REQ(X-REQUEST-ID)%\" \"%REQ(:AUTHORITY)%\" \"%UPSTREAM_HOST%\" \"%DOWNSTREAM_REMOTE_ADDRESS_WITHOUT_PORT%\"\n"
          stat_prefix: ingress_http
```

测试过程： 
1 直接docker-compose up
2 找到front-envoy 容器IP
3 curl  frontenvoy_ip模拟访问产生日志
4 docker-compose终端界面看到产生的日志


### 总结
学习就好
