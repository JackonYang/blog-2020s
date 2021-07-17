---
title: bash_profile_vs_bashrc
date: 2021-07-17 15:33:39
tags: [linux, 有趣但没用的知识]
---

根据 [bash(1) - Linux man page](https://linux.die.net/man/1/bash)，区分如下：

- login shells 用 .bash_profile
- *interactive* non-login shells 用 .bashrc


| 场景 | 分类 | 入口文件 |
| --- | --- | --- |
| X Windows 打开 terminal | interactive non-login shell | .bashrc |
| ssh | login shell | .bash_profile |
| tmux |  | .bash_profile |

注意强调了 interactive（交互式）。如果命令行里运行 `/bin/bash`，这是交互式的，会用 `.bashrc`，但如果是 `/bin/bash run.sh` 就不是交互式了，会用 `.bash_profile`。

作为普通开发者，我们不需要也不想记住这么多细节，怎么办？

最佳实践：

1. 用 .bash_profile 调用 .bashrc
2. 所有的个性化配置都写入 .bashrc，除非特殊需求，不要碰 .bash_profile


`.bash_profile` 的内容，如下：

```bash
$ cat .bash_profile
#################################################################
#                                                               #
#   .bash_profile file                                          #
#                                                               #
#   Executed from the bash shell when you log in.               #
#                                                               #
#################################################################

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
```

Mac OS -- 特例

1. 默认 shell 是 bash 的早期版本里，打开 terminal 时，是 login shell，不同于 Linux。
2. 从 10.15 Catalina 版本开始，默认 shell 是 zsh，所以，以上两个文件都不会被用了。
