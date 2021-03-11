start :
	minikube start  --cache-images --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --image-mirror-country=cn --registry-mirror=https://dz1jvjkl.mirror.aliyuncs.com --iso-url=https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.16.0.iso  --kubernetes-version=v1.20.2 --alsologtostderr --vm-driver=hyperkit
	#  https_proxy=127.0.0.1:43129 --vm-driver=virtualbox
	# --extra-config=controller-manager.ClusterSigningCertFile="/Users/Arthur/.minikube/certs/ca.pem"
	# --extra-config=controller-manager.ClusterSigningKeyFile="/Users/Arthur/.minikube/certs/ca-key.pem"
	# @eval $(minikube docker-env)
	kubectl config use-context minikube
	minikube addons enable ingress
	minikube addons enable ingress-dns
	# minikube addons enable metrics-server
	# minikube addons enable freshpod
	minikube dashboard
addons:
	minikube addons enable metrics-server
	minikube addons enable freshpod
restart :
	minikube stop
	minikube start --registry-mirror=https://registry.docker-cn.com --vm-driver=hyperkit  --kubernetes-version v1.20.0  --alsologtostderr 
	kubectl config use-context minikube
	minikube dashboard
clean :
	@rm -rf ~/.minikube
stop :
	minikube stop
list : 
	minikube addons list
install :
	## Just for mac
	## curl -Lo minikube http://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/releases/v0.23.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
	## 手动下载 
	brew cask install minikube
ssh :
	minikube ssh
	# docker pull hub.c.163.com/allan1991/pause-amd64:3.0
	# docker tag hub.c.163.com/allan1991/pause-amd64:3.0 gcr.io/google_containers/pause-amd64:3.0
busybox:
	kubectl run busybox --image=busybox 
test-dns: busybox
	kubectl exec -ti busybox -- nslookup kubernetes.default
cleanK8sObj:
	kubectl delete $(kubectl get persistentvolume -o name)
	kubectl delete $(kubectl get deployment -o name)
	kubectl delete $(kubectl get replicationcontroller -o name)
	kubectl delete $(kubectl get cronjob -o name)
	kubectl delete $(kubectl get svc -o name)
	kubectl delete $(kubectl get po -o name)
	kubectl delete $(kubectl get jobs -o name)
