---
title: hexo cheatsheet -- hexo 常用命令总结
date: 2021-06-11 20:41:41
tags: [hexo, cheatsheet]
---

# 主要场景的命令

## 写文章

```bash
hexo n new-post-name  # 创建新文章的 .md 文件
hexo g && hexo s  # 生成静态网页并打开预览服务器
# 在浏览器中打开 localhost:4000
hexo clean  # 如果页面渲染出现诡异问题不不生效，可能是缓存导致。清理缓存
```

## 文章 metadata 声明

```bash
---
title: hexo 博客搭建与常见问题解决  # 页面上显示的文章标题
date: 2021-06-11 12:03:36
tags: [devops, hexo, howto]
keywords: Hexo, Blog
description: 这个东西可能有利于 SEO
mathjax: true  # 启用数学公式支持，一般 false
indexing: false  # 文章不加入 hexo 自带的站内搜索，一般 true 加入
---
```

## 部署更新

```bash
# 安全的一键三连，清理，重新生成，部署。
hexo c && hexo g && hexo d
```

## theme 更新

我用的 git submodule 管理 theme

```bash
git submodule init  # 仅第一次 clone repo 时需要
git submodule update
```

# 详细命令

## 基础命令

```bash
hexo n "文章名称"  => hexo new "文章名称"  # 创建新文章的 .md 文件
hexo g  => hexo generate   # 生成静态网页
hexo s  => hexo server     # 启动服务器，会监听文件变动并自动更新，手动刷新页面即可
hexo c  => hexo clean      # 清理已生成的内容，发布前，先 clean 再 generate，更安全
hexo d  => hexo deploy     # 部署
hexo p  => hexo publish    # 把草稿从 _drafts 移动到 _posts 目录
```

## node 环境检查

```bash
node --version
# v16.3.0
npm -v
# 7.16.0
```


## hexo 帮助文档

```bash
hexo --help  # 能看到支持的 command list
hexo [commond] --help  # 查看具体 command 的帮助

# 比如
hexo server --help
hexo new --help
```

## 起 server 的高级玩法

```bash
hexo server             # Hexo 会监听文件变动并自动更新，无须重启服务器。
hexo server -p 5000     # 更改端口
hexo server -s          # Only serve static files
hexo server -i 0.0.0.0  # 默认就是监听所有 IP
```
