---
title: Mac 开发环境配置
date: 2022-03-19 21:41:29
tags: [Mac, 开发环境, howto]
mathjax: false
---

## 关闭 SIP (Rootless 机制)

### 配置步骤

一共 2 步，每一步都要重启电脑。

先关闭 SIP 模式。长按开机按钮（Intel Mac 是开机时按住 Command+R）进入恢复模式，打开 Terminal，执行如下命令：

```bash
csrutil disable
```

重启，关闭 SIP 生效。

然后修改启动配置，以软链的方式，在根目录 `/` 创建文件夹。再次重启。

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

### 配置说明

SIP (System Integrity Protection) 是 Mac 特有的安全机制。开发者一般需要关闭，否则，无法在根目录创建文件夹等。macOS Catalina (版本 10.15, 2019 年) 引入了 readonly 分区，关闭 SIP 后还需要额外的配置，才能在根目录下创建文件夹。

详见：[Mac 关闭 SIP (Rootless 机制) 并在根目录创建文件夹](https://jackon.me/article/mac-turn-off-rootless/)


## 安装 Xcode 相关

Xcode 是苹果官方提供的一个开发包，包含编译器、开发库、开发工具等。xcode command line tools 包含 git 等常用开发工具。

3 件事：

1. app store 安装 Xcode
2. 打开 Xcode，根据提示操作。主要是同意 Xcode license
3. 在 Terminal 执行如下命令，安装 xcode command line tools

```bash
xcode-select --install
```


## homebrew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```


## Git 与自动补全

### 配置步骤

```bash
brew install git && brew install bash-completion
```

在 .bash_profile 中添加

```bash
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
```

在此之后新打开的 terminal 就可以使用 git 自动补全了。

已经打开的窗口里，执行了 source .bash_profile 以后才会生效。每个新打开的 terminal，都需要执行一次。

### 配置说明

bash-completion 是自动补全用的。

除了 git 的自动补全，也会增强 terminal 的自动补全。

官方文档摘录如下:

-   Command names after `sudo` and `which`
-   `Macports` and `Homebrew` package names (optional)
-   Hostnames in `known_hosts` for commands like `ssh`
-   Folders on CDPATH

You can print a list of completion commands with complete -p and see the source of a function with declare -f


## vscode

下载：https://code.visualstudio.com/

运行 vscode 并打开命令面板 (⇧⌘P)，然后输入 `install code` 找到对应的命令并执行。

![](https://tva1.sinaimg.cn/large/e6c9d24egy1h0fk62v601j20wm0dut9a.jpg)

## brew 快速安装的工具

```bash
brew install wget
brew install dos2unix
brew install tmux
```

## 下载 & 一键安装的软件

[iterm2](https://iterm2.com/) 更好用的 Terminal

[ImageOptim](https://imageoptim.com/howto.html) 图片压缩软件，开源免费。写博客传图方便。

[Robo 3T](https://robomongo.org/) MongoDB GUI 客户端

## 我买的付费软件

[Paw](https://paw.cloud/) 比 Postman 更好用的 http client 模拟器
