---
title: Mac 关闭 SIP (Rootless 机制) 并在根目录创建文件夹
date: 2022-03-19 17:34:01
categories: 开发环境配置
tags: [Mac, security]
mathjax: false
---

SIP (System Integrity Protection) 是 Mac 特有的安全机制。开发者一般需要关闭，否则，无法在根目录创建文件夹等。macOS Catalina (版本 10.15, 2019 年) 引入了 readonly 分区，关闭 SIP 后还需要额外的配置，才能在根目录下创建文件夹。

## SIP (Rootless 机制) 是什么

SIP (System Integrity Protection)，又称 Rootless mode 机制。

这是 Mac 下特有的设计，Linux 没有。简单来说，主要是权限限制。即使拿到 root 权限，也无法随意访问用户隐私信息(email, contacts, etc)，无法更改部分系统文件、启动参数、内核配置等。

SIP 最早引入是 El Capitan (版本 10.11, 2015 年) 。在之后的 macOS 版本中，SIP 限制的权限范围一直有调整、改进，不是一成不变的。

如果没有 SIP，恶意软件很容易入侵普通用户的电脑。例如，首次安装某个软件时、执行某个特殊任务时，第三方软件要求用户输入 root 密码才能继续，这是很常见的操作。然后，恶意软件就可以在用户电脑里执行任何他想做的事情，普通用户很难发现和辨别。

## 开发者为什么要关闭 SIP

启用 SIP 时，即使 root 用户也不能在根目录 `/` 下创建文件或文件夹，也不能更改内核参数。自由度太差，很影响工作效率，所以，开发者一般会关闭 Rootless 机制。

SIP 的关闭方法一直在变，不同的 MacOS 版本，略有区别。

## SIP 常用命令

主要有如下 3 条命令，其中 enable 和 disable 需要在恢复模式使用。

```bash
# 查看状态
csrutil status
# System Integrity Protection status: enabled.
# 或
# System Integrity Protection status: disabled.

# 开启
csrutil enable

# 关闭
csrutil disable
```

## 关闭 SIP (csrutil)

需要在恢复模式才能关闭 SIP。Intel Mac 和 M1 Mac，进入恢复模式的方法，不一样。

### Intel Mac 关闭 csrutil

[针对电脑小白的更详细步骤截图](https://jingyan.baidu.com/article/17bd8e52e9cfc5c4aa2bb806.html)

按开机按钮后，进入 OS 之前，按住 Command+R，进入恢复模式。

如果是 2015 年之前的 mac 电脑，尝试按住 Option 键进入恢复模式。

打开 Terminal，输入：

```bash
csrutil disable
```

重启电脑即可。可以在 Terminal 中输入 reboot 重启。

### M1 Mac 关闭 csrutil

[针对电脑小白的更详细步骤截图](https://www.macz.com/news/5905.html)

长按开机键，直到出现提示“正在载入启动资源”，或者出现下图

![](https://tva1.sinaimg.cn/large/e6c9d24egy1h0fcbojqw4j20vs0si75e.jpg)

选择[继续]，根据提示，选用户并输入密码后，通过 [实用工具]->[终端] 打开 Terminal，方法见下图

![](https://tva1.sinaimg.cn/large/e6c9d24egy1h0fcfdmqgkj213e0m2gn2.jpg)

Terminal 中输入：

```bash
csrutil disable
```

重启电脑即可。可以在 Terminal 中输入 reboot 重启。

## 启用 SIP (csrutil)

如果关闭 SIP 后，想要重新启用 SIP。还是用上面的方法进入安全模式，打开 Terminal，命令改为如下

```bash
csrutil enable
```


## 在根目录下创建文件夹

由于安全相关的更新，Catalina (版本 10.15, 2019 年) 之后的 macOS，关闭 SIP 后，依旧无法在根目录 `/` 下直接创建文件，需要曲线救国。

### 最新 macOS 的操作方法

执行如下操作。重启后，会创建一个 `/data` 的软链接，指向 `/Users/jackon/data`

```
# 创建可用目录（不在根目录下），如
mkdir -p ~/data   # 我的目录是：/Users/jackon/data

# 编辑 /etc/synthetic.conf，内容如下
% cat /etc/synthetic.conf
data	/Users/jackon/data

# 重启系统
sudo reboot
```


`synthetic.conf` 的配置注意：

1. 这里 data 前面没有 /
2. data 与后面内容使用 tab 分割。某些编辑器里，tag 键默认会被替换成 n 个空格。可以左右移动光标看有几个字符，区分是 1 个 tab，还是多个空格。

### macOS 系统目录权限的演进史

主要是 2 个版本的安全更新。

第 1 次大改动是 Catalina (版本 10.15, 2019 年) 。出于系统安全的考虑，引入了 read-only system volume。即，磁盘被划分为 2 个独立的分区，其中一个是 readonly 的，核心操作系统都在这个上面，即使 root 权限也无法篡改操作系统。其他数据都在另外一个分区上，可读写。

第 2 次大改动是 Big Sur (版本 11.01, 2020 年)。修了 Catalina 的安全 bug。Catalina 虽然设计了 readonly 分区，但 root 权限可以重新挂载为可读写分区，使得这个防止 root 用户篡改 readonly 分区的设定，形同虚设。Catalina 中，以可读写权限重新挂载的命令如下：

```bash
sudo mount -uw /
```

Apple 关于 read-only  分区的官方介绍：[About the read-only system volume in macOS Catalina](https://support.apple.com/en-us/HT210650)
![](https://tva1.sinaimg.cn/large/e6c9d24egy1h0fgalis1gj217c0pk0vc.jpg)

## 附录 - 深入理解 SIP

原文：[stackexchange: What is the "rootless" feature in El Capitan, really?](https://apple.stackexchange.com/questions/193368/what-is-the-rootless-feature-in-el-capitan-really)

-   You can't modify anything in `/System`, `/bin`, `/sbin`, or `/usr` (except `/usr/local`); or any of the built-in apps and utilities. Only Installer and software update can modify these areas, and even they only do it when installing Apple-signed packages. But since normal OS X-style customizations go in `/Library` (or `~/Library`, or `/Applications`), and unix-style customizations (e.g. Homebrew) go in `/usr/local` (or sometimes `/etc` or `/opt`), this shouldn't be a big deal. It also prevents block-level writes to the startup disk, so you can't bypass it that way.

    The full list of restricted directories (and exceptions like `/usr/local` and a few others) is in `/System/Library/Sandbox/rootless.conf`. Of course, this file is itself in a restricted area.

    When you upgrade to El Capitan, it moves any "unauthorized" files from restricted areas to `/Library/SystemMigration/History/Migration-(some UUID)/QuarantineRoot/`.

-   You can't attach to system processes (e.g. those running from those system locations) for things like debugging (or changing what dynamic libraries they load, or some other things). Again, not too much of a big deal; developers can still debug their own programs.

    This does block some significant things like injecting code into the built-in Apple apps (notably the Finder). It also means that `dtrace`-based tools for system monitoring (e.g. [`opensnoop`](https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/opensnoop.1m.html)) will not be able to monitor & report on many system processes.

-   You can't load kernel extensions (kexts) unless they're properly signed (i.e. by Apple or an Apple-approved developer). Note that this replaces the old system for enforcing kext signing (and the old ways of bypassing it). But since v10.10.4 Apple has [had a way to enable trim support for third-party SSDs](http://arstechnica.com/apple/2015/06/latest-os-x-update-allows-you-to-enable-trim-for-third-party-ssds/), the #1 reason to use unsigned kexts has gone away.

-   Starting in Sierra (10.12), some launchd configuration settings cannot be changed (for example, some launch daemons cannot be unloaded).

-   Starting in Mojave (10.14), access to users' personal information (email, contacts, etc) is restricted to apps that the user has approved to access that info. This is generally considered a separate feature (called Personal Information Protection, or TCC), but it's based on SIP and disabling SIP disables it as well. See: ["What and how does macOS Mojave implement to restrict applications access to personal data?"](https://apple.stackexchange.com/questions/332673/what-and-how-does-macos-mojave-implement-to-restrict-applications-access-to-pers)

-   Starting in Catalina (10.15), protection of most system files is strengthened by storing them on a separate read-only volume. This is not strictly part of SIP, and is not disabled by disabling SIP. See: [WWDC presentation on "What's New in Apple [Catalina] File Systems"](https://developer.apple.com/videos/play/wwdc2019/710/) and ["What's /System/Volumes/Data?"](https://apple.stackexchange.com/questions/367158/whats-system-volumes-data).

-   Starting in Big Sur (11.x), the read-only system volume is now a "Sealed System Volume" (a mounted snapshot rather than a regular volume), so making changes to it is even more complicated. See: [the Eclectic Light Company article "Big Sur boot volume layout"](https://eclecticlight.co/2021/01/13/big-sur-boot-volume-layout/).

To underscore the importance of leaving as much of SIP enabled as much of the time as possible, consider the events of September 23, 2019. Google released an update to Chrome that tried to replace the symbolic link from `/var` to `/private/var`. On most systems, SIP blocked this and there were no bad effects. On systems with SIP disabled, it rendered macOS broken and unbootable. The most common reason for disabling SIP was to load unapproved (/improperly signed) kernel extensions (specifically video drivers); if they'd only disabled the kext restriction, they would not have been affected. See [the official Google support thread](https://support.google.com/chrome/thread/15235262), [a superuser Q&A on it](https://superuser.com/questions/1486643/after-installing-a-recent-chrome-update-macs-become-unbootable), and [an Ars Technica article](https://arstechnica.com/information-technology/2019/09/no-it-wasnt-a-virus-it-was-chrome-that-stopped-macs-from-booting/).

References and further info: [WWDC presentation on "Security and Your Apps"](https://developer.apple.com/videos/play/wwdc2015/706/), a [good explanation by Eldad Eilam on quora.com](http://www.quora.com/Can-someone-elaborate-on-the-OS-X-10-11-feature-called-Rootless), the [Ars Technica review of El Capitan](http://arstechnica.com/apple/2015/09/os-x-10-11-el-capitan-the-ars-technica-review/8/), and an [Apple support article on SIP](https://support.apple.com/en-us/HT204899), and [a deep dive by Rich Trouton](https://derflounder.wordpress.com/2015/10/01/system-integrity-protection-adding-another-layer-to-apples-security-model/) (who also posted an [answer to this question](https://apple.stackexchange.com/questions/193368/what-is-the-rootless-feature-in-el-capitan-really/209705#209705)).
