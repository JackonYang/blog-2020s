---
title: MathJax 中常用的 Latex 命令 cheatsheet
date: 2021-06-12 10:08:57
tags: [MathJax, Latex, cheatsheet]
mathjax: true
---

参考文章：

- [MathJax basic tutorial and quick reference](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)
- [Hexo 支持 LaTeX 写数学公式](https://jackon.me/article/hexo-custom-theme-and-improvements/)

# 常用 cheatsheet

## 希腊字母 MathJax 命令

| 名称 | 大写 | MathJax | 小写 | MathJax |
| --- | --- | --- | --- | --- |
| alpha | $A$ | A | $\alpha$ | \alpha |
| beta | $B$ | B | $\beta$ | \beta |
| gamma | $\Gamma$ | \Gamma | $\gamma$ | \gamma |
| delta | $\Delta$ | \Delta | $\delta$ | \delta |
| epsilon | $E$ | E | $\epsilon$ | \epsilon |
| zeta | $Z$ | Z | $\zeta$ | \zeta |
| eta | $H$ | H | $\eta$ | \eta |
| theta | $\Theta$ | \Theta | $\theta$ | \theta |
| iota | $I$ | I | $\iota$ | \iota |
| kappa | $K$ | K | $\kappa$ | \kappa |
| lambda | $\Lambda$ | \Lambda | $\lambda$ | \lambda |
| mu | $M$ | M | $\mu$ | \mu |
| nu | $N$ | N | $\nu$ | \nu |
| xi | $\Xi$ | \Xi | $\xi$ | \xi |
| omicron | $O$ | O | $\omicron$ | \omicron |
| pi | $\Pi$ | \Pi | $\pi$ | \pi |
| rho | $P$ | P | $\rho$ | \rho |
| sigma | $\Sigma$ | \Sigma | $\sigma$ | \sigma |
| tau | $T$ | T | $\tau$ | \tau |
| upsilon | $\Upsilon$ | \Upsilon | $\upsilon$ | \upsilon |
| phi | $\Phi$ | \Phi | $\phi$ | \phi |
| chi | $X$ | X | $\chi$ | \chi |
| psi | $\Psi$ | \Psi | $\psi$ | \psi |
| omega | $\Omega $ | \Omega | $\omega$ | \omega |


## 常用数学结构

矩阵、上标、下标、分数等特殊数学结构

| 分类 | MathJax 命令 | 预览 | 备注 |
| --- | --- | --- | --- |
| 上下标 | `x_i^2`, `x^{y^z}` | $x_i^2\ x^{y^z}$ | `^` 和 `_`, 可以用 `{}` 包起来 |
| 分数 | `\frac {x+y} {xy}` | $\frac {x+y} {xy}$| 也可以 `x/y` -> $ x/y $ |
| 根号 | `\sqrt 2`, `\sqrt[3]{\frac xy}` | $\sqrt 2\ \sqrt[3]{\frac xy}$ | 几次方根，用 `[]` 标记 |
| 极限 | `$$ \lim_{x\to 0} $$` | $$ \lim_{x\to 0} $$ | 行间公式 |
| 短顶部标记 | `\hat x`, `\bar x`, `\vec x`, `\dot`, `\ddot` | $\hat x\ \bar x\ \vec x\ \dot x\ \ddot y$ | |
| 长顶部标记 | `\widehat {xyz}`, `\overline {xyz}`, `\overrightarrow {xyz}`, `\overleftrightarrow {xyz}` | $\widehat {xyz}\ \overline {xyz}\ \overrightarrow {xyz}\ \overleftrightarrow {xyz} $ | 要用 `{}` 包起来|
| 排列 | `{n+1 \choose 2k}`或`\binom{n+1}{2k}` | ${n+1 \choose 2k}$
| 模运算 | `b\pmod n` | $b\pmod n$ | 没有 b 和 n，无法预览 |


## 常用数学符号

键盘打不出来的数学符号

<!-- MathJax 支持大量特殊符号，这里罗列一部分，更多请参考：[this shorter listing](http://pic.plover.com/MISC/symbols.pdf)和[this exhaustive listing](http://mirror.math.ku.edu/tex-archive/info/symbols/comprehensive/symbols-a4.pdf) -->

| 分类 | MathJax 命令 | 预览 | 备注 |
| --- | --- | --- | --- |
| 比较 | `\lt \gt \le \ge \neq` | $\lt\ \gt\ \le\ \ge\ \neq$ | 前面可以加`\not`，`\not\lt` -> $\not\lt$ |
| 集合 | `\cup \cap \setminus \subset \subseteq \subsetneq \supset \in \notin \emptyset \varnothing` | $\cup\, \cap\, \setminus\, \subset\, \subseteq \,\subsetneq \,\supset\, \in\, \notin\, \emptyset\, \varnothing$ | |
| 求和与积分 | `\sum`, `\prod`, `\bigcup`, `\bigcap`, `\int`, `\iint`, `\iiint`| $ \sum\ \prod\ \bigcup\ \bigcap\ \int\ \iint\ \iiint $ | |
| 微积分 | `\nabla \partial` | $\nabla\, \partial$ | |
| 四则运算 | `\times \div \pm \mp \cdot` | $\times\ \div\ \pm\ \mp \cdot$ | `+ -` 直接用即可 |
| 箭头 | `\to \rightarrow \leftarrow \Rightarrow \Leftarrow \mapsto` | $\to\, \rightarrow\, \leftarrow\, \Rightarrow\, \Leftarrow\, \mapsto$ | |
| 逻辑操作 | `\land \lor \lnot \forall \exists \top \bot \vdash \vDash` | $\land\, \lor\, \lnot\, \forall\, \exists\, \top\, \bot\, \vdash\, \vDash$ | |
| 星号 | `\star \ast \oplus \circ \bullet` | $\star\, \ast\, \oplus\, \circ\, \bullet$ | |
| 等号变体 | `\approx \sim \simeq \cong \equiv \prec \triangleq` | $\approx\, \sim \, \simeq\, \cong\, \equiv\, \prec\ \triangleq$ | |
| 无穷 | `\infty \aleph_0` | $\infty\, \aleph_0$ | |
| 复数 | `\Im \Re` | $\Im\, \Re$ | |
| 多点 | `\ldots`, `\cdots` | $\ldots \cdots$ | $ a_1, a_2, \ldots ,a_n $ |
| 变体的希腊字母 | `\epsilon \varepsilon \phi \varphi` | $ \epsilon\ \varepsilon\ \phi\ \varphi $ | |
| 手写体 | `\ell` | $ \ell $ | |


## 字体

| 命令 | 名称 | 预览 |
| --- | --- | --- |
| `\mathbb` | 黑板粗体 |  $\mathbb{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ <br/> \mathbb{abcdefghijklmnopqrstuvwxyz} |
| `\mathbf` | 黑体 | $\mathbf{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ <br/>$\mathbf{abcdefghijklmnopqrstuvwxyz}$ |
| `\mathtt` | 打印机字体 | $\mathtt{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ $\mathtt{abcdefghijklmnopqrstuvwxyz}$ |
| `\mathrm` | 罗马字体 | $\mathrm{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ $\mathrm{abcdefghijklmnopqrstuvwxyz}$ |
| `\mathsf` | 无衬线字体 | $\mathsf{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$<br/>$\mathsf{abcdefghijklmnopqrstuvwxyz}$ |
| `\mathcal` | 书法体 | $\mathcal{ ABCDEFGHIJKLMNOPQRSTUVWXYZ}$
| `\mathscr` | 手写体 | $\mathscr{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$
| `\mathfrak` | Fraktur<br/>德文黑体字 | $\mathfrak{ABCDEFGHIJKLMNOPQRSTUVWXYZ}$ <br/> $\mathfrak{abcdefghijklmnopqrstuvwxyz}$ |


# 新手入门

## 查看公式源码

网页上，鼠标在公式上点击右键，选择`Show Math As`（数学显示形式）、`TeX Commands`（TeX命令）即可。公式的源码会在新窗口弹出，注意，弹出的公式不会包含 MathJax 的定界符 `$`。

## 公式手写识别

针对不熟悉、不适应输入公式源码的人，推荐手写识别，工具会识别并给出相似的符号及其代码。

这类工具越来越多，识别准确率、速度略有差别。以下可以试试：

- [Detexify](http://detexify.kirelabs.org/classify.html)

## 行内和行间公式

- 行内公式: `$`
- 行间公式: `$$`

例如，`$ x+y=0 $` 是行内公式，效果：$x+y=0$。`$$ x+y=0 $$` 是行间公式，效果：$$x+y=0$$

## 转义与换行

*MathJax 的转义、换行和 Latex 不一样*

Latex 里，`\` 是转义的引导符号，在 MathJax 里，所有使用 `\` 地方，数量都要翻倍。

我的猜测。markdown 语法解析器先处理，然后把生成的文本传给 Latex 解释器。
markdown 翻译的时候，走普通字符串的转义逻辑，用掉一组 `\`，Latex 解释器处理的时候，还需要用掉 1 个 `\` 作为的转义引导词。

Latex 里，公式换行是 `\\`，在 MathJax 要用 `\\\\`，例如，`x = a + b \\\\ y = a * b` 的效果是：

$$ x = a + b \\\\ y = a * b $$

MathJax 里，如果在公式中需要直接显示特殊符号，使用`\\`进行转义。例如：`\\$`-> $\\$$。

显示 `\` 自己，要用 `\backslash`，效果是 $\backslash$。用 `\\` 不行。

## 对齐多行公式

多行公式默认是居中对齐的，非常不美观。

延续 Latex 的语法，MathJax 也可以手动控制对行公式的对齐方式和对齐位置。

具体的语法是：

1. 用 `\begin{align}…\end{align}` 包住公式，不再需要 `$$ ... $$` 的方式，
2. 在想要对齐的位置，用 `&` 标记，
3. 换行的地方，用 `\\\\`，注意是 4 个，不是 2 个 `\`。

比如，按照 `=` 的位置对齐多行公式，源码和效果如下：

```latex
\begin{align}
\text{var}(X) &= E (X−E[X])^2 \\\\
              &=\sum_x(x-E[X])^2p_X(x) \\\\
              &= E[X]^2 - (E[X])^2
\end{align}
```

\begin{align}
\text{var}(X) &= E (X−E[X])^2 \\\\
              &=\sum_x(x-E[X])^2p_X(x) \\\\
              &= E[X]^2 - (E[X])^2
\end{align}

## 修改数学公式的颜色

可以用颜色来强调公式内的要点，直接看例子。

源码：`\color{red}{x} + \color{blue}{y}`

效果：$ \color{red}{x} + \color{blue}{y} $

## 分段函数 piecewise functions

直接看例子，

源码：

```latex
$$
X_i =
\begin{cases}
1,  & \text{if success in trial }i, \\\\
0, & \text{otherwise}
\end{cases}
$$
```

效果

$$
X_i =
\begin{cases}
1,  & \text{if success in trial }i, \\\\
0, & \text{otherwise}
\end{cases}
$$

## 括号组

- `()[]` 直接用 。例如 $(2+3)[4+4]$
- `{}` 需要转义 `\\{`，`\\}`。$\\{1, 2, \cdots, n\\}$
- 尖括号`<>`使用`\langle`和`\rangle`来表示：$\langle x \rangle$。

## 自适应显示

为了更优雅好看，有时需要括号自适应缩放，用`\left` 和 `\right` 修饰。

例如，公式`\left( \frac {x^3} {y^{y^3}} \right)`展示为

$$\left( \frac {x^3} {y^{y^3}} \right)$$

若不带自适应，效果为

$$( \frac {x^3} {y^{y^3}} )$$

除了括号外，同样可以应用在

- `|` $|x|$
- `\vert` $\vert x \vert$
- `\Vert` $\Vert x \Vert$
- 向上取整`\lceil`和`\rceil` $\lceil x \rceil$
- 向下取整`\lfloor`和`\rfloor` $\lfloor x \rfloor$

## 空格

通常情况下 MathJax(Latex) 会忽略常规的空格。
在公式中可以嵌入`\text{...}`，表示改为文本而非公式模式，空格将会保留。

空格的表述方式：

- `\ ` 加空格 $a\ b$
- `\quad` 和 `\qquad` 表示更大的空格 $a\quad b$, $a\qquad b$

## 函数

公式里，默认字体是斜体，前后不留白。而函数名字，一般是常规罗马字体，前后留白。

大部分函数，可以用 `\` + 函数名字来改变字体。比如：`sin`、`lim`、`max`、`ln`

`$$ sin x\ lim\ y\ max\ ln y$$` 手动部分留白后，效果为：

$$ sin x\ lim\ y\ max\ ln y$$

`$$ \sin x \lim y\max y \ln y $$` 自动改名字并留白

$$ \sin x \lim y\max y \ln y $$
