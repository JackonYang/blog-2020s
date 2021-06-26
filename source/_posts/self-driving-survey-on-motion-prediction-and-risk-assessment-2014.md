---
title: 【Paper Reading】A survey on motion prediction and risk assessment for intelligent vehicle
date: 2021-06-27 01:46:33
tags: [自动驾驶, motion prediction, safety assessment]
---

# 论文概况

- title：A survey on motion prediction and risk assessment for intelligent vehicle
- 链接：[https://robomechjournal.springeropen.com/articles/10.1186/s40648-014-0001-z](https://robomechjournal.springeropen.com/articles/10.1186/s40648-014-0001-z)
- 作者：Stéphanie Lefèvre, Dizan Vasquez & Christian Laugier
- 时间（首次、第一版）：2014
- 引用：369
- 14 页，75 个参考文献。
- 阅读价值：非常高。宏观的 Overview 非常好，给出了不错的自动驾驶 risk assessment 方法的分类标准。

*摘要*

With the objective to improve road safety, the automotive industry is moving toward more “intelligent” vehicles. One of the major challenges is to *detect dangerous situations and react* accordingly in order to avoid or mitigate accidents. This requires predicting the likely evolution of the current traffic situation, and assessing how dangerous that future situation might be. This paper is a survey of existing methods for motion prediction and risk assessment for intelligent vehicles. The proposed classification is based on the semantics used to define motion and risk. We point out the tradeoff between model completeness and real-time constraints, and the fact that the choice of a risk assessment method is influenced by the selected motion model.


# motion prediction

分类标准：the kind of hypotheses they make about the modeled entities。即，因素之间相互关系的假设

分 3 类：

- Physics-based：最简单。纯物理学的动力学模型问题。
- Maneuver-based：考虑了驾驶员的决策因素。引入了对人的意图的预测。
- Interaction-aware：进一步增加车与车之间相互影响的因素。

下图可以体现 3 种预测方法的差异：

![](https://images.jackon.me/self-driving-motion-prediction-types.png)

- Physics-based。认为蓝车会直行。
- Maneuver-based。能够预测到蓝车会拐弯，但依旧与自己相撞。
- Interaction-aware。预测的基本符合事实了，蓝车会停下来让行。

三种建模方法的对比：

![](https://images.jackon.me/self-driving-motion-predictin-methods-overview.png)

motion prediction 不是我的关注点，笔记不展开。

# risk assessment

risk 的定义有 2 层：

* physical collision
* behaving differently from predicated

分别展开讨论

## physical collision

典型的 physical collision 预测步骤，分为 2 步：

1. 预测运动物体未来可能的轨迹。也就是前面讨论的 motion prediction
2. 检查 2 个轨迹上任意两点是否会相撞，并给出轨迹总体的碰撞风险评估。

risk assessment 聚焦在 step 2.

physical collision 的 3 个预测方法：

* Binary collision prediction
* Probabilistic collision prediction
* Other risk indicators

### Binary collision prediction

输出明确的 binary 结果，撞 or 不撞。 严格的数学模型，微分方程的计算复杂度很高，很难实时，一般都简化。

2 个简化方法：

* 方法 1：approximate each trajectory by a piecewise-straight line trajectory
* 方法 2 more common：discretize the trajectories and to check iteratively for a collision at each discrete timestep

有的 paper 讨论的是 unavoidable collision，2 种方法：

1. 计算是否存在规避办法，比如 刹车、加速 等。然后计算是否超出了车的动力学极限。
2. consider the entire space of combined steering, braking and accelerating maneuvers, and to perform an optimized search for collision-free trajectories。类似 Inevitable Collision States (ICS) 方法

### Probabilistic collision prediction

考虑车辆运动的不确定性，两种算法：

1. 计算 2 车中点同时出现在一个小区域内（碰撞）的概率。两车中心可能出现的所有组合，是全集。
2. 几何方法，reachable sets 曲线的 overlap 面积。For a normally distributed uncertainty on the current state, a solution based on stochastic linearization via the unscented transformation has been proposed

轨迹的分布模型，一般用 Monte Carlo simulations，或 Gaussian Processes

### Other risk indicators

除了 Binary 和 Probabilistic，还有其他的可用指标：

* the velocity of the vehicles
* the amount of overlap between the shapes representing the vehicles
* the probability of simultaneous occupancy of the conflict area by both vehicles
* the configuration of the collision
* “Time-To-X” (or TTX) where X corresponds to a relevant event in the course toward the collision

    * Time-To-Collision（TTC）
    * Time-To-React(TTR)：The idea is to simulate different driver actions (such as braking, accelerating, steering) and to identify the latest moment at which one of these maneuvers is able to avoid the collision

其中， TTC 可以用作找出最不危险的轨迹的工具。


## Risk based on unexpected behavior

分成 2 类：

* detecting unusual events
* detecting conflicting maneuvers

暂时不关注，不展开。


# 总结

1. risk assessment 的原始需求是 detect dangerous situations and react。react 的效果通常也是 assessment 的一部分。
2. 主流做法：先预测其他车（障碍物）的轨迹 motion prediction，然后基于轨迹评估 risk。
3. motion prediction 的方法不同，对应的 risk assessment 方法也不同。所以，本文也给出了 motion 4. prediction 的综述。
4. 文章对 motion prediction 和 risk assessment 各类工作的分类方法，非常清晰。
5. 文章还部分的讨论了模型的完全精确与实时计算（算力）之间的折衷
