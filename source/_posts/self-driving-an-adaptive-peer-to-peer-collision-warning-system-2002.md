---
title: 【Paper Reading】An Adaptive Peer-to-Peer Collision Warning System
date: 2021-06-28 23:42:16
categories: 自动驾驶
tags: [自动驾驶, motion prediction, safety assessment]
mathjax: true
---

# 论文概况

- title：An Adaptive Peer-to-Peer Collision Warning System
- 链接：[https://www.semanticscholar.org/paper/An-adaptive-peer-to-peer-collision-warning-system-Miller-Huang/7493cabc2871bbdfb0db7fb5d53ab7ea6be4fe10](https://www.semanticscholar.org/paper/An-adaptive-peer-to-peer-collision-warning-system-Miller-Huang/7493cabc2871bbdfb0db7fb5d53ab7ea6be4fe10)
- 作者：Ronald Miller（福特研究院，Dearborn）, Qingfeng Huang(华盛顿大学)
- 时间（首次、第一版）：2002
- 引用：233
- 5 页，14 个参考文献。
- 阅读价值：insight 一般，但抄作业非常有用。两车碰撞的模型清晰，公式明确，不用自己从头推演了。

*摘要*

Cooperative vehicle collision warning system is made possi- ble by recent progress in advanced positioning systems and wireless com- munication technology. In this paper we report our work in developing a cooperative intersection collision warning system that is not limited by the requirement of line-of-sight. The novel elements of the system include the use of a dynamic ad hoc wireless network for peer-to-peer data sharing, a new intersection collision warning algorithm, and a flexible and extensible software architecture and system design. The very same system is also ca- pable of collision warning for other scenarios such as frontal and rear-end. Further, the tunable parameters in the algorithm make it possible for the system to adapt to the preference and capability of each individual driver.


# 背景讨论

intersection collisions 不如 forward collision 受重视，因为更复杂，以及雷达的硬件水平限制。

雷达有 line-of-sight 的限制，在大部分 intersection collisions 事故中，基本都是由于 line-of-sight 看不到对方车，看到的时候已经来不及躲避了。

作者提出了基于 GPS 的车车交互，解决 line-of-sight。（这部分，我不关心，笔记不整理）

# intersection collisions 碰撞模型

top-down 的设计了 specification

## Top-Level ICWS Specification

ICWS 是 Intersection Collision Warning System 的缩写

有 4 条：

1. At most one warning is given at one intersection.
2. No warning if there is no route contention.
3. No warning if the driver has already taken appropriate action.
4. Nowarningifthetime-to-collision(TTC)ismuch greater than time-to-avoidance(TTA).

第 4 条，特别有趣。作者解释：With all of the uncertainties on the road, a warning issued too early is more likely to be a false alarm, which is not desirable. 简单来说，路况的不确定性太高了，提前太久的 warning 基本都是 false alarm。


## Top Level CWS Algorithm

![](https://images.jackon.me/self-driving-cws-algoritm.png)

## 两车相碰的数学描述

![](https://images.jackon.me/self-driving-two-route-contention.png)

the expected path intersection $ (x_+, y_+) $ 计算方法如下：

\begin{align}
x_+ &= \frac {(y_2 −y_1)−(x_2 \tan \theta_2 −x_1 \tan \theta_1) } {\tan \theta_1 - \tan \theta_2} \\\\
y_+ &= \frac {(x_2 − x_1)−(y_2 \cot\theta_2 −y_1 \cot\theta_1)} {\cot\theta_1 − \cot\theta_2}
\end{align}

根据交点，计算 2 车的 TTX（time-to-intersection）：

\begin{align}
\text{TTX}_1 &=  \frac {| \vec r_\+ - \vec r_1 | } { | \vec v_1 | } \mathrm{sign} ((\vec r_\+ - \vec r_1) \cdot \vec v_1) \\\\
\text{TTX}_2 &= \frac {| \vec r_\+ - \vec r_2 | } { | \vec v_2 | } \mathrm{sign} ((\vec r_\+ - \vec r_2) \cdot \vec v_2)
\end{align}

其中，$ \vec r_n $ 向量表示位置点 $(x_n, y_n)$，$\text{sign}()$ 是符号函数，如果为负，表示不会经过交点。

如果 $ TTX_1 = TTX_2 $ 且大于 0, 则相碰。得到 time-to-collision(TTC) 公式：

$$
\text{TTC}_i =
\begin{cases}
\text{TTX}_i \quad & \text{if there is a route contention}\\\\
\text{Undefined} \quad & \text{otherwise}
\end{cases} 
$$

考虑到 2 车的尺寸等，可以引入 $ \alpha $ 参数，把相碰的条件从相等改为：

$$ | TTX_1 - TTX_2 | < \alpha $$

## time to avoidance(TTA)

在已检测到碰撞的前提下，2 种情况不用告警：

1. 车辆已采取规避措施
2. 距离 TTC 时间还远（见前面 ICWS specification 第 4 条）

规避时间，是考虑了人的反应时间 + 采取规避措施的时间。

其中，采取规避措施的时间，可能因为规避措施不同而不同。比如，刹车、加速、变向。

也可以简化为，用同一个常量。


# 总结

1. ICWS Specification 和 CWS Algorithm 是非常有意义的工作。
2. 这是一篇比较有实操意义的作弊神器，insight 一般。
3. 文章有一半篇幅讨论用 GPS 作为车车通信，解决 line of sight 问题。不是我关注的内容，未整理到笔记里。
4. 虽然笔记给出了详细公式和推导过程，但仅供参考，落地的时候，照着原文抄更安全。
