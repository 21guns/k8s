#!/bin/bash

sudo su
# 允许远程密码登录
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config    
systemctl restart sshd.service
			
# echo "192.168.56.11 node1" >> /etc/hosts 
cat >> /etc/hosts <<EOF
192.168.56.11 node1
192.168.56.12 node2
192.168.56.13 node3
EOF
echo 'PATH=/opt/k8s/bin:$PATH' >>/root/.bashrc
source /root/.bashrc

# ssh-keygen -t rsa 
# ssh-copy-id root@node1
# ssh-copy-id root@node2
# ssh-copy-id root@node3
# 安装依赖包
yum install -y epel-release
yum install -y chrony conntrack ipvsadm ipset jq iptables curl sysstat libseccomp wget socat git

systemctl stop firewalld
systemctl disable firewalld
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat
iptables -P FORWARD ACCEPT

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab 

setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

cat > kubernetes.conf <<EOF
net.bridge.bridge-nf-call-iptables=1
net.bridge.bridge-nf-call-ip6tables=1
net.ipv4.ip_forward=1
net.ipv4.tcp_tw_recycle=0
net.ipv4.neigh.default.gc_thresh1=1024
net.ipv4.neigh.default.gc_thresh2=2048
net.ipv4.neigh.default.gc_thresh3=4096
vm.swappiness=0
vm.overcommit_memory=1
vm.panic_on_oom=0
fs.inotify.max_user_instances=8192
fs.inotify.max_user_watches=1048576
fs.file-max=52706963
fs.nr_open=52706963
net.ipv6.conf.all.disable_ipv6=1
net.netfilter.nf_conntrack_max=2310720
EOF
cp kubernetes.conf  /etc/sysctl.d/kubernetes.conf
sysctl -p /etc/sysctl.d/kubernetes.conf

timedatectl set-timezone Asia/Shanghai

systemctl enable chronyd
systemctl start chronyd

# 将当前的 UTC 时间写入硬件时钟
timedatectl set-local-rtc 0

# 重启依赖于系统时间的服务
systemctl restart rsyslog 
systemctl restart crond

systemctl stop postfix && systemctl disable postfix

mkdir -p /opt/k8s/{work,bin} /etc/{kubernetes,etcd}/cert

#升级内核
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
# 安装完成后检查 /boot/grub2/grub.cfg 中对应内核 menuentry 中是否包含 initrd16 配置，如果没有，再安装一次！
yum --enablerepo=elrepo-kernel install -y kernel-lt
# 设置开机从新内核启动
grub2-set-default 0

cp /home/vagrant/environment.sh /opt/k8s/bin/environment.sh
chmod +x /opt/k8s/bin/*

sync
reboot
