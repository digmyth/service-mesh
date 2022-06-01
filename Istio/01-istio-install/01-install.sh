
kubectl  apply -f  samples/sleep/sleep.yaml  -n smi

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml -n smi

kubectl  apply -f  samples/bookinfo/networking/bookinfo-gateway.yaml

cat samples/bookinfo/networking/bookinfo-gateway.yaml 
---
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: bookinfo-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway # use istio default controller
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "productpage.bookinfo.com"
---
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: bookinfo
  namespace: smi
spec:
  hosts:
  - "productpage.bookinfo.com"
  gateways:
  - istio-system/bookinfo-gateway
  http:
  - match:
    - uri:
        exact: /productpage
    - uri:
        prefix: /static
    - uri:
        exact: /login
    - uri:
        exact: /logout
    - uri:
        prefix: /api/v1/products
    route:
    - destination:
        host: productpage
        port:
          number: 9080
---

