---
title: "LACTF 2026: spreading-secrets"
modified: 2026-06-28
date: 2026-03-03
description: LACTF 2026 spreading-secrets Writeup
tags: ['CTF']
mathjax: yes
# toc: yes
# toc_sticky: yes
share: false
header:
    teaser: "https://lac.tf/images/mountains-logo.gif"
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
<p> 
This was an interesting chall, shame I only just managed to revisit and type up the full writeup.  
</p>
</font>

```python
## chall.py (abridged version)

from Crypto.Util.number import getPrime, bytes_to_long

FLAG = open("flag.txt", "rb").read()
SECRET = bytes_to_long(FLAG)

p = getPrime(512)


class RNG:
    def __init__(self, seed, modulus):
        self.state = seed
        self.a = ...
        self.b = ...
        self.c = ...
        self.d = ...
        self.modulus = modulus

    def next(self):
        self.state = (
            self.a * self.state**3
            + self.b * self.state**2
            + self.c * self.state
            + self.d
        ) % self.modulus
        return self.state


def create_shares(secret, threshold, num_shares, p):
    rng = RNG(secret, p)
    coefficients = [secret]
    for i in range(threshold - 1):
        coefficients.append(rng.next())

    shares = []
    for x in range(1, num_shares + 1):
        y = 0
        for power, coeff in enumerate(coefficients):
            term = (coeff * pow(x, power, p)) % p
            y = (y + term) % p
        shares.append((x, y))

    return shares


THRESHOLD = 10
NUM_SHARES = 15

shares = create_shares(SECRET, THRESHOLD, NUM_SHARES, p)

print(f"p={p}") # p=...
print(f"Share_1={shares[0]}") # Share_1=(1, ...)
```

<details>
<summary>Full <code>chall.py</code> with parameters (Click to expand)</summary>
{% highlight python %}
## chall.py

from Crypto.Util.number import getPrime, bytes_to_long

FLAG = open("flag.txt", "rb").read()
SECRET = bytes_to_long(FLAG)

p = getPrime(512)


class RNG:
    def __init__(self, seed, modulus):
        self.state = seed
        self.a = 4378187236568178488156374902954033554168817612809876836185687985356955098509507459200406211027348332345207938363733672019865513005277165462577884966531159
        self.b = 5998166089683146776473147900393246465728273146407202321254637450343601143170006002385750343013383427197663710513197549189847700541599566914287390375415919
        self.c = 4686793799228153029935979752698557491405526130735717565192889910432631294797555886472384740255952748527852713105925980690986384345817550367242929172758571
        self.d = 4434206240071905077800829033789797199713643458206586525895301388157719638163994101476076768832337473337639479654350629169805328840025579672685071683035027
        self.modulus = modulus

    def next(self):
        self.state = (
            self.a * self.state**3
            + self.b * self.state**2
            + self.c * self.state
            + self.d
        ) % self.modulus
        return self.state


def create_shares(secret, threshold, num_shares, p):
    rng = RNG(secret, p)
    coefficients = [secret]
    for i in range(threshold - 1):
        coefficients.append(rng.next())

    shares = []
    for x in range(1, num_shares + 1):
        y = 0
        for power, coeff in enumerate(coefficients):
            term = (coeff * pow(x, power, p)) % p
            y = (y + term) % p
        shares.append((x, y))

    return shares


THRESHOLD = 10
NUM_SHARES = 15

shares = create_shares(SECRET, THRESHOLD, NUM_SHARES, p)

print(f"p={p}")
# p=12670098302188507742440574100120556372985016944156009521523684257469947870807586552014769435979834701674318132454810503226645543995288281801918123674138911
print(f"Share_1={shares[0]}")
# Share_1=(1, 6435837956013280115905597517488571345655611296436677708042037032302040770233786701092776352064370211838708484430835996068916818951183247574887417224511655)
{% endhighlight %}
</details>

<!--
<details>
<summary>Parameters (Click to expand)</summary>
{% highlight python %}
print(f"p={p}")
# p=12670098302188507742440574100120556372985016944156009521523684257469947870807586552014769435979834701674318132454810503226645543995288281801918123674138911
print(f"Share_1={shares[0]}")
# Share_1=(1, 6435837956013280115905597517488571345655611296436677708042037032302040770233786701092776352064370211838708484430835996068916818951183247574887417224511655)
{% endhighlight %}
</details>
-->

<font size="4">
<p></p>

<p>
We are dealing with a random number generator (RNG) that takes seed $s$ as an input and outputs $f(s)$ where $f(x) := ax^3 + bx^2 + cx + d \;\; \text{mod } p$. 
In <code>create_shares</code>,
</p>
</font>

```python
# From chall.py

def create_shares(secret, threshold, num_shares, p):
    rng = RNG(secret, p)
    coefficients = [secret]
    for i in range(threshold - 1):
        coefficients.append(rng.next())
```

<font size="4">
<p>
we see that the list <code>coefficients</code> is just the secret (seed) RNG-ed over and over:
$$
\texttt{coefficients} = [s, f(s), f(f(s)), \dots, f^{(9)}(s)]
$$
Now we are dealing with <code>shares</code>:
</p>
</font>

```python
def create_shares(secret, threshold, num_shares, p):
    ...

    shares = []
    for x in range(1, num_shares + 1):
        y = 0
        for power, coeff in enumerate(coefficients):
            term = (coeff * pow(x, power, p)) % p
            y = (y + term) % p
        shares.append((x, y))
```

<font size="4">
<p>
from which we see that shares are basically the value of a degree-$9$ polynomial in $\mathbb{F}_p[X]$ with coefficients above, evaluated at $1,2,\dots,15$.
$$
\texttt{shares} = [(1,F_s(1)), (2,F_s(2)), \dots, (15, F_s(15))]
$$
where $F_s(x) = s + f(s) \; x + f(f(s)) \;x^2 \cdots + f^{(9)}(s)\; x^9 \;\;\text{mod } p$.
</p>

<p>
By the fundamental theorem of algebra, if we have $10$ or more shares, then we can reconstruct $F(x)$ and hence $s$ as well. That would make it a typical Shamir secret sharing scheme. However, we are only given the first share:
$$
\texttt{Share_1} = F_s(1) = s + f(s) + f(f(s)) + \cdots + f^{(9)}(s) \;\;\text{mod } p
$$
which is just the sum of all coefficients, and also essentially just a polynomial of $s$. 
</p>

<p>
Naively, one would find $s$ by solving the above equation $F_s(1) = \texttt{Share_1}$ for $s$ as follows, using <code>roots()</code> function in Sagemath:
</p>
</font>

```python
R = lambda x: (a*x^3 + b*x^2 + c*x + d) % p

var('s')

chain = s
x = s
for _ in range(9):    
    x = a*x^3 + b*x^2 + c*x + d
    chain += x

chain = chain - y1
sol = chain.roots()
print("SECRET =", sol)
print("FLAG =", long_to_bytes(int(sol[0])))
```
<font size="4">
<p>
but this is a baad idea because $F_s(1) - \texttt{Share_1}$ is a polynomial of degree $3^9 = 19683$ and the modulus $p$ is almost $512$-bit which are huge! 
</p>

<p>
So, here comes a trick: $P(s) := F_s(1) - \texttt{Share_1}$ for sure has a root, meaning that it can be factorized into some form of $(x-r)^d (\cdots)$ where $r$ is the said root and $d$ is its multiplicity. 
Hence, if we take a polynomial that has every element in $\mathbb{F}_p$ as a root,
$$
\prod_{t \in \mathbb{F}_p} (x-t) = x^p - x
$$
then, 
$(x-r) \;\left|\; \gcd\!\left( P(s), x^p - x \right) \right.$
because $x^p - x$ for sure will have $(x-r)$ in its factor. 
GCD should be fairly fast to compute thanks to Euclidean algorithm.
</p>

<p>
One additional trick (not critical, but still reduces the runtime a bit) is to define $x^p - 1$ as $x^p - 1 \;\;\text{mod } P(x)$ via <code>xp = pow(x, p, chain)</code>.
This is useful because $p$ is a $512$-bit prime, which makes $x^p - 1$ almost a degree-$2^{512}$ polynomial, but taking $\text{mod } P(x)$ reduces it down to degree $< 3^9 = 19683$. 
</p>
</font>

```python
Pr.<x> = GF(p)[]
chain = x
xi = x
for _ in range(9):
    xi = a * xi^3 + b * xi^2 + c * xi + d
    chain += xi
chain -= y1

xp = pow(x, p, chain)
g  = chain.gcd(xp - x)
# Doing x^p - x makes it very slow!
# print(g.roots(multiplicities=False))

for rt in g.roots(multiplicities=False):
    print(rt)
    try:
        print(long_to_bytes(int(rt)))
    except:
        continue

# b'lactf{d0nt_d3r1v3_th3_wh0l3_p0lyn0m14l_fr0m_th3_s3cr3t_t00!!!}'
```

**Flag**: `lactf{d0nt_d3r1v3_th3_wh0l3_p0lyn0m14l_fr0m_th3_s3cr3t_t00!!!}`

<font size="4">
<p>
See below for the full solve script.
</p>
</font>

<details>
<summary><code>sol.py (Click to expand)</code></summary>
{% highlight python %}
from Crypto.Util.number import long_to_bytes

p = 12670098302188507742440574100120556372985016944156009521523684257469947870807586552014769435979834701674318132454810503226645543995288281801918123674138911
y1 = 6435837956013280115905597517488571345655611296436677708042037032302040770233786701092776352064370211838708484430835996068916818951183247574887417224511655

a = 4378187236568178488156374902954033554168817612809876836185687985356955098509507459200406211027348332345207938363733672019865513005277165462577884966531159
b = 5998166089683146776473147900393246465728273146407202321254637450343601143170006002385750343013383427197663710513197549189847700541599566914287390375415919
c = 4686793799228153029935979752698557491405526130735717565192889910432631294797555886472384740255952748527852713105925980690986384345817550367242929172758571
d = 4434206240071905077800829033789797199713643458206586525895301388157719638163994101476076768832337473337639479654350629169805328840025579672685071683035027

Pr.<x> = GF(p)[]
chain = x
xi = x
for _ in range(9):
    xi = a * xi^3 + b * xi^2 + c * xi + d
    chain += xi
chain -= y1

xp = pow(x, p, chain)
g  = chain.gcd(xp - x)
# Doing x^p - x makes it very slow!
# print(g.roots(multiplicities=False))

for rt in g.roots(multiplicities=False):
    print(rt)
    try:
        print(long_to_bytes(int(rt)))
    except:
        continue

# 3074298428595709121955875023264800406092811708850679245815173037644479373939992249554695938687996524114338488973319108331132087534396070848444788138651857
# b':\xb2\xdb\x92&z\xbf\xf1\xfe\xa2\x8e\xecwUR\xe1\xe5\xb8\xea\x9cI\xadWR\xae\x17\x9f&\xd5\x0e\xe8^\xc3\x12\x13\xa4\xe4\x1dd\x07BF\xb2s\x0eS\xa7\x05\xee\xe6\xef\x81:\xe8\x13\\\x8b/\xf2\x95\xf3a0\xd1'
# 86614126311839201073392479341441261431500518590932674991838606941316470152703696752361142839039250579521708405076723034766286435603631894250232291709
# b'lactf{d0nt_d3r1v3_th3_wh0l3_p0lyn0m14l_fr0m_th3_s3cr3t_t00!!!}'
{% endhighlight %}
</details>

<p></p><p></p>