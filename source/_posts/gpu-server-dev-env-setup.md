---
title: 2021 年的炼丹环境 -- GPU 服务器搭建 Ubuntu 20.04 开发环境
date: 2021-07-11 14:35:20
tags: [开发环境]
---

先简单介绍一下我的主要使用场景和习惯，然后再讲搭建步骤。

# 环境总体介绍

## 我会大量使用的

1. 用 GPU 加速代码。工具：Nvidia driver，cuda
2. 运行不明来源的代码，多 cuda 版本并存。工具：docker
3. 看大量自己不熟悉的代码。工具：ag。更人性化的 grep。
4. 在命令行里工作。工具：tmux，ranger，git，vim。
5. 故障排查。电脑为什么慢了，磁盘空间为什么没了。对应的工具是：htop、ncdu，nload，nvidia-smi，glances

## 本文不会涉及的

1. cuda 环境。裸机不装，都放在 docker 镜像里。多版本切换和共享，更方便。
2. Tensorflow、jupyter、PyTorch 等的安装。
3. GUI 环境才会用到的工具，比如 vscode，Chrome。

另外，个人喜好的原因，不会涉及以下内容：

1. oh my zsh
2. conda

没有为什么，就是觉得帮助不大，但踩到 bug 的概率明显提升了。划不来。

## 为什么不再裸机装 cuda

因为都在 docker 里了。

为什么用 docker 的方案呢？有 3 点。

第一，docker 已经优化的非常成熟了，包括 IO 在内，引入性能 overhead 都可以忽略不计。

第二，tensorflow 的官方文档，也开始推荐 docker 而非本地装 cuda 了。

[https://www.tensorflow.org/install/gpu](https://www.tensorflow.org/install/gpu)

> 为了简化安装并避免库冲突，建议您使用支持 GPU 的 TensorFlow Docker 映像（仅限 Linux）。此设置仅需要 NVIDIA® GPU 驱动程序

第三，日常工作需要大量使用预训练模型，尝试别人的开源代码，版本很乱，依赖的 cuda 版本、cudnn 版本等都排列组合起来非常多。用 docker 更好管理。


# 准备工作

## 操作系统

见：[U 盘安装 Ubuntu20.04](https://jackon.me/article/ubuntu20-04-installation/)

装操作系统时，就顺手装了 ssh server。本文的安装，都是从 Mac 上 ssh 到 GPU 机器上完成的。

## ssh server

在 ubuntu 上安装 ssh server，默认没有安装

```bash
sudo apt-get install openssh-server openssh-client
sudo /etc/init.d/ssh start
# [ ok ] Starting ssh (via systemctl): ssh.service.
```

## 免密码登录

```bash
ssh-copy-id -i ~/.ssh/m1_key jackon@192.168.1.66
```

# 安装步骤

## Nvidia driver 并重启 server

如果你的认知还停留在，安装 Nvidia driver 和 CUDA 很复杂，那多半是需要更新一下信息了。
现在是后 ubuntu 20.04 的年代，已经简单到一句 apt-get 装好 driver，一句 docker 命令拉下 cuda 镜像就能开箱即用了。

在我装系统的时候，最新版本的 Nvidia driver 是 465，向前兼容，所以选择最新的 465 版本。

```bash
sudo apt install nvidia-driver-465
sudo reboot  # reboot the computer to enable it
```

安装后，需要重启电脑。

验证安装成功的方法：

```bash
nvidia-smi
```

显示我的 Driver Version: 465.27


## python 3.9.6

这套安装方法，可以在各个 ubuntu 发行版下安装各种 python 大版本。

### 安装 python

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.9
```

验证安装的版本

```
$ python3.9 --version
Python 3.9.6
```

### 安装 pip 和 virtualenv

```bash
sudo apt-get install python3-pip python3-dev
pip3 install virtualenv
```

验证 pip 版本
```bash
$ pip3 --version
pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
$ pip --version
pip 20.0.2 from /usr/lib/python3/dist-packages/pip (python 3.8)
```

### 配置 pip 源

我一直使用阿里云的镜像源

创建文件 ~/.pip/pip.conf, 添加如下内容

```bash
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host = mirrors.aliyun.com
```

## docker

### 官方 docker

跟着 docker 官网操作即可。

[https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)

我的版本信息：`Docker version 20.10.7, build f0df350`


```bash
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# docker run hello-world
```

### docker post install

使当前用户不用 sudo 也能运行 docker 命令

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```

### 配置 docker image 源

阿里云 docker 镜像的文档：

[https://help.aliyun.com/document_detail/60750.html](https://help.aliyun.com/document_detail/60750.html)

修改 /etc/docker/daemon.json 内容如下
(阿里镜像，域名里的 a10q86at 要换成自己的)

```javascript
{
  "registry-mirrors": ["https://a10q86at.mirror.aliyuncs.com"]
}
```

重启 docker 使配置生效

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

### nvidia-docker

安装了之后，才能在 docker 内看到并使用 GPU。

```bash
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list \
    | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

验证安装，执行如下命令，预期能看到 nvidia-smi 的输出。

```bash
docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
```

## 其他工具一把梭

```bash
sudo apt-get install tmux ranger git vim htop ncdu nload silversearcher-ag
pip install nvidia-ml-py3
pip install glances
```

### glances 介绍

增强版的 htop。

cpu，gpu，温度，内存 等各种监控在一张图里

![](https://images.jackon.me/glances-preview-2021.png)

### ranger 介绍

命令行里的文件浏览器，可以预览文件内容，支持 vim 快捷键

![](https://images.jackon.me/ranger-preview-2021.png)

### ncdu 介绍

更好用的 du 命令，看磁盘空间占用

![](https://images.jackon.me/ncdu-preview-2021.png)

### nload 介绍

看各个网卡实时的流入/流出带宽

![](https://images.jackon.me/nload-preview-2021.png)

### htop 介绍

更好用的 top 命令

![](https://images.jackon.me/htop-preview-2021.png)
