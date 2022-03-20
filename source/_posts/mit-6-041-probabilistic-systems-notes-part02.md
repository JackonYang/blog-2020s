---
title: 【MIT 概率公开课】02.离散随机变量的 PMF、数学期望和方差
date: 2021-06-08 23:32:33
mathjax: true
categories: 数学
tags: [数学, 笔记]
---

> 公开课：[MIT 6.041 Probabilistic Systems Analysis and Applied Probability](https://www.youtube.com/watch?v=j9WZyLZCBzs&list=PLUl4u3cNGP61MdtwGTqZA0MreSaDybji8&index=1)
> video 5-7 of total 25
> 重点：用另一种数学语言（PMF）描述 [01.基本概念、贝叶斯和独立性](https://jackon.me/article/mit-6-041-probabilistic-systems-notes-part01/) 研究过的问题。
> 难点：多维的条件概率、联合分布、独立性讨论。
> 另，video 4 (counting) 先跳过，与 video 13 的伯努利过程一起看。

# 心得

1. 先要深刻理解“*随机变量是函数*”，但又与随机过程不一样，要区分开。
2. 一维的随机变量相对简单，算是熟悉 PMF 的前菜。
3. 多维的新概念不多，主要是联合概率分布。但处理实际问题时，需要多练习才能少犯错。
4. 遇事不决，就画概率分布表格。
5. 如果把 PMF 和 条件概率理解透了，联合分布、边缘分布、独立性等都应该感觉很简单。

# 重点概念

（自测：根据这个提纲，可以回忆起所有知识点）

1. 随机变量 和 PMF 计算：是 function，而非 variable。有 2 个性质。
2. 数学期望。 加权平均，期望套娃($ E[g(X)] $) 的 hard & easy 计算方法。
3. 方差和标准差。3 个计算方差的公式。
4. 条件 PMF 和条件期望。深刻理解：在新的样本空间里，缩放 PMF。
5. Total Expectation theorem。比较简单，计算有用。
6. 多维的联合分布和边缘分布。主要公式。用好条件概率就没有新知识，画出分布图更好理解。
7. 联合分布的独立性。帽子问题，重点练一下。
8. 经典分布-几何分布。期望，memoryless property
9. 经典分布-二项分布。期望、方差。


## 1. Random variables 随机变量

An assignment of a value (number) to every possible outcome.

Mathematically: A *function* from the sample space $ \Omega $ to the real numbers.

形象的理解，如下图，从 $ \Omega $ 空间映射到 x 轴上。   

![](//images.jackon.me/math-prob-how-to-compute-pmf.png)

注意：

1. 随机变量，是 function(函数)，不是变量。
2. 一个 sample space 可以有多个 Random variables（多个函数）。
    比如，sample space 是一个班级里的所有学生，Random variables 可以是身高函数、体重函数。
3. $ \Omega $ 中的多个点，可以映射到同一个 real number


Notation:

- random variable X -- 大写
- numerical value x -- 小写

2 个性质：

- 非负：$ p_X(x) \geq 0 $
- 归一：$ \sum_{x} p_X(x) = 1 $

上一节的概率，有 3 个性质。少了可加性。

## 2. Probability mass function (PMF) 分布律

给出随机变量在每一点的概率表示。

两种表示法：

$$ P \\{ X=x_k \\} = p_k,\ k=1,2,\cdots. $$

$$ p_X(x) = P(X=x) = P(\\{ X(w)=x \\})  $$

分布律也可以用表格的形式表示，如

| $ \xi = x_i $ | 0 | 1 | 2 |
| --- | --- | --- | --- |
| $ P\\{\xi = x_i\\} $ | 0.2 | 0.5 | 0.3 |

观察上面👆的表格，满足“随机变量”的 2 个性质：

1. P 不为负数
2. P 和为 1

How to compute a PMF -- $ p_X(x) $：

1. collect all possible outcomes(events in $\Omega $) for which $X$ is equal to $x$
2. add their probabilities
3. repeat for all $x$

又要搬出这张图，对照着理解 PMF 更形象。
![](//images.jackon.me/math-prob-how-to-compute-pmf.png)


要点：

1. 找准 sample space 里的所有互斥事件(x)，并满足 $ \sum P(x) = 1 $ ，
2. 找准 random variable 的所有取值(y)，同样满足 $ sum = 1 $，
3. 找准映射关系，累加起来。


## 3. Expectation 数学期望

数学的说，数学期望就是加权求平均。定义如下：

$$ E[X] = \sum_x x p_X(x) $$

形象的理解，数学期望是 center of gravity of PMF。因此，计算 PMF 图形很规则的 E[X] 时，可以直接写出结果。

例如：

$$ P_X(x) = \frac 1 {n+1} $$

根据定义，

$$ E[x] = 0 * \frac 1 {n+1} + 1 * \frac 1 {n+1} + \cdots + n * \frac 1 {n+1} = \frac n 2$$

求 x 的加权平均，所以，取 x 的中心点，是 $ \frac n 2 $。


如果把*数学期望套娃*，随机变量的随机变量，数学期望怎么计算？

假设 $X$ 是随机变量，$ Y = g(X) $，计算 $Y$ 有 2 个方法：

- Hard：$ E[Y] = \sum_y y P_Y (y) $，在 $X$ 的样本空间里做运算。需要重新找 $Y$ 的 PMF。
- Easy: $ E[Y] = \sum_x g(x) P_X(x) $，基于 $X$ 和 $X$ 的 PMF 来计算。

2 种计算方法的形象理解，还是下面这张经典图。

![](//images.jackon.me/math-prob-rv-of-rv.jpg)

从 sample space 到 X 再到 Y 的转换，可以以 sample space 为最小 element 计算，也可以以 X 为最小 element 计算 Y。如果以 X 计算，那就是 x 的值 $g(x)$ 乘以对应的分布律 $ p_X(x) $


注意：easy 的 $ E[Y] \equiv E[g(x)] $。如果 $g(x)$ 不是线性的，$ E[g(X)] \neq g[E(X)] $

如果 g(x) 是线性函数，则有 3 个性质：

- $ E[\alpha] = \alpha $
- $ E[\alpha X] = \alpha E[X] $
- $ E[\alpha X + \beta] = \alpha E[X] + \beta $

形象地说，线性函数的数学期望，等于数学期望的线性函数。


## 4. 方差和标准差

Variance & Standard Variance

定义，距离 E[X] 的距离的平方的数学期望。

\begin{align}
\text{var}(X) &= E [(X−E[X])^2] \\\\
              &=\sum_x(x-E[X])^2p_X(x) \quad \text{离散的分布，常用}\\\\
              &= E[X^2] - (E[X])^2 \quad \text{中学数值分析常用}
\end{align}

推导过程，不难理解。先用套用 Easy 的期望公式 ： $ E[g(X)] = \sum_x g(x)p_X(x) $

另外，上面推到过程的 3 个式子，都有物理含义，都可以拿来计算方差。

性质

- $ \text{var}(X) \ge 0 $
- $ \text{var}(\alpha X + \beta) = \alpha^2 \text{var}(X) $

标准差

$$ \sigma(X) = \sqrt{\text{var}(X)} $$


## 5. 条件概率的 PMF 和期望

Conditional PMF and expectation

数学定义：

$$ p_{X|A} (x) \triangleq P(X=x|A) $$
$$ E[X|A] = \sum_x x p_{X|A}(x) $$

形象的理解，在新的样本空间里重新计算 PMF 和 expectation 即可。

没有新的概念和知识，但在计算中很实用。

![](//images.jackon.me/math-prob-conditional-pmf-example.png)


在这个特例中，加条件前后的样本空间，PMF 形状不变，只是少了 X=1.

将剩下的概率值做一次缩放即可，从 1/4 缩放到 1/3

## 6. Total Expectation theorem

$$ E[X] = P(A_1)E[X|A_1] + \cdots + P(A_n)E[X|A_n] $$

可以类比全概率公式：

$$ P(B)  = P(A_1)P(B | A_1) + \cdots + P(A_n)P(B | A_n) $$


## 7. Joint PMFs and marginal PMFs 联合分布和边缘分布

在一个 sample space 上可以定义多个随机变量，比如，学生的身高 $ H(x) $ 和体重 $ W(x) $.

随机变量之间，不一定独立，需要作为一个整体来研究。

数学定义：

$$ P_{X,Y}(x,y) = P(X=x \text{ and } Y=y) $$

类似一维随机变量的分布律，二维的叫 联合分布律，也可以用二维表格表示，如下：

![](//images.jackon.me/math-prob-joint-pmf-table-2d.png)

一些公式：

$$ P\\{X=x_i, Y=y_i\\} = p_{ij}, i,j = 1,2,\cdots $$

$$ \sum_{i=0}^{\infty}\sum_{j=0}^{\infty} p_{ij} =1 $$

关于 X 的边缘分布律 marginal PMFs

$$ P\\{X=x_i\\}=\sum_{j=0}^{\infty}p_{ij} $$

关于 Y 的边缘分布律 marginal PMFs

$$ P\\{Y=y_i\\}=\sum_{i=0}^{\infty}p_{ij} $$

条件概率：

$$ p_{X|Y}(x|y) = P(X=x\ |\ Y =y) = \frac {p_{X,Y}(x,y)} {p_Y(y)} $$

$$ \sum_x p_{X|Y}(x|y) = 1 $$

三维的条件分布律

$$ P_X(x) = \sum_{y,z} P_{x,y,z}(x,y,z) $$


## 8. independence 独立性

X, Y, Z 相互独立的定义：

$$ P\\{X=x_i,\ Y=y_i,\ Z=z_i\\} = P\\{X=x_i\\}P\\{Y=y_i\\}P\\{Z=z_i\\} $$

注意，

- 等式左边是一个点的概率，右边是 3 个边缘概率
- 此处的 X，Y，Z 来自同一个 sample space。

如果 X、Y 相互独立，则 $g(x)$ 和 $h(y)$ 也相互独立。满足

$$ E[XY] = E[X] E[Y] $$
$$ E[g(X)h(Y)] = E[g(X)] E[h(Y)] $$
$$ var(X+Y) = var(X) + var(Y) $$

练习题，看二项分布的期望、方差计算。

练习题：the hat problem

![](//images.jackon.me/math-prob-the-hat-example.png)

TODO 帽子问题的方差计算。

# 经典分布

## 1 Geometric 几何分布

### 基本性质

几何级数：$ X = \text{number of coin tosses until first head} $

几何级数的 PMF：$$ p_X{(k)} = (1-p)^{k-1}p \quad k=1,2,\ldots $$

是个等比数列

数学期望：

\begin{align}
E[X] &= \sum_{k=1}^ \infty kp_X(k) \\\\
     &= \sum_{k=1}^\infty k(1-p)^{k-1}p \\\\
     &= 1/p
\end{align}


### Memoryless Property

Given that $X > 2$, the r.v. X − 2 has same geometric PMF

$$ P_{X-2|X>2}(k) = P_X(k) $$

形象的理解，不管已经做了多少次实验，之后第几次遇到硬币朝上，PMF 是不变的。


与前面的条件 PMF 一样，曲线形状不变，做一次放缩。


### 性质推导

Geometric Example 几何分布的例子：

$$ \text{事件}\quad A_1: {X=1},\ A_2: {X>1} $$

解释，

- $ A_1 $ 是第 1 次遇到正面朝上。
- $ A_2 $ 是第 2 次或之后遇到正面朝上。

由 Total Expectation theorem 公式，得

\begin{align}
E[X] = &P(X=1)E[X|X=1] \\\\
       + &P(X>1)E[X|X>1]
\end{align}

其中，

- $ P(X=1) = p $
- $ P(X>1) = 1-p $
- $ E[X|X=1] = 1 $，只有一个事件的条件下，且值为 1（投掷次数）
- $ E[X|X>1] = E[X-1|X-1>0] + 1 = E[X] + 1 $ (Memoryless Property)

代入，得

$$ E[X] = P + (1-p)(E[X] + 1) $$

求得

$$ E[X] = 1/p $$


## 2 Binomial 二项分布

### 基本性质

二项分布：$ X = \text{number of heads in n independent coin tosses} $

二项分布的 PMF:

$$ p_X{(k)} = { n \choose k } p^k (1-p)^{n-k} $$

其中，$ { n \choose k } $ 表示从 n 里选 k 个。[TODO] 计算方法

是个正态分布

数学期望：

\begin{align}
E[X] &= \sum_{k=0}^n k { n \choose k } p^k (1-p)^{n-k} \\\\
     &= n \cdot p
\end{align}

其中，

$$
X_i =
\begin{cases}
1,  & \text{if success in trial }i, \\\\
0, & \text{otherwise}
\end{cases}
$$

$$ X = \sum_i X_i $$

### 性质推导

二项分布是 N 重独立实验，利用独立性计算期望和方差，可以口算。

数学期望的推导：

\begin{align}
E[X_i] &= 1 \cdot p + 0 \cdot (1-p) = p \\\\
E[X] &= n \cdot p
\end{align}

方差的推导：

\begin{align}
&\text{var}(X_i) = p(1-p)^2 + (1-p)(0-p)^2 = p(1-p) \\\\
&\text{var}(X) = np(1-p)
\end{align}

由 $ \text{var}(X) $ 可知， $ p=1/2 $ 时，方差最大，不确定性最大。
