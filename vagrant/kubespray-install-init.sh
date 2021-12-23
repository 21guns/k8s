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
# DNS server
# cat >> /etc/resolv.conf <<EOF
# nameserver 8.8.8.8
# EOF

# 安装依赖包
# yum epel源:
yum install -y epel-release
# 使用阿里云yum源
# wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
# 网易yum源：
# wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo

# yum clean all
# yum makecache
yum install -y chrony conntrack ipvsadm ipset jq iptables curl sysstat libseccomp wget socat git


systemctl stop firewalld
systemctl disable firewalld
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat
iptables -P FORWARD ACCEPT

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab 

setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

timedatectl set-timezone Asia/Shanghai

systemctl enable chronyd
systemctl start chronyd

# 将当前的 UTC 时间写入硬件时钟
timedatectl set-local-rtc 0

# 重启依赖于系统时间的服务
systemctl restart rsyslog 
systemctl restart crond

systemctl stop postfix && systemctl disable postfix

#升级内核
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
# 安装完成后检查 /boot/grub2/grub.cfg 中对应内核 menuentry 中是否包含 initrd16 配置，如果没有，再安装一次！
yum --enablerepo=elrepo-kernel install -y kernel-lt
# 设置开机从新内核启动
grub2-set-default 0

sync
reboot
