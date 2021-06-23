---
title: 【MIT 概率公开课】01.基本概念、贝叶斯和独立性
date: 2021-06-08 22:32:33
mathjax: true
tags: [数学, 笔记]
---

> 公开课：[MIT 6.041 Probabilistic Systems Analysis and Applied Probability](https://www.youtube.com/watch?v=j9WZyLZCBzs&list=PLUl4u3cNGP61MdtwGTqZA0MreSaDybji8&index=1)
> video 1-3 of total 25
> 重点：讨论不确定性问题的数学框架。a *mathematical framework* for reasoning about uncertainty
> 难点：*贝叶斯公式*和*独立性*。处理实际问题时，可以多用*韦恩图*辅助。


# 学习心得


理解一个问题，要从数学和形象思维 2 个角度分别理解，才是真正的理解。

贝叶斯公式和独立性，都是数学推导非常容易，形象思维的理解则需要花点时间。

形象思维的方法，是否真正理解了问题，也很难准确定义。可能需要反复几次，才能真正融会贯通。


# 重点概念

（自测：根据这个提纲，可以回忆起所有知识点）

1. sample space 样本空间
2. Probability axioms 公理（3 条）
3. Discrete uniform law 古典概型（等可能概型）
4. Conditional probability 条件概率。
    改变 sample space，疾病的阳性检测和发病率之间的关系
5. Bayes' rule 贝叶斯公式
6. Independence 独立性。独立和互斥的关系，条件概率改变独立性。


## 1. Sample space 样本空间


定义：List(set) of possible outcomes

- mutually exclusive：互斥，相互不包含。
- collectively exhaustive：完备可穷举

Art: to be at the 'right' granularity
（选好样本空间的粒度，是一门艺术。）

研究实际问题时，样本空间的选法，可能很多。没有绝对正确或错误的选法，主要看研究的目的、关注的因素等。

outcomes 可以是相互包含的关系，只是计算概率之和时，需要减去交集。


## 2. Probability axioms 公理（3 条）

Event is a *subset* of the sample space.

probability is assigned to events.

outcomes 可能是 Event 中的一个点。

在连续样本空间中，任何一点的概率，都是 0，计算这样的概率没有意义。所以，以 subset 为单位计算概率。

1. Nonnegativity 非负: $ P(A) >= 0 $
2. Normalization 归一: $ P(\Omega) = 1 $
3. Additivity 可加性: if $ A \cup B = \phi $ , then $ P(A \cup B) = P(A) + P(B) $

基于以上 3 条，可以推出概率论的其他公式。

## 3. Discrete uniform law 古典概型（等可能概型）

let all outcomes be equally likely


$$ P(A) = \frac {\text{number of elements of } A} {\text{total number of sample points}} $$

computing probabilities 就是 counting。

关于 counting 的方法，可以参考 [MIT 6.041 -- Course 4](https://www.youtube.com/watch?v=6oV3pKLgW2I&list=PLUl4u3cNGP61MdtwGTqZA0MreSaDybji8&index=5)

## 4. Conditional probability 条件概率


当有人给我们提供了更多信息的时候，需要更新我们的知识。这是条件概率的基本出发点。

条件，改变了 sample space。条件 event，是新的 sample space。

定义：假定 $ P(B) \neq 0 $

$$ P(A | B) = \frac {P(A\cap B)} {P(B)}$$

其中，$ P(A | B) $ undefined if $ P(B) = 0 $

另一个形式，没有了 $ P(B) \neq 0 $ 的约束：

$$ P(A\cap B) = P(B) \cdot P(A | B) $$

条件概率下的可加性：

$$ \text{if } P( A\cap B | C) = 0,\ P(A\cup B | C) = P(A|C) + P(B|C) $$


## 5. Mulltiplication rulle 乘法定理

$$ P(A \cap B \cap C) = P(A) \cdot P(B | A) \cdot P(C | A \cap B) $$

## 6. Total probability theorem 全概率公式

$$ P(B)  = P(A_1)P(B | A_1) +P(A_2)P(B | A_2)+...+ P(A_n)P(B | A_n) $$

## 7. Bayes' rule 贝叶斯公式

公式虽简单，但变化可以写一本巨著。理解原理、应用，很重要。

\begin{align}
\color{red}{P(A_i|B)} &= \frac {P(A_i \cap B)} {P(B)} \\\\
         &= \color{red}{ \frac {P(A_i)P(B|A_i)} {P(B)} } \\\\
         &= \frac {P(A_i)P(B|A_i)} {\sum_j P(A_j) P(B|A_j)}
\end{align}


$ P(A_i) $ is Prior. initial 'beliefs' 先验概率

$ P(A_i | B) $ 后验概率

- $ A_i \rightarrow B $ cause-effect model 
- $ B \rightarrow A_i $ inference

## 8. Independence 独立性

*独立：事件 A 的信息完全并不会改变我们对 B 的认知。*

\begin{align}
\text{defn:}\ & P(B | A) = P(B) \\\\
\text{=>}\ & P(A \cap B) = P(A) \cdot P(B)
\end{align}

互斥事件，一般不是独立事件。除非 2 个事件里，有 1 个空集。

如果都不是空集，韦恩图无法确定事件是否独立。需要计算具体 number 来确定。

*Conditioning may affect independence*

Conditioning（条件）会改变样本空间。如下图。假定 A 和 B 是独立事件。但，当新的事件 C 作为条件时，A 和 B 变成了互斥事件，不再相互独立。

![](//images.jackon.me/venn-condition-may-change-independence.png)

多个事件的相互独立，定义为，部分事件的发生，不提供其他事件是否发生的信息。
数学定义如下：

$$ P(A_i \cap A_j \cap \cdots \cap A_q) = P(A_i)P(A_q)\cdots P(A_q) $$

for *any distinct indices* $ i, j, \cdots, q$ (chosen from $\\{1, \ldots, n\\}$)

解释：

- 两两之间，一定相互独立。pairwise independence
- 任何事件组合之间，也相互独立。

pairwise independence does not imply Independence

A, B, C 两两相互独立，满足 pairwise independence. 但 A，B，C 之间不一定相互独立。

例子如下图

![](//images.jackon.me/pairwise-condition-example-coin-tosses.png)

- A: first toss is H: P(A) = 1/2
- B: second toss is H: P(B) = 1/2
- C: first and second toss give same result: P(C) = 1/2

由图看出，$ (A \cap B) $ 发生时，C 一定发生，不是相互独立的。

$$ P(C|(A \cap B)) = 1 $$

检查相互独立定义的其他公式，也不满足：

$$ P(A \cap B \cap C) = 1/4 \neq 1/8 $$


# 练习题

## 经典题 - 雷达问题

![](//images.jackon.me/conditional-prob-airplane.jpg)

题目说明：

1. $ P(A) = 0.05 $ 观测时，恰好有飞机的概率

    a. $ P(B|A) = 0.99 $，雷达提醒有飞机
    b. $ P(B^c|A) = 0.01 $，雷达没有发现飞机

2. $ P(A^c) = 0.95 $ 观测时，没有飞机的概率

    a. $ P(B|A^c) = 0.10 $，雷达提醒有飞机
    b. $ P(B^c|A^c) = 0.90 $，雷达没有发现飞机

从 spec 上看，雷达非常准。
但是，雷达报有飞机时，真的有飞机的概率 $ P(A|B) = 0.34 $ 似乎并不太准。

计算过程：

$$ P(A \cap B) = P(A) * P(B|A) = 0.05 * 0.99 = 0.0495 $$

$$ P(B) = P(A) * P(B|A) + P(A^c) * P(B|A^c) = 0.1445 $$

$$ P(A|B) = \frac {P(A \cap B)} {P(B)} = 0.34 $$

那么，这到底是不是一个好的雷达呢？是的。

好的雷达是，在基本不漏报，$ P(B^c|A) $ 小，的前提下，提高 true alarm $ P(A \cap B) $ 的值。

从数学上说，因为大部分时间（0.95）是没有飞机的，即，$ P(A) $ 小，所以，$ P(A \cap B) $ 小，所以，$ P(A | B) $ 一般不会特别高。

形象的说，雷达的报警，由 true alarm 和 false alarm 构成。
因为大部分时间（0.95）是没有飞机的，
所以，false alarm 相对于 true alarm 的比例，就会很高。导致 true alarm $ P(A | B) $ 一般不会太高。

没有雷达时，我们观测到飞机的概率只有 0.05，有了雷达，0.34 的概率看到飞机。
观测效率提高了接近 7 倍。
另外，误报的概率，非常低，只有 0.1。

疾病的阳性检测和发病率之间的关系，也符合同样的规律。

对生活的指导意义是，这些小概率事件，检测结果为阳性（alarm）的时候，实际有问题（true alarm）的概率也没那么高。

从数学上说，上面的计算过程，是很好的概率练习题。有条件概率、乘法定理、全概率公式等。
