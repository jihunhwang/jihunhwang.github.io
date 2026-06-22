---
title: "BITSCTF 2025 Noob RSA Returns Writeup"
modified: 2026-06-22
date: 2025-03-17
description: BITSCTF 2025 Noob RSA Returns Writeup
tags: ['CTF']
mathjax: yes
# toc: yes
# toc_sticky: yes
share: false
header:
    teaser: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbZAR8drUWWTQHnLmve-HXCEYtdE2WMc5Nxg&s"
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
Sadly I did not get enough time to work on this chall until now, a month after the CTF ended. 
</p>
</font>

```python
## encrypt.py
from Crypto.Util.number import getPrime, bytes_to_long

def GenerateKeys(p, q):
    e = 65537
    n = p * q
    phi = (p-1)*(q-1)
    d = pow(e, -1, phi)
    C = 0xbaaaaaad
    D = 0xdeadbeef
    A= 0xbaadf00d
    K = (A*p**2 - C*p + D)*d
    return (e, n, K)

def Encrypt():
    flag = b"REDACTED" # HEHEHEHEHE
    p = getPrime(512)
    q = getPrime(512)
    e, n, K = GenerateKeys(p, q)
    pt = bytes_to_long(flag)
    ct = pow(pt, e, n)
    
    print(f"e = {e}")
    print(f"n = {n}")
    print(f"ct = {ct}")
    print(f"K = {K}")

Encrypt()
```

<details>
<summary>Parameters (Click to expand)</summary>
{% highlight python %}
e = 65537
n = 94391578028846794543970306963076155289398888845132329034244336898352288130614402434536624297683695128972774452047972797577299176726976054101512298009248486464357336027594075427866979990479026404794249095503495046303993475122649145761379383861274918580282133794104162177538259963029805672413580517485119968223
ct = 39104570513649572073989733086496155533723794051858605899505397827989625611665929344072330992965609070817627613891751881019486310635360263164859429539044097039969287153948226763672953863052936937079161030077852648023719781006057880499973169570114083902285555659303311508836688226455433255342509705736365222119
K = 20846957286553798859449981607534380028938425515469447720112802165918184044375264023823946177012518880630631981155207307372567493851397122661053548491580627249805353321445391571601385814438186661146844697737274273249806871709168307518276727937806212329164651501381607714573451433576078813716191884613278097774416977870414769368668977000867137595804897175325233583378535207450965916514442776136840826269286229146556626874736082105623962789881101475873449157946816513513532838149452759771630220014344325387486921028690085783785067988074331005737389865053848981113695310344572311901555735038842261745556925398852334383830822697851
{% endhighlight %}
</details>

<font size="4">
<p></p>

<p> 
Notice first that we have an interesting value $K$ as a hint.
$$
K = (Ap^2 - Cp + D)d
$$
Since $d = e^{-1} \text{ mod } \phi(n)$, there exists a constant $F$ such that $de = 1 + F\phi(n)$, and so
$$
\begin{align*}
Ke 
& = (Ap^2 - Cp + D)de = (Ap^2 - Cp + D)(F\phi(n) + 1)
\\
& = Ap^2 F \phi(n) +  Ap^2 - Cp F \phi(n) - Cp + DF \phi(n) + D
\end{align*}
$$ 
The first term $Ap^2 F \phi(n)$ significantly dominates the rest, and $\phi(n)$ is approximately $n$. So,
$$
Ke \sim A p^2 F n \implies p \approx \sqrt{\frac{Ke}{AFn}}
$$
Because the denominator (inside the square root) has $n$ in it, the error of this approximation is very small. 
Moreover, we have a very nice bound for $F$,
$$
\begin{align*}
F \phi(n) = de - 1 < de < \phi(n) e \implies F < e 
\end{align*}
$$
because surely $d < \phi(n)$ (because we are taking $\text{mod } \phi(n)$). 
So, we can brute force over $F$ and some errors, and that should be do-able.
</p>
</font>

```python
search_range = 10 # make it larger if needed

for F in range(1, e):
    p_center = math.isqrt( (K*e) // (A*F*n) )
    for p_cand in range(p_center - search_range, p_center + search_range):
        if gcd(n, p_cand) > 1:
            print(F) # 42677
            print(p_cand - p_center) # 2
            print(p_cand) # 10406...
            p = p_cand
            break
```
Then we are done!
```python
q = n // p
phi = (p-1) * (q-1)
d = pow(e, -1, phi)
m = pow(ct, d, n)
print(long_to_bytes(m))
# b'BITSCTF{I_H0P3_Y0UR3_H4V1NG_FUN_S0_F4R_EHEHEHEHEHO_93A5B675}'
```

**Flag**: `BITSCTF{I_H0P3_Y0UR3_H4V1NG_FUN_S0_F4R_EHEHEHEHEHO_93A5B675}`

<font size="4">
<p>
See below for the full solve script.
</p>
</font>

<details>
<summary><code>sol.py (Click to expand)</code></summary>
{% highlight python %}
import math
from Crypto.Util.number import long_to_bytes

e = 65537
n = 94391578028846794543970306963076155289398888845132329034244336898352288130614402434536624297683695128972774452047972797577299176726976054101512298009248486464357336027594075427866979990479026404794249095503495046303993475122649145761379383861274918580282133794104162177538259963029805672413580517485119968223
ct = 39104570513649572073989733086496155533723794051858605899505397827989625611665929344072330992965609070817627613891751881019486310635360263164859429539044097039969287153948226763672953863052936937079161030077852648023719781006057880499973169570114083902285555659303311508836688226455433255342509705736365222119
K = 20846957286553798859449981607534380028938425515469447720112802165918184044375264023823946177012518880630631981155207307372567493851397122661053548491580627249805353321445391571601385814438186661146844697737274273249806871709168307518276727937806212329164651501381607714573451433576078813716191884613278097774416977870414769368668977000867137595804897175325233583378535207450965916514442776136840826269286229146556626874736082105623962789881101475873449157946816513513532838149452759771630220014344325387486921028690085783785067988074331005737389865053848981113695310344572311901555735038842261745556925398852334383830822697851
A= 0xbaadf00d

search_range = 10 # make it larger if needed

for F in range(1, e):
    p_center = math.isqrt( (K * e) // (A * F * n) )
    for p_cand in range(p_center - search_range, p_center + search_range):
        if gcd(n, p_cand) > 1:
            print(F) # 42677
            print(p_cand - p_center) # 2
            print(p_cand) # 10406216443192169173533723167461845081683996237790486467542778667477564930803546070928131853072839096935544813786122096301171127932695303325352097678393621
            p = p_cand
            break

q = n // p
phi = (p-1) * (q-1)
d = pow(e, -1, phi)
m = pow(ct, d, n)
print(long_to_bytes(m)) # b'BITSCTF{I_H0P3_Y0UR3_H4V1NG_FUN_S0_F4R_EHEHEHEHEHO_93A5B675}'
{% endhighlight %}
</details>

<p></p><p></p>