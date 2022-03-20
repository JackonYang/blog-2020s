---
title: hexo tips - 使用 categories & tags
date: 2022-03-20 14:36:33
categories: 笔记 & 博客工具
tags: [hexo]
---

blog 网站的 tags 和 categories，很重要：

1. 用户阅读时，内容更加结构化。
2. 文章中大量使用本地化（中文）的关键词，方便用户阅读，也有利于 SEO
3. URL 中使用短且语义明确的英文翻译，方便用户分享，一般认为，也会有利于 SEO

我的效果见 [jackon.me/categories/](https://jackon.me/categories/)

## 创建 index page

```bash
hexo new page categories
hexo new page tags
```

在新生成的 `.md` 文章里，分别添加：

- type: "categories"
- type: "tags"

最终的效果参考 [categories/index.md?plain=1](https://github.com/JackonYang/blog-2020s/blob/master/source/categories/index.md?plain=1)


## 在 navbar 中显示 link

修改 theme 的 `_config.yml`，新增如下配置

```bash
menu:
  home: /
  archives: /archives
  tags: /tags  # 新增
  categories: /categories  # 新增
```

最终效果参考 [theme/_config.yml#L10](https://github.com/misc-codes/hexo-theme-xoxo/blob/0a21f331182a528452479a5679af75f61a65983d/_config.yml#L10)

## 优化 URL 显示

默认情况下，如果 categories 或 tags 是中文，在 URL 中也是中文。有 3 个弊端：

1. 在一些浏览器里，可能显示很难看，例如 `/categories/%E8%BF%99%E6%98%AF%E4%B8%80%E4%B8%AA%E4%B8%AD%E6%96%87%E7%9A%84url`
2. 用户分享 URL 的时候，可能被社交软件错误的切断，其他无法点击直接打开，流失新用户
3. 短且语义明确的 url，更有利于 SEO

改进的方法是：在项目的 `_config.yml`，使用 `category_map` & `tag_map` 给 URL 配置 slug.

不同的 tags 可以指向同一个 url slug

例如：

```javascript
category_map:
  数学: math
  开发环境配置: dev-env-setup
  笔记 & 博客工具: notes-and-blogging-tools
  深度学习: deep-learning
  自动驾驶: self-driving
tag_map:
  tag1: supertag
  по-русски: in-russian
  fun: fun and jokes
  jokes: fun and jokes
```
