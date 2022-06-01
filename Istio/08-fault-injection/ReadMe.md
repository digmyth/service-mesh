# 故障注入
- 延迟故障： 延迟后策略是超时
- 中断故障： 中断后策略是重试

# 代码说明
```
   fault:
      abort:
        percentage:
          value: 20
        httpStatus: 555
  - name: default
    route:
    - destination:
        host: demoapp
        subset: v10
    fault:
      delay:
        percentage:
          value: 20
        fixedDelay: 3s
```

#  验证


# 总结
无
