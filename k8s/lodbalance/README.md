 ## 安装metriallb

 ```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.5/config/manifests/metallb-native.yaml

 ```
 
 ## 重启kube-proxy

 ```bash
 kubectl rollout restart daemonset  kube-proxy -n kube-system
 ```

 ## 示例

```
kubectl create ingress demo-localhost --class=nginx --rule="demo.localdev.me/*=demo:80"
```

## 卸载示例

```bash
 kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.14.5/config/manifests/metallb-native.yaml

```