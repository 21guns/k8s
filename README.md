# k8s


## k8s-in-docker

### linux centos docker
	https://kuboard.cn/install/install-k8s.html
### build images
	docker build --rm -t 21guns.com/centos7-system .
### run centos
	start-docker-k8s-centos.sh

###  问题
	1.初始化master, 异常  unsupported graph driver: fuse-overlayfs
		https://stackoverflow.com/questions/67953609/overlay2-driver-not-supported
	2.swap disable
		docker 无法关闭交换空间
		kubeadm init --ignore-preflight-errors=Swap
	3.kubelet 异常 Failed to get the container runtime's cgroup
		尝试 ：http://www.mydlq.club/article/80/

## k8s-in-vm

	https://k8s-install.opsnull.com/
	
### virtualbox install centos

