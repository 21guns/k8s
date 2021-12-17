docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.21.5
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.21.5
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.21.5
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.21.5
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.4.1
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:v1.8.0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.13-0
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.21.5 k8s.gcr.io/kube-apiserver:v1.21.5
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.21.5 k8s.gcr.io/kube-scheduler:v1.21.5
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.21.5 k8s.gcr.io/kube-proxy:v1.21.5
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.21.5 k8s.gcr.io/kube-controller-manager:v1.21.5
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.4.1 k8s.gcr.io/pause:3.4.1
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:v1.8.0 k8s.gcr.io/coredns:v1.8.0
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.13-0 k8s.gcr.io/etcd:3.4.13-0
