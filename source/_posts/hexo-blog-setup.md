---
title: hexo 博客搭建与常见问题解决
date: 2021-06-11 12:03:36
categories: 笔记 & 博客工具
tags: [devops, hexo, howto]
---


# hexo 安装


官网：[hexo.io/](https://hexo.io/)

如果顺序，一行命令搞定。

```bash
sudo npm install hexo-cli -g
```

# hexo 安装的常见问题

## Missing write access 或 permission denied

完整报错信息如下：

```bash
npm WARN checkPermissions Missing write access to /usr/lib/node_modules
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@~2.3.1 (node_modules/hexo-cli/node_modules/chokidar/node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.3.2: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})

npm ERR! code EACCES
npm ERR! syscall access
npm ERR! path /usr/lib/node_modules
npm ERR! errno -13
npm ERR! Error: EACCES: permission denied, access '/usr/lib/node_modules'
npm ERR!  [Error: EACCES: permission denied, access '/usr/lib/node_modules'] {
npm ERR!   errno: -13,
npm ERR!   code: 'EACCES',
npm ERR!   syscall: 'access',
npm ERR!   path: '/usr/lib/node_modules'
npm ERR! }
npm ERR! 
npm ERR! The operation was rejected by your operating system.
npm ERR! It is likely you do not have the permissions to access this file as the current user
npm ERR! 
npm ERR! If you believe this might be a permissions issue, please double-check the
npm ERR! permissions of the file and its containing directories, or try running
npm ERR! the command again as root/Administrator.
```

原因：安装时要写文件，没有写入权限。

解决方案：用 sudo 安装。


## Console expects a writable stream instance

完整报错信息如下：

```bash
hexo generate
console.js:35
    throw new TypeError('Console expects a writable stream instance');
    ^

TypeError: Console expects a writable stream instance
    at new Console (console.js:35:11)
    at Object.<anonymous> (/usr/lib/node_modules/hexo/node_modules/hexo-log/lib/log.js:31:17)
    at Module._compile (module.js:653:30)
    at Object.Module._extensions..js (module.js:664:10)
    at Module.load (module.js:566:32)
    at tryModuleLoad (module.js:506:12)
    at Function.Module._load (module.js:498:3)
    at Module.require (module.js:597:17)
    at require (internal/module.js:11:18)
    at Object.<anonymous> (/usr/lib/node_modules/hexo/node_modules/hexo-cli/lib/context.js:3:16)
    at Module._compile (module.js:653:30)
    at Object.Module._extensions..js (module.js:664:10)
    at Module.load (module.js:566:32)
    at tryModuleLoad (module.js:506:12)
    at Function.Module._load (module.js:498:3)
    at Module.require (module.js:597:17)

```

原因：node 版本太低了。在比较新的操作系统上，一般不会遇到。老的操作系统，比如 Ubuntu 16.04，包管理器里默认的 node 版本是 8.x。

解决方案：安装 node 12 或者以上版本。

Ubuntu 16.04 安装 node 12 的方法如下：

```bash
sudo apt install build-essential apt-transport-https lsb-release ca-certificates
wget https://deb.nodesource.com/setup_12.x
sudo bash setup_12.x
sudo apt-get install -y nodejs
```

## pandoc: Unknown extension: smart

完整报错信息如下：

```bash
$ hexo generate
INFO  Validating config
INFO  Start processing
FATAL {
  err: Error: 
  [ERROR][hexo-renderer-pandoc] On /home/jiekun.yang/src/blog-2020s/source/_posts/k8s-setup-1cpu2core.md
  [ERROR][hexo-renderer-pandoc] pandoc exited with code 9: pandoc: Unknown extension: smart
  
      at Hexo.pandocRenderer (/home/jiekun.yang/src/blog-2020s/node_modules/hexo-renderer-pandoc/index.js:114:11)
      at Hexo.tryCatcher (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/util.js:16:23)
      at Hexo.<anonymous> (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/method.js:15:34)
      at /home/jiekun.yang/src/blog-2020s/node_modules/hexo/lib/hexo/render.js:75:22
      at tryCatcher (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/util.js:16:23)
      at Promise._settlePromiseFromHandler (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/promise.js:547:31)
      at Promise._settlePromise (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/promise.js:604:18)
      at Promise._settlePromiseCtx (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/promise.js:641:10)
      at _drainQueueStep (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/async.js:97:12)
      at _drainQueue (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/async.js:86:9)
      at Async._drainQueues (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/async.js:102:5)
      at Immediate.Async.drainQueues [as _onImmediate] (/home/jiekun.yang/src/blog-2020s/node_modules/bluebird/js/release/async.js:15:14)
      at processImmediate (internal/timers.js:461:21)
} Something's wrong. Maybe you can find the solution here: %s https://hexo.io/docs/troubleshooting.html
```

原因：用了 [hexo-renderer-pandoc](https://github.com/wzpan/hexo-renderer-pandoc) 插件，需要 pandoc 2.0 以上版本。在老的操作系统上，包管理器安装的 pandoc 默认版本较低。比如，ubuntu 16.04，装的是 1.16.0.2

解决方案：安装 pandoc 2.0 以上版本。

例如，ubuntu 16.04 手动安装 pandoc 2.7，方法如下

```bash
wget https://github.com/jgm/pandoc/releases/download/2.7/pandoc-2.7-1-amd64.deb
dpkg -i ./pandoc-2.7-1-amd64.deb
```

# 更多问题

可以来这里创建 Issue，我尽量帮你解决 [https://github.com/JackonYang/blog-2020s/issues/new](https://github.com/JackonYang/blog-2020s/issues/new)
