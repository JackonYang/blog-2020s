---
title: 【MIT 概率公开课】03.连续随机变量的 PDF、数学期望和方差
date: 2021-06-23 00:29:00
mathjax: true
tags: [数学, 笔记]
---


> 公开课：[MIT 6.041 Probabilistic Systems Analysis and Applied Probability](https://www.youtube.com/watch?v=j9WZyLZCBzs&list=PLUl4u3cNGP61MdtwGTqZA0MreSaDybji8&index=1)
> video 8-9 of total 25
> 重点：在 [离散随机变量](https://jackon.me/article/mit-6-041-probabilistic-systems-notes-part02/) 的基础上，研究连续随机变量有差异的性质。
> 难点：概念都不难，主要是微积分的运算不要出错。比如，根据 $f_X(x)$ 计算 CDF 或反过来。

# 心得

1. 搞懂[离散随机变量](https://jackon.me/article/mit-6-041-probabilistic-systems-notes-part02/)以后，本章无难点。
2. 微积分计算比较多，尤其是联合分布，计算上容易粗心不断。
3. video 9 最后有三四个多维连续随机变量的练习题，巩固新知识还不错。但都不引入新知识，也不是有代表性的常用模型，本文不整理笔记。
4. 边界条件、可导性、可积性等，没有太多的展开。毕竟有限个点的概率和，依旧是 0。并不影响最终的概率值。


# 重点概念

（自测：根据这个提纲，可以回忆起所有知识点）

1. PDF 概率密度函数
2. PDF 的数学期望和方差公式
3. CDF 分布函数：对离散和连续变量都适用的统一数学语言。会根据 $f_X(x)$ 计算 CDF 或反过来
4. Joint PDF 联合分布。数学期望、边缘概率分布
5. 多维连续随机变量的独立性和条件概率
6. 经典分布，就 1 个：高斯分布（正态分布）


## 1. PDF 概率密度函数

在 [01.基本概念、贝叶斯和独立性](http://localhost:4000/article/mit-6-041-probabilistic-systems-notes-part01/) 提到过，在连续样本空间中，任何一点的概率，都是 0。

用离散变量的方式（PMF 函数）计算概率，不再适用。

连续随机变量，讨论在一个 subset（可能是无限小）内的概率，而非一个点的概率。用 PDF 概率密度函数。

Probability density function, $ f_X(x) $

$$ P(a\le X \le b) = \int_a^b f_X(x) \ \mathrm{d}x $$

一些讨论：

1. 根据定义，也可以推导出，在任何一点的概率都满足 $ P(x=a) = 0 $
2. 因为 P 不为负，所以，$ f_X(x) \ge 0$，否则，在一个 subset 内会出现 $ P < 0 $
3. 在边界*点* a, b 上的概率，不做严格性讨论。

*如果有 1 个点的概率不为 0，那就不是连续随机变量。*
可能是离散随机变量，或 离散和连续随机变量的组合。

在 $ \delta $ 无限小的时候，

$$ P(a\le X \le x + \delta) \approx f_X(x) \cdot \delta $$

可以用来做近似计算、上下限的概率计算。

2 个性质（与 PMF 类似）：

$$ \int_{-\infty}^\infty f_X(x)\ \mathrm{d}x = 1 $$

$$ P(X\in B) \equiv \int_B f_X(x)\ \mathrm{d}x, \text{for "nice" sets B} $$


## 2. Expectations and variance 数学期望和方差

与离散随机变量相似，公式改为积分的形式。

\begin{align}
E[X] &= \int_{-\infty}^\infty x\ f_X(x)\ \mathrm{d}x \\\\
E[g(X)] &= \int_{-\infty}^\infty g(x)\ f_X(x)\ \mathrm{d}x \\\\
\text{var} (X) = \sigma^2_X &= \int_{-\infty}^\infty (x-E[X])^2 f_X(x)\ \mathrm{d}x = E[X^2] - (E[X])^2
\end{align}

## 3. Cumulative distribution function (CDF) 分布函数

*对离散和连续变量都适用的统一数学语言*

从负无穷开始的累积概率和/积分。数学定义：

$$
\text{连续: } F_X(x) = P(X\leq x) = \int_{-\infty}^x f_X(t)\text{d}t
$$

$$
\text{离散：} F_X(x) = P(X\leq x) = \sum_{k \le x} p_X(k)
$$

$ f_X(x) $ 可能存在不连续的点，不可导。
但是，因为在具体一点上的概率都是 0，所以，忽略*有限*个边界点不影响积分结果。

$$
P_X\\{a < x \leq b\\} = F_X(b) - F_X(a)
$$

$ F_X(x) $ 可以是连续随机变量的 PDF 和离散随机变量的 PMF 叠加的结果。


## 4. Joint PDF 联合分布函数

定义

$$
P((X,\ Y) \in S) \triangleq \iint_S f_{X,Y}(x,y)\ \mathrm{d} x \mathrm{d} y
$$

其中，$S$ 是一个*曲面*，这是一个曲面积分(?)

解释：

$$
P(x\le X \le x + \delta, y \le Y \le y + \delta) \approx f_{X,Y}(x,y) \cdot \delta^2
$$

数学期望

$$
E[g(X, Y)] = \int_{-\infty}^{\infty}\int_{-\infty}^{\infty} g(x,y)\ f_{X,Y}(x,y)\ \mathrm{d} x \mathrm{d} y
$$

marginal 边缘概率分布

推导过程：

\begin{align}
f_X(x) \cdot \delta &\approx P(x\le X \le x + \delta) \\\\
                    &= \int_{-\infty}^{\infty}\int_{x}^{x+\delta}f_{X,Y}(\bar x,y)\ \mathrm{d} \bar x \mathrm{d} y \\\\
                    &= \int_{-\infty}^{\infty}\delta \cdot f_{X,Y}(x,y)\ \mathrm{d} y
\end{align}

所以，

$$
f_X(x) = \int_{-\infty}^{\infty} f_{X,Y}(x,y)\ \mathrm{d} y
$$

与离散随机变量的边缘概率计算，形式相同。只是 $ \sum $ 换成了 $ \int $

## 独立性 independent

主要是更新一下数学表达，无新知识。

定义：

$$
f_{X,Y}(x,y) = f_X(x)f_Y(y)
$$

## 条件概率

类比离散随机变量，

$$
P(x\le X \le x + \delta | Y \approx y ) \approx f_{X|Y}(x|y) \cdot \delta
$$

注意，用的是 $ Y \approx y $，这里有个比较 trick 的地方。
如果事件 Y 的概率是 0，那么，无法定义 Y 发生时的条件概率。
而连续随机变量，在任何一点都满足 $ P(Y=y) = 0 $。
所以，$ Y=y $ 的时候，没有条件概率。此处用 $ Y \approx y $, 含义是 Y 无限逼近 y。
实践，一般不用"无限逼近"这么严格的表达，就直接近似的说是 $ Y=y$。

定义：

$$
f_{X|Y}(x|y) = \frac {f_{X,Y}(x,y)} {f_Y(y)} \qquad \text{if} \quad f_Y(y) > 0
$$

For Given $y$, conditional PDF is a (normalized) "section" of the joint PDF

如果 X，Y 相互独立，$ f_{X,Y} = f_X f_Y $, 则

$$
f_{X|Y} (x|y) = f_X(x)
$$

满足条件概率的定义，Y 没有提供任何关于 X 的信息。

# 经典分布

## Gaussian (Normal) PDF 高斯（正态）分布

standard normal: $ N(0, 1) $

\begin{align}
f_X(x) &= \frac {1} {\sqrt{2 \pi}} \exp^{-x^2/2} \\\\
E[X] &= 0 \\\\
\text{var}[X] &= 1
\end{align}

对 x 做平移和振幅的缩放（压振幅的时候，因为积分依旧是 1，所以，一定变宽）

general normal: $ N(\mu, \sigma^2) $

\begin{align}
f_X(x) &= \frac {1} {\sigma\sqrt{2 \pi}} \exp^{-(x-\mu)^2/2\sigma^2} \\\\
E[X] &= \mu \\\\
\text{var}[X] &= \sigma^2
\end{align}

套娃的情况

令，$ Y = a X + b $,

根据线性随机变量的性质，

- $ E[Y] = aE[X] + b = a \mu + b $
- $ \text{var}[Y] = a^2\text{var}[X] = a^2\sigma^2 $

所以，Y 依旧是高斯分布：

$$ Y \sim N(a\mu + b, a^2\sigma^2) $$

# 练习题

## 1. uniform random variable 均匀随机变量

这个例子比较简单，名字自带关键信息量。

注意，计算 E 的时候，类似离散随机变量，可以用质心的方法快速写答案。

都是比较基础的微积分运算。

![](https://images.jackon.me/math-prob-uniform-random-variable.png)

## 2. 根据 $ f_X(x) $ 计算 CDF

很简单，但，非常有助于理解 CDF 的基本概念。

直接看课件截图

![](https://images.jackon.me/math-prob-cdf-example.jpg)
