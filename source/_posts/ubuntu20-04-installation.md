---
title: U 盘安装 Ubuntu20.04
date: 2021-07-11 00:38:39
categories: 开发环境配置
tags: [Ubuntu]
---

# 制作 U 盘启动盘

从 ubuntu 16.04 开始，用自带的 "Make Startup Disk" 就很稳了。

![](https://images.jackon.me/ubuntu-make-startup-disk.png)

# 磁盘分区

近 10 年来，我一直习惯于 4 分区，直到我开始搞深度学习，与 CUDA 亲密接触。
遵循 [2020 年代，Linux 电脑磁盘分区的最佳实践](https://jackon.me/article/linux-pc-disk-partition-best-practice-in-2020s/)

我的分区配置如下：

![](https://images.jackon.me/ubuntu24-04-disk-partion.png)


# apt 换一个速度快的 source

我一直用阿里云的镜像，可以手动改配置文件，也可以直接在 GUI 上点几下解决。

![](https://images.jackon.me/ubuntu-1804-gui-change-source-mirror-entry.png)

![](https://images.jackon.me/ubuntu-1804-gui-change-source-mirror-entry.png)

# ssh server 和免密码登录

在 ubuntu 上安装 ssh server，默认没有安装

```bash
sudo apt-get install openssh-server openssh-client
sudo /etc/init.d/ssh start
# [ ok ] Starting ssh (via systemctl): ssh.service.
```

打通免密码登陆


```bash
ssh-copy-id -i ~/.ssh/m1_key jackon@192.168.1.66
```
