FROM centos:7.8.2003
ENV container docker


RUN export REGISTRY_MIRROR=https://registry.cn-hangzhou.aliyuncs.com \
	&& curl -sSL https://kuboard.cn/install-script/v1.22.x/install_kubelet.sh | sh -s 1.22.3
RUN curl -fsSL https://get.docker.com/ | sh \
	&& systemctl enable docker.service 

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
