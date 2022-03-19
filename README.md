# 2020 年代的 Blog

powered by Hexo, cheers!


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
make pub
```

new post example

```bash
hexo n paper-reading self-driving-survey-on-motion-prediction-and-risk-assessment-2014
```

## Notes

1. 根目录下的 scripts 目录，应该是 hexo 有特殊定义的，不能乱写。个人脚本，放在了 tools 目录下
