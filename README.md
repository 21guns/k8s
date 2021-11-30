# k8s

## 安装手册
	1.	https://kuboard.cn/install/install-k8s.html
	2.	https://github.com/opsnull/follow-me-install-kubernetes-cluster



## k8s-in-docker

### linux centos docker
	参考安装手册1
### build images
	docker build --rm -t 21guns.com/centos7-system .
### run centos
	start-docker-k8s-centos.sh

###  问题
	1.初始化master, 异常  unsupported graph driver: fuse-overlayfs
		https://stackoverflow.com/questions/67953609/overlay2-driver-not-supported
	2.swap disable
		docker 无法关闭交换空间
		解决办法：kubeadm init --ignore-preflight-errors=Swap
	3.kubelet 异常 Failed to get the container runtime's cgroup
		尝试 ：http://www.mydlq.club/article/80/

## k8s-in-vm
	参考安装手册2
### 0.准备
	下载centos 版本「Everything ISO」 http://isoredirect.centos.org/centos/7/isos/x86_64/	

### 1.virtualbox 设置
	Mac 采用无线 wifi 接入外网
	查询 Mac 接入 wifi 的网卡：ifconfig 命令，查询到是网卡 en0
	为虚拟机配置一个网卡：设置 - 网络 - 网卡2
	连接方式：桥接网卡
	界面名称：en0: Wi-Fi(AirPod)
	启动虚拟机：在虚拟机内部 ping baidu.com 测试网络连通性
![](./install-centos-on-virtualbox.png)

### 2.