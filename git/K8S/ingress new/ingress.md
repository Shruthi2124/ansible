**NGINX ingress controller:**

**Install AKS using Az CLI**
**Install Helm :** 

```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
**Check Helm version:**
```
helm version
```
![preview](images/version.png)
![preview](images/helminstall.png)

**Install nginx ingress controller:** 
```
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm upgrade --install ingress-nginx ingress-nginx \
             --repo https://kubernetes.github.io/ingress-nginx \
             --namespace ingress-nginx --create-namespace
```
![preview](images/nginx%20ingress%20install.png)

Now apply deployment,service and ingress yaml files -
![preview](images/applied%20all%20yaml%20files.png)

To see storage class: 
![preview](images/storageclass.png)

Use any below commands: 
```
kubectl --namespace ingress-nginx get service
 kubectl --namespace ingress-nginx get services -o wide -w ingress-nginx-controller
```
![preview](images/get%20svc.png)
![preview](images/ip.png)
![preview](images/blue.png)
![preview](images/green.png)
![preview](images/orange.png)
![preview](images/red.png)

