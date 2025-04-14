---
title: "Integers of the form $x^2+2y^2$"
date: 2024-05-27
description: Integers of the form $x^2+2y^2$
tags: ['random-math']
mathjax: yes
toc: yes
last_modified_at: 2024-08-22
header:
    teaser: "https://as2.ftcdn.net/v2/jpg/02/99/84/89/1000_F_299848927_S0EwX0P6HWGigW6qZWFIBaczKMQuq5D9.jpg"
---

<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.3/MathJax.js?config=TeX-MML-AM_CHTML">
    MathJax.Hub.Config({
        tex2jax: {
            inlineMath: [["$", "$"], ["\\(", "\\)"]],
            processEscapes: true
        }
    });
</script>

<style>
.no_bullet {
  list-style: none;
}
</style>


<font size="4">
<p> 
I found the picture of this problem and my solution when I was scrolling through Google Photos at LAX waiting for my flight (yes, I was very bored). I don't vividly remember when and what this problem was for, but it must have been a part of my math olympiad practice, given that it is a typical math olympiad-y number theory problem and the picture was taken when I was in high school.
</p>

<p>I do remember, however, struggling and spending a lot of time on this problem. I think it is worth going over it again for fun.</p>
</font>

### Problem Statement

<font size="4">
<p> 
<b>Problem.</b> Find all integers of the form $x^2 + 2y^2$ where $x,y \in \mathbb{Z}$. 
</p>
</font>

### Lemma 1

<font size="4">
<p> 
<b>Lemma 1.</b> Let $p$ be a prime number that divides $x^2 + 2y^2$. If $p \equiv 5$ or $7 \; (\textrm{mod } 8)$, then $p$ divides both $x$ and $y$. 
</p>

<p><i>Proof of Lemma 1.</i> Suppose $p \not\mid x$. Then $p \not\mid y$ because $p \mid x^2 + 2y^2$ and so modular inverse of $x$ and $y$ in $\text{mod } p$ exist. Let $y^{-1}$ denote the inverse of $y$. Then,</p>

\[
\begin{align*}
x^2 + 2y^2 \equiv 0 \; (\textrm{mod } p) 
& \iff x^2 \equiv -2y^2  \; (\textrm{mod } p) \\
& \iff (x y^{-1})^2 \equiv -2  \; (\textrm{mod } p)
\end{align*}
\]

<p>However (here, $( \frac{a}{p} )$'s are the Legendre/Jacobi symbols),</p>

\[
\begin{align*}
\left( \frac{-2}{p} \right) 
& = \left( \frac{-1}{p} \right) \left( \frac{2}{p} \right) && (\because \textsf{Properties of Legendre symb.}) \\
& = \left( -1 \right)^{\frac{p-1}{2}} \left( \frac{2}{p} \right) && (\because \textsf{Euler's criterion}) \\
& = \left( -1 \right)^{\frac{p-1}{2}} \left( -1 \right)^{\frac{p^2-1}{8}} && (\because \textsf{Gauss' Lemma}) \\
& = \left( -1 \right)^{\frac{p^2 + 4p - 5}{8}} \\
& = \left( -1 \right)^{\frac{(p+5)(p-1)}{8}}
\end{align*}
\]

<p>So if $p$ was of the form $p = 8k+5$ for some $k \in \mathbb{Z}$, </p>

\[
\left( \frac{-2}{p} \right) = \left( -1 \right)^{\frac{2(4k+5)(8k+4)}{8}} = \left( -1 \right)^{(4k+5)(2k+1)} = -1
\]

<p>and if $p$ was of the form $p = 8k+7$ for some $k \in \mathbb{Z}$, </p>

\[
\left( \frac{-2}{p} \right) = \left( -1 \right)^{\frac{(8k+12)(8k+6)}{8}} = \left( -1 \right)^{(2k+3)(4k+3)} = -1
\]

<p>
Hence, if $p \equiv 5$ or $7 \; (\textrm{mod } 8)$, the solution to $X^2 \equiv -2 \; (\textrm{mod } p)$ does not exist, which contradicts the assumption that $p \not\mid x$. Therefore, if $p \equiv 5$ or $7 \; (\textrm{mod } 8)$, then $p \mid x$ and, as $p \mid x^2 + 2y^2$, we also have $p \mid y$. $\quad \square$ 
</p>
</font>

### Lemma 2

<font size="4">
<p> 
<b>Lemma 2.</b> The multiple of two integers of the form $a^2 + 2b^2$ is also an integer of the form $a^2 + 2b^2$ where $a,b \in \mathbb{N}\cup \{0\}$.   
</p>

<p><i>Proof of Lemma 2.</i> Let $a,b,c,d \in \mathbb{N}\cup \{0\}$.
\[
\begin{align*}
(a^2 + 2b^2) (c^2 + 2d^2) 
& = (a^2 c^2 + 4 b^2 d^2) + 2(b^2 c^2 + a^2 d^2) \\
& = (a^2 c^2 + 4 abcd + 4b^2 d^2) + 2 (b^2 c^2 - 2abcd + a^2 d^2) \\
& = (ac+2bd)^2 + 2(bc-ad)^2 && \hspace{-1.5cm} \square
\end{align*}
\]
</p>
</font>

### Lemma 3

<font size="4">
<p> 
<b>Lemma 3.</b> Let $p$ be a prime of the form $p \equiv 1,2,$ or $3 \; (\textrm{mod } 8)$. There exist nonnegative integers $a$ and $b$ such that $p = a^2 + 2b^2$.  
</p>

<p><i>Proof of Lemma 3.</i> The only prime of the form $p \equiv 2\; (\textrm{mod } 8)$ is $p = 2$ which is $2 = 0^2 + 2 \cdot 1^2$. </p>

<p>Consider the case where $p \equiv 2\; (\textrm{mod } 8)$. Let $k := \lceil \sqrt{p} \rceil + 1$ and </p>

\[
S_a := \{ ax+y \mid 0 \leq x, y \leq k-1 \}
\]

<p>It is clear that $\lvert S_a \rvert = k^2 > p$. So by the pigeonhole principle, there exists two distinct pairs $(x_1, y_1)$ and $(x_2, y_2)$ such that
</p>

\[
ax_1 + y_1 \equiv ax_2 + y_2 \; (\textrm{mod } p) 
\]

which is equivalent to
\[
a(x_1 - x_2) + (y_1 - y_2) \equiv 0 \; (\textrm{mod } p) 
\]

Denote $x_0 := x_1 - x_2$ and $y_0 := y_1 - y_2$. Then $0 < \lvert x_0 \rvert \leq k-1$ and $0 < \lvert y_0 \rvert \leq k-1$ and hence $a \lvert x_0 \rvert + \lvert y_0 \rvert \in S_a$ and $a \lvert x_0 \rvert + \lvert y_0 \rvert \equiv 0$ $\;(\textrm{mod } p)$. That is, $x$ and $y$ that satisfies the congruence $ax \equiv y \; (\textrm{mod } p)$ exists in the range:
\[
0 \leq x,y \leq k-1 = \lceil \sqrt{p} \rceil < \sqrt{p}
\]
Meanwhile, as we have seen in the proof of <a href="./#lemma-1">Lemma 1</a> already,
\[
\begin{align*}
\left( \frac{-2}{p} \right) = \left( -1 \right)^{\frac{(p+5)(p-1)}{8}}
\end{align*}
\]
Hence, if $p \equiv 1$ or $3 \; (\textrm{mod } 8)$, then $( \frac{-2}{p}) = 1$ and so there exists $a$ such that $a^2 \equiv -2 \; (\textrm{mod } p)$. Given such an $a$, and for $x$ and $y$ such that $ax \equiv y \; (\textrm{mod } p)$, 
\[
\begin{align*}
ax \equiv y \; (\textrm{mod } p)
& \iff a^2 x^2 \equiv y^2 \; (\textrm{mod } p) \\
& \iff -2x^2 \equiv y^2  \; (\textrm{mod } p) \\
& \iff 2x^2 + y^2 \equiv 0 \; (\textrm{mod } p)
\end{align*}
\]
As $0<x,y<\sqrt{p}$, we get $0<2x^2+y^2<3p$ and so the only possibilities are $2x^2 +y^2 = p$ and $2p$.

<ul>
<li>If $2x^2 + y^2 = 2p$, then $y^2 = 2(p - x^2)$ is even and hence $y$ must be even. Substituting $y = 2y'$ gives us

\[
2x^2 + y^2 = 2x^2 + 4y'^2 = 2p \iff x^2 + 2y'^2 = p
\]

Hence, $p$ can be written in a form of $a^2 + 2b^2$.</li>
<li> If $2x^2 + y^2 = p$, then $p$ is already in a form of $a^2 + 2b^2$, whence the statement.</li>
</ul>
Therefore, for all primes $p$ such that $p \equiv 1,2,3 \; (\textrm{mod } 8)$, there exist non-negative integers $a$ and $b$ such that $p = a^2 + 2b^2$. $\quad \square$
</font>

### Solution

<font size="4">
<p> 
Now we provide the solution to the <a href="./#problem-statement">problem</a>. 
</p>

<p><i>Solution.</i> Denote $x^2 + 2y^2 = n$ and represent $n = ms^2$ where $m, s \in \mathbb{N}$ and $m$ is square-free.</p>

Define the following two subsets of $\mathbb{N}$:
\[
\begin{align*}
A & = \{ n \mid n = ms^2 \textsf{ where } m, s \in \mathbb{N}, m \textsf{ is square-free,} \\
& \qquad \qquad \textsf{ and } p \not\equiv 5,7 \; (\textrm{mod } 8) \textsf{ for all prime } p \textsf{ s.t. } p \mid m, \} \\
\tilde{A} & = \{ x^2 + 2y^2 \mid x,y \in \mathbb{N} \cup \{0\} \}
\end{align*}
\]

We shall prove $A = \tilde{A}$.

<h6> Step 1: $\tilde{A} \subseteq A$. </h6>


<p> We first prove that if $p^\alpha \| x^2 + 2y^2$ for some $\alpha \in \mathbb{N} \cup \{0\}$ and $p \equiv 5, 7$ $(\textrm{mod } 8)$, then $2 \mid \alpha$. Here, $p^x \| n$ is the notation for the maximum $x$ such that $p^x \mid n$ yet $p^{x+1} \not\mid n\;$ (i.e., <a href="https://en.wikipedia.org/wiki/P-adic_valuation">$p$-adic order</a> of $n$). </p>

<p>Assume for the sake of contradiction that $\alpha$ is odd, i.e. $\alpha = 2k+1$ where $k \in \mathbb{N} \cup \{0\}$.</p>

<p><b>Claim 1</b>. $p^n \mid x,y$ for all $n \leq k+1$. </p>
<p><i>Proof of Claim 1</i>. We prove by mathematical induction. </p>

<ul>
<li>Base case: When $n = 0$. $p^n = 1 \mid x,y$ and hence the statement holds.</li>
<li>Inductive hypothesis: Suppose that $p^\ell \mid x,y$ for some $\ell \leq k$.
</li>
<li class="no_bullet">Inductive step: Suppose that the inductive hypothesis is true, i.e. $p^\ell \mid x,y$ where $\ell \leq k$. Then since $k-\ell \geq 0$,

\[
\begin{align*}
p \mid p^{2(k-\ell) + 1} \; \| \left( \frac{x}{p^\ell} \right)^2 + 2 \left( \frac{y}{p^\ell} \right)^2
\end{align*}
\]

This implies

\[
\begin{align*}
p \mid \left( \frac{x}{p^\ell} \right)^2 + 2 \left( \frac{y}{p^\ell} \right)^2
& \implies p \mid \frac{x}{p^\ell}, \frac{y}{p^\ell} && (\because \textsf{Lemma 1}) \\
& \implies p^{\ell + 1} \mid x, y
\end{align*}
\]

Therefore, if $p^\ell \mid x,y$ then $p^{\ell + 1} \mid x,y$. This proves the claim. $\quad \square$
</li>
</ul>
<p> By Claim 1, $p^{n} \mid x,y$ for all $n \leq k+1$, and so we know $p^{k+1} \mid x,y$ which makes $p^{2k+2} \mid x^2, y^2$. Then $p^{2k+2} \mid x^2 + 2y^2$, but this contradicts the fact that $p^{2k+1} \| x^2 + 2y^2$. Hence, $\alpha$ cannot be odd. 
</p>

<p>Consequentially, for all $p$ such that $p \equiv 5, 7 \; (\textrm{mod } 8)$ has an even power in $n$, hence goes into the $s$ term in $n = ms^2$; more precisely, for any $n \in \tilde{A}$, if $n$ were to represented as $n = ms^2$, if $p \equiv 5,7 \; (\textrm{mod } 8)$ then $p \not\mid m$. Therefore, $n \in A$ and hence $\tilde{A} \subseteq A$.</p>

<h6> Step 2: $\tilde{A} \supseteq A$. </h6>

<p>For any $n = ms^2 \in A$, let $m = p_1 p_2 \cdots p_k$. By definition of $A$, all $p_i$'s are $p_i \equiv 1,2,3 \; (\textrm{mod } 8)$, and so by <a href="./#lemma-3">Lemma 3</a>, there exist $a_1, b_1,\dots, a_k, b_k$ $\in \mathbb{N} \cup \{0\}$ such that

\[
p_1 = a_1^2 + 2b_1^2, \; p_2 = a_2^2 + 2b_2^2, \; \dots, \; p_k = a_k^2 + 2b_k^2 
\]

Then by <a href="./#lemma-2">Lemma 2</a>, there exists $a_t, b_t \in \mathbb{N} \cup \{0\}$ such that

\[
m = p_1p_2 \cdots p_k = (a_1^2 + 2b_1^2) \cdots (a_k^2 + 2b_k^2) = a_t^2 + 2b_t^2
\]

Therefore,
$ms^2 = (s a_t)^2 + 2(s b_t)^2$, making $n = ms^2 \in \tilde{A}$ as well. This proves $A \subseteq \tilde{A}$. 
</p>

<h6> Step 3: $x=y=0$. </h6>

<p>In this case, trivially $x^2 + 2y^2 = 0$. </p>

<h6> Conclusion </h6>
From Step 1 and 2, we conclude that $A = \tilde{A}$. Step 3 suggests that $0$ must be included in $A$. All in one, we conclude the following:
<p></p>

<p style="text-align:center">
<b><i>
An integer $n$ is of the form $x^2 + 2y^2$ iff $n = ms^2$ where $m, s \in \mathbb{N} \cup \{0\}$ then all prime divisors $m$ must not be congruent to $5$ and $7$ in $\textrm{mod } 8$ (i.e., every prime divisor of $n$ that are congruent to $5$ or $7$ in $\textrm{mod } 8$ must be in a power of an even number).
</i></b>
</p>
</font>

