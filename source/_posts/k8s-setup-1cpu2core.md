---
title: 【k8s】搭 k8s 集群--使用 1核 和 2G 内存的机器
date: 2021-04-22 13:27:10
tags: [devops, k8s, howto]
---

本文先写主要流程，然后再写可能遇到的坑和解决方案。

## 低配置机器的注意事项

k8s 官网建议最低 2 核 2G 内存。
我跑的服务不多，压力也不大，不想多花钱升级机器。
用 1 核 2G 内存的机器安装。

创建集群的时候，k8s 会检查机器配置，如果低于 2 核 CPU 2G 内存，会报 warning 并停止安装。
用 ignore-preflight-errors 参数忽略 warning 即可。方法如下：

```bash
kubeadm init --ignore-preflight-errors=NumCPU
```

## 安装环境和结果

### 机器

阿里云 1 核 2G 内存。

### 安装结果

![](http://images.jackon.me/devops-k8s-install-result.png)

### 关键安装信息

1. 操作系统：ubuntu 20.04，
2. 用 kubeadmin 安装 v1.21，
3. Pod network add-on 使用 calico
4. pod-network-cidr=192.168.9.0/16。
5. kube 配置: /etc/kubernetes/admin.conf


## 安装步骤

### 1. 安装 ubuntu 20.04

假定已经准备好了操作系统，本文不展开。

[TODO] ubuntu 安装教程

### 安装 docker

跟着 docker 官网操作即可。

[https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)

我的版本信息：`Docker version 20.10.6, build 370c289`

主要命令：

```bash
 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io
```

### 安装 kubeadm

跟着 k8s 官网操作即可

[https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

装了 3 个东西：

- kubeadm
- kubectl
- kubelet

版本均为：1.21.0-00

### 用 kubeadm 创建集群

顺利了就一个 kubeadm init 命令。

但，天朝的网络环境不会顺利。要从 Google 的镜像仓库拉东西。
如果你也踩到了这个坑，本文后面的 踩坑记录 有解决细节。

拉镜像之外的事情，跟着 k8s 官网操作即可

[https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)


### 安装 Calico

这个 k8s 官网说的不清楚，推荐了一堆开源选项，新手基本要懵逼。

我选了 Calico，操作跟着 Calico 官网文档即可：

[https://docs.projectcalico.org/getting-started/kubernetes/quickstart](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)

注意，安装 calico 其实就是 apply 2 个 yaml 到 k8s 里。
第二个 yaml 需要改 CIDR，跟自己前面配的一致，然后再 apply。


## 踩坑备注

### docker 配置更新

systemd 是 k8s 推荐的，在 kubeadm 安装文档里有说明

阿里云 docker 镜像的文档：

[https://help.aliyun.com/document_detail/60750.html](https://help.aliyun.com/document_detail/60750.html)

2 个修改做完的 /etc/docker/daemon.json 内容如下

(阿里镜像，域名里的 a10q86at 要换成自己的)

```javascript
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "registry-mirrors": ["https://a10q86at.mirror.aliyuncs.com"]
}
```

重启 docker 使配置生效

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

### apt 源改国内

默认的 apt 源在国外，太慢了。

```bash
# use aliyun mirror. ubuntu 20.04
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list
```

### 天朝拉 kubeadm 用的镜像

默认先从 google 的镜像仓库拉镜像，天朝网络不通。可以换个镜像仓库。

我换成了阿里云的，但阿里的镜像仓库里，coredns 拉不下来。

解决方案是：手动拉镜像，然后 tag 改名字。命令如下

```bash
# 查看依赖的镜像列表
kubeadm config images list --image-repository registry.aliyuncs.com/google_containers

# 拉所有镜像
kubeadm config images pull --image-repository registry.aliyuncs.com/google_containers

# 修 coredns:1.8.0 拉不下来的问题
docker pull coredns/coredns:1.8.0
docker tag coredns/coredns:1.8.0 registry.aliyuncs.com/google_containers/coredns/coredns:v1.8.0
```

执行 kubeadm init，创建集群，命令如下：

```bash
kubeadm init --pod-network-cidr=192.168.9.0/16 --ignore-preflight-errors=NumCPU --image-repository registry.aliyuncs.com/google_containers
```

改了 3 个参数：

1. pod-network-cidr：calico 需要填这个配置，默认的容易错。
2. ignore-preflight-errors：默认需要 2 核 CPU 2G 内存，我只有 1 core，忽略 CPU 核数报错，继续装。
3. image-repository：docker 镜像仓库。用阿里云的。

![](http://images.jackon.me/cheers.webp)
