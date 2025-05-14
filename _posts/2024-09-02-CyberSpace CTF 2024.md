---
title: "CyberSpace CTF 2024: trendy windy trigonity"
date: 2024-09-02
description: CyberSpace CTF 2024 trendy windy trigonity Writeup
tags: ['CTF']
mathjax: yes
modified: 2025-05-04
header:
    teaser: "https://ctftime.org/media/cache/2b/a1/2ba1e95fc5f7b5bebd87275d3d4666b0.png"
---

<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.3/MathJax.js?config=TeX-MML-AM_CHTML">
    MathJax.Hub.Config({
        tex2jax: {
            inlineMath: [["$", "$"], ["\\(", "\\)"]],
            processEscapes: true
        }
    });
</script>

<font size="4">
<p>I worked closely with VinhChilling and <a href="https://github.com/Athryx">Athryx</a> on this challenge.</p>
</font>

<font size="5"><b>crypto/trendy windy trigonity</b></font>

<font size="4">
<p>Author: ndr</p>
</font>

<center>
<img src="/images/etc/trigonity_chaldesc.png" width="60%" height="60%">
<p></p>
</center>


```python
### chall.sage

from Crypto.Util.number import bytes_to_long
flag = REDACTED 
print(len(flag)) 
R = RealField(1000)
a,b = bytes_to_long(flag[:len(flag)//2]),bytes_to_long(flag[len(flag)//2:])
x   = R(0.75872961153339387563860550178464795474547887323678173252494265684893323654606628651427151866818730100357590296863274236719073684620030717141521941211167282170567424114270941542016135979438271439047194028943997508126389603529160316379547558098144713802870753946485296790294770557302303874143106908193100)

enc = a * cos(x) + b * sin(x) 

#38
#2.78332652222000091147933689155414792020338527644698903976732528036823470890155538913578083110732846416012108159157421703264608723649277363079905992717518852564589901390988865009495918051490722972227485851595410047572144567706501150041757189923387228097603575500648300998275877439215112961273516978501e45
```



<p>
Initially, because the chal description has the word "Tan," I thought it has to do with the tangent function:
</p>

$$
\begin{align*}
\mathrm{enc} = a \cos(x) + b \sin(x) 
\implies 
& \frac{\mathrm{enc}}{\cos(x)} = a + b \tan(x) \\
& \frac{\mathrm{enc}}{\sin(x)} = \frac{a}{\tan(x)} + b
\end{align*}
$$

<p>
We tried to see if we can extract any information on $a$ and $b$ from here; for example using Cauchy-Schwarz, we got
</p>

$$
\begin{align*}
\left( a + b \tan(x) \right) \left( b + \frac{a}{\tan(x)} \right)
& \geq \left( \sqrt{ab} + \sqrt{b \tan(x) \frac{a}{\tan(x)} } \right)^2 \\
& = (2 \sqrt{ab})^2 = 4ab
\end{align*}
$$

<p>
which seemingly looks promising, but this only bounds $ab$, nothing more or less than that. 
</p>

<p>
Switching gears a little bit, one can notice that $\mathrm{enc} = a\cos(x) + b\sin(x)$ is (a sort of) an diophantine equation whose coefficients are real numbers. Of course, computers cannot represent every real number accurately, some estimations such as floating-point arithmetic is needed. That is exactly what the code does! 
</p>

```python
sage: RealField(1000)
Real Field with 1000 bits of precision
```

We can also test it ourselves and confirm that $\sin(x) \times 2^{1000}$ is indeed an integer in this code. 

```python
R = RealField(1000)
x   = R((see chall.sage))
print(sin(x) * 2**1000)
## 7.37197992602428475741049827451390193213744542258412555738969388717037720188366360093098647866912037478904410433148563631786817428410843570081267371615385910506250335007849867658583148799927112279652168672241222255755810512235881778581996923147579472287732948463405716778993050843497466758474588037770e300
# Note the e300 part at the end.
print(int(sin(x) * 2**1000))
## 7371979926024284757410498274513901932137445422584125557389693887170377201883663600930986478669120374789044104331485636317868174284108435700812673716153859105062503350078498676585831487999271122796521686722412222557558105122358817785819969231475794722877329484634057167789930508434974667584745880377700
# Note that this is exactly the same number as above.
print(int(sin(x) * 2**1000) == (sin(x) * 2**1000))
## True
print(int(sin(x) * 2**900) == (sin(x) * 2**900))
## False
```

<p>
The problem now then becomes a SubsetSum-ish problem with two variables, which we know very well that we can solve using LLL algorithm: one can think of the solution as an element of a vector space, where one vector has the length $\cos(x)$, and the other has $\sin(x)$, and together they span $\mathrm{enc}$ (for now, I will omit the factor $2^{1000}$ for simplicity, until I actually have to write the solve script):
</p>

$$
\mathcal{B} = \begin{bmatrix} \; v_1 \\ v_2 \\ v_3 \end{bmatrix} = \begin{bmatrix} \; 1 & 0 & \cos(x) \\ 0 & 1 & \sin(x) \\ 0 & 0 & -\mathrm{enc} \end{bmatrix}
$$

<p>
So the lattice $\mathcal{L}$ spanned by $\mathcal{B}$ is:
</p>

$$
\begin{align*}
\mathcal{L} 
& = \{ a v_1 + b v_2 + c v_3 \mid a, b, c \in \mathbb{Z}  \} \\
& = \{ (a, b, a \cos(x) + b \sin(x) - c \mathop{\mathrm{enc}}) \mid a,b,c\in \mathbb{Z} \}
\end{align*}
$$

<p>
where we can fix $c = 1$ for convenience, WLOG:
</p>

$$
\mathcal{L} = \{ (a', b', a' \cos(x) + b' \sin(x) - \mathop{\mathrm{enc}}) \mid a',b' \in \mathbb{Z} \}
$$

<p>
which makes it clearer that this lattice is basically the space that contains the space of our desired solution. In particular, if this space contains the vector(s) such that the third coordinate is zero, then it is indeed our solution! 
</p>

<p>
To see whether that is indeed the case, we can see if this space $\mathcal{L}$ can be represented as a vector space spanned by the basis $\{ v_1', v_2', v_3' \}$ such that one of them $v_i'$ has the third coordinate zero: $v_i' = (a', b', 0)$. This can be found using the <a href="https://en.wikipedia.org/wiki/Lenstra%E2%80%93Lenstra%E2%80%93Lov%C3%A1sz_lattice_basis_reduction_algorithm">LLL algorithm</a> when certain conditions are met (we will not discuss them here, but in high level, think of it as: $a'$ and $b'$ should be small). 
</p>

<p>
As a proof-of-concept, let us take an example: consider a diophantine equation $12x+5y = 22$. Let $(x',y')$ be one of its solutions. Using the same analogy as above, we can think of the solution space as a vector spanned by two canonical basis vectors $u_x = (1,0)$ and $u_y = (0,1)$ under the restriction that the sum of elements of $12x' u_x + 5 y' u_y = (12x', 5y')$ is 22, in other words $12x' + 5y' - 22 = 0$. Hence, we can set up $\mathcal{L}$ and compute:
</p>

$$
\mathcal{B} = 
\begin{bmatrix}
1 & 0 & 12 \\
0 & 1 & 5 \\
0 & 0 & -22
\end{bmatrix}
\implies
\mathsf{LLL}(\mathcal{B})
=
\begin{bmatrix}
1 & 2 & 0 \\
2 & 0 & 2 \\
-2 & 1 & 3
\end{bmatrix}
$$

```python
B = Matrix(QQ,
    [
        [1,0,12],
        [0,1,5],
        [0,0,-22]
    ]
)
B.LLL()
# [ 1  2  0]
# [ 2  0  2]
# [-2  1  3]
```

<p>
The row vector with the third element being $0$ gives a solution $(x',y')=(1,2)$ to $12x+5y = 22$ as desired.
</p>

<p>
Let us divert back to the main topic. We can apply the same lines of reasonings for this challenge. However there is a small caveat: the third coordinate is unlikely to be zero in this particular challenge due to the errors introduced by floating-point arithmetic. But we are given that the length of the flag is 38, making $a$ and $b$ less than around $256^{38/2} = 2^{152}$, which is considerably smaller than $2^{1000}$. So, there is a good chance that LLL can still solve this problem, we just need to hope that the error is going to be small enough (e.g. less than $\mathrm{enc}$).
</p>

```python
## trendy-solve.sage
from Crypto.Util.number import bytes_to_long, long_to_bytes

R = RealField(1000)
x   = R((see chall.sage))
enc = (see chall.sage)
bits = 1000

B = Matrix(QQ,
    [
        [1,0,cos(x)],
        [0,1,sin(x)],
        [0,0,-enc]
    ]
)
B[:, 2] = B[:, 2] * 2^bits
B_lll = B.LLL()

print("2^152 =", 2^152)
## 2^152 = 5708990770823839524233143877797980545530986496
print("enc =", int(enc))
## enc = 2783326522220000911479336891554147920203385276

B_lll_int = Matrix(QQ, 3, 3, lambda i, j: int(B_lll[i][j]))
B_lll_int
## [
## 1501403158973585406817603354497647816859742771
## 2461834501240441634675537458806974655348946301
## 2610765679588872452147618269600665976169800905]
## (remaining entries are redacted due to excessive length)
```

<p>
This is good news -- we have a vector (which in fact is the first vector) that seems promisingly short (entries smaller than both $\mathrm{enc}$ and $2^{152}$. This might be the vector that contains our solution $(a', b', (\mathsf{error}))$! And as you might have guessed, it turns out the answer is <b>yes</b> :-)
</p>

```python
## trendy-solve.sage continued
...
for j in range(0,3):
    print(long_to_bytes(int(abs(B_lll[0][j]))))
# b'CSCTF{Trigo_453_Tr3'
# b'ndy_FuN_Th35e_D4Y5}'
# b'u\x12\x1e\xc4\xe9\xde\xbf\xcaF\x83\xd1\x17y\xf9\xc7?\x97\xa4\xc9'
```

<p></p>

**Flag**: <code>CSCTF{Trigo_453_Tr3ndy_FuN_Th35e_D4Y5}</code>

<font size="4">
<p>The full solve script is provided below for your viewing pleasure:</p>
<details>
<summary><code>trendy-sol.sage</code> (Click to expand)</summary>
{% highlight python %}
## trendy-sol.sage
from Crypto.Util.number import bytes_to_long, long_to_bytes

R = RealField(1000)
x   = R(0.75872961153339387563860550178464795474547887323678173252494265684893323654606628651427151866818730100357590296863274236719073684620030717141521941211167282170567424114270941542016135979438271439047194028943997508126389603529160316379547558098144713802870753946485296790294770557302303874143106908193100)
enc = 2.78332652222000091147933689155414792020338527644698903976732528036823470890155538913578083110732846416012108159157421703264608723649277363079905992717518852564589901390988865009495918051490722972227485851595410047572144567706501150041757189923387228097603575500648300998275877439215112961273516978501e45

bits = 1000

B = Matrix(QQ,
    [
        [1,0,cos(x)],
        [0,1,sin(x)],
        [0,0,-enc]
    ]
)
B[:, 2] = B[:, 2] * 2^bits

B_lll = B.LLL()

# print("2^152 =", 2^152)
# print("enc =", int(enc))
# B_lll_int = Matrix(QQ, 3, 3, lambda i, j: int(B_lll[i][j]))
# print(B_lll_int)

# for j in range(0,3):
#     print(long_to_bytes(int(abs(B_lll[0][j]))))

print(long_to_bytes(int(abs(B_lll[0][0]))) + long_to_bytes(int(abs(B_lll[0][1]))))
## b'CSCTF{Trigo_453_Tr3ndy_FuN_Th35e_D4Y5}'
{% endhighlight %}
</details>
<p></p>
</font>

<font size="4">
<p>
This writeup was meant to deliver my thought processes and intuitions rather than comprehensive introductions and rigorous theories. There are many resources on lattice-based cryptanalysis attacks out there. I personally recommend these:
</p>
</font>

<font size="4">
<oi>
<li>Alfred Menezes, Paul van Oorschot, Scott Vanstone: <a href="https://cacr.uwaterloo.ca/hac/">Handbook of Applied Cryptography</a> (see Chapter 3).</li>
<li>Abderrahmane Nitaj: Slides for <a href="https://nitaj.users.lmno.cnrs.fr/LatticeMalaysia2014.pdf">Lattice based cryptography</a> and <a href="https://nitaj.users.lmno.cnrs.fr/LatticeMalaysia2014-2.pdf">Applications of Lattice Reduction in Cryptography</a>.</li>
<li>Joey Geralnik: Writeup for <a href="https://jgeralnik.github.io/writeups/2021/08/12/Lattices/">Snore (RaRCTF 2021)</a>.</li>
<li>Jennifer Bakker: <a href="https://mathweb.ucsd.edu/~crypto/Projects/JenniferBakker/Math187/">The Knapsack Problem And The LLL Algorithm</a>.</li>
<li>Chris Peikert: Lecture notes on <a href="https://web.eecs.umich.edu/%7Ecpeikert/lic13/lec05.pdf">Cryptanalysis of Knapsack Cryptography</a>.</li>
<li>Joseph Surin, Shaanan Cohney: <a href="https://eprint.iacr.org/2023/032">A Gentle Tutorial for Lattice-Based Cryptanalysis</a>.</li>
<li>Gabrielle De Micheli, Nadia Heninger: <a href="https://eprint.iacr.org/2020/1506">Recovering cryptographic keys from partial information, by example</a></li>
<li><a href="https://www.youtube.com/playlist?list=PLgKuh-lKre10rqiTYqJi6P4UlBRMQtPn0">Lattices: Algorithms, Complexity, and Cryptography Boot Camp</a> that took place in Simons Institute.</li>
</oi>

</font>
