---
title: hexo theme 主题更换和体验优化
date: 2021-06-11 15:16:13
tags: [hexo, howto]
mathjax: true
---

在[安装 hexo](https://jackon.me/2021/06/11/hexo-blog-setup/) 之后，需要进行一波体验优化。

本文记录我的第一波优化操作，及 github commit link。


# 更换主题

## 挑选 theme

首先要挑个喜欢的主题，抛砖引玉，以下 2 个 link 可以参考：

- 知乎话题：[有哪些好看的 Hexo 主题？](https://www.zhihu.com/question/24422335)
- hexo 官方：[hexo Themes](https://hexo.io/themes/)

我选的 theme 是 [hexo-theme-xoxo](https://github.com/KevinOfNeu/hexo-theme-xoxo)。

为了修改 theme 源码方便，我 fork 并改了几个 bug：[https://github.com/misc-codes/hexo-theme-xoxo](https://github.com/misc-codes/hexo-theme-xoxo)


## 使用 theme

分 2 步：

1. 把 theme 的源码下载到 blog repo 的 theme 目录下
2. 修改配置文件 `_config.xml`，启动 theme

下载 theme，可以 git clone 或者用 git submodule。我熟悉 git 操作，所以用 submodule。

```bash
git submodule add git@github.com:misc-codes/hexo-theme-xoxo.git themes/xoxo
```

也可以用 clone

```bash
git clone git@github.com:misc-codes/hexo-theme-xoxo.git themes/xoxo
```

启动 theme。更改 blog 根目录下的 `_config.xml`，如下：

```bash
# Extensions
## Plugins: https://hexo.io/plugins/
## Themes: https://hexo.io/themes/
theme: xoxo
```

启用 theme 的完整代码，见：[commit/7cda26c91fe340b7ea3303e1bafc0c3c5444fa43](https://github.com/JackonYang/blog-2020s/commit/7cda26c91fe340b7ea3303e1bafc0c3c5444fa43)


# 支持文章插入图片

图片可以放 github 仓库或者上传第三方的图床、CDN。

我自建了图片 CDN，用的七牛。看重 2 个好处：

1. 文章转载到不同的平台时，不用担心图片用不了。
2. 推拉 github 的 blog 仓库时，如果图片太多，会很慢。

图床上的图片，使用简单，就是普通的 markdown 语法，如下：

```bash
![](http://example.com/images/image.jpg)
```

上传 github 的图片，可以参考这篇文章：
[Hexo博客搭建之在文章中插入图片](https://yanyinhong.github.io/2017/05/02/How-to-insert-image-in-hexo-post/)


# 支持 RSS 订阅

使用插件：[hexo-generator-feed](https://github.com/hexojs/hexo-generator-feed)

先安装 node module，命令如下：

```bash
npm install hexo-generator-feed --save
```

然后改配置文件 `_config.xml`，增加如下配置：

```javascript
feed:
  enable: true
  type: atom
  path: atom.xml
  limit: 20
  hub:
  content:
  content_limit: 140
  content_limit_delim: ' '
  order_by: -date
  icon: icon.png
  autodiscovery: true
  template:
```

支持 RSS 订阅的完整代码，见 [commit/1a24f66d337f0ae6d1b83b33a8ab1ca749cc81c3](https://github.com/JackonYang/blog-2020s/commit/1a24f66d337f0ae6d1b83b33a8ab1ca749cc81c3)


# 支持站内搜索 search

使用插件：[hexo-generator-search](https://github.com/wzpan/hexo-generator-search)

先安装 node module，命令如下：

```bash
npm install hexo-generator-search --save
```

然后，改配置文件 `_config.xml`，增加如下配置：

```javascript
search:
  path: search.xml
  field: post
  content: true
  template: ./search.xml
```

最后，需要一个新建 page，声明 `type:search`。文件名是：`source/search/index.md`。内容如下

```bash
---
title: Search in Site
date: 2016-08-16 15:00:44
type: "search"
comments: false
indexing: false
---
```

注意，如果某个页面不想被索引，添加 `indexing: false` 即可。上面的 search page，就加了这个标签。

支持站内搜索的完整代码，见 [commit/d344056f994d66212c1e4e7456c113b08c783f28](https://github.com/JackonYang/blog-2020s/commit/d344056f994d66212c1e4e7456c113b08c783f28)


# 添加 tags 和 category 的 list 页面

为 tag 和 category 分别建一个 page，声明 `type:search`。

`source/categories/index.md` 内容如下：

```javascript
---
title: Categories List
date: 2016-08-16 15:00:44
type: "categories"
comments: false
indexing: false
---
```

`source/tags/index.md` 内容如下：

```javascript
---
title: Tags List
date: 2016-08-16 15:00:44
type: "tags"
comments: false
indexing: false
---
```

添加 tags 和 category 的 list 页面的完整源码，见 [commit/730f8bd4ce89a05582421f5a14693693f0b41aba](https://github.com/JackonYang/blog-2020s/commit/730f8bd4ce89a05582421f5a14693693f0b41aba)

# 支持 LaTeX 写数学公式

在 html 中显示数学公式的方案很多，目前基本是 Mathjax 一统天下。

首先，确认 theme 是否支持数学公式。如果支持，就简单了，按照 theme 的使用方法操作。

如果 theme 不支持，hexo theme 增加 Mathjax 数学公式支持的完整代码，见 [commit/82251d2b3617232496147ca2dd3d62ed762ea2a7](https://github.com/misc-codes/hexo-theme-xoxo/commit/82251d2b3617232496147ca2dd3d62ed762ea2a7)

⚠️ 注意，有的博客提到，[需要替换 markdown 引擎](https://adores.cc/posts/62947.html#%E6%9B%BF%E6%8D%A2%E6%B8%B2%E6%9F%93%E5%BC%95%E6%93%8E)，实测不需要。换成 pandoc 反而有 bug，不能正确显示希腊字母，比如 `\phi` -> $ \phi $。

回退 markdown 引擎的 commit: [commit/59c59903a4ea4c3d329d146e1090f4e2d5621fbb](https://github.com/JackonYang/blog-2020s/commit/59c59903a4ea4c3d329d146e1090f4e2d5621fbb)

使用时，在需要引入支持数学公式的文章中，添加 `mathjax: true`
例如：

```javascript
---
title: 深度学习为什么使用 cross entropy loss
date: 2021-06-06 01:04:05
mathjax: true
tags: [深度学习, 数学]
---
```

Mathjax 数学公式的展示效果：[深度学习为什么使用 cross entropy loss](https://jackon.me/2021/06/06/why-cross-entropy-loss/)


# 阅读数量统计

基本是 hexo 主题的标配了。实际用的都是 不蒜子。

用法见 [不蒜子官网](http://ibruce.info/2015/04/04/busuanzi/)

有很多玩法，比如

1. 显示站点总访问量，支持 PV 和 UV 2 种方式
2. 显示单页面访问量
3. 只计数不显示


# 更多问题

可以来这里创建 Issue，我尽量帮你解决 [https://github.com/JackonYang/blog-2020s/issues/new](https://github.com/JackonYang/blog-2020s/issues/new)
