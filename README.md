# 2020 年代的 Blog

powered by Hexo, cheers!

## 常用 debug 命令

```bash
# install hexo
sudo npm install -g hexo

# clone code
git clone git@github.com:JackonYang/blog-2020s.git

# setup dev env
cd blog-2020s
make install

# generate html
# and start dev server for preview
make g && make s

# 发布到博客
make g && make pub
```


## 常用 blog 管理命令

更多命令: [hexo cheatsheet -- hexo 常用命令总结](https://jackon.me/article/hexo-cheatsheet/)

```bash
hexo n new-post-name  # 创建新 blog 的 .md 文件

hexo n paper-reading title  # 用 paper-reading 模版创建新 blog
```

## Notes

1. 根目录下的 scripts 目录，应该是 hexo 有特殊定义的，不能乱写。个人脚本，放在了 tools 目录下
