---
title: "b01lersCTF 2022: Hardcore (predicate)"
date: 2025-01-26
description: b01lersCTF 2022 Hardcore Predicate
tags: ['CTF']
mathjax: yes
toc: yes
last_modified_at: 2025-01-27
header:
    teaser: "https://s1.ax1x.com/2022/07/23/jXsiEF.png"
    # overlay_image: "/image/etc/b01lersctf2022hardcore.png"
    # overlay_color: "#333"
    # overlay_filter: rgba(205, 239, 154, 0.30)
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
<b>Q</b>. <i>Why am I making a writeup for a chal that was from three years ago?</i>
</p>

<p>
Annually, <a href="https://b01lers.com/">b01lers</a> runs their own <a href="https://internal.b01lersc.tf/">internal CTF</a> for Purdue students who wants to practice their CTF skills. We meet every Friday and play live CTF together, but an asynchronous CTF that lasts for a year where enthusiasts can try out real CTF problems from previous b01lersCTFs without having to worry about the time limit and "spoiling" the answers (or getting spoiled) is certainly desirable. 
</p>

<p>I found this challenge while roaming around the internal CTF site sometime last year. At first, the challenge looked very easy, and the first part of it was indeed a piece of cake. The second part, however, was the actual roadblock. I had what-I-thought-was a perfectly working solution for almost five hours, wrongfully convinced that either something was wrong with Python or the challenge itself, until I figured it out using a result in my research area. </p>

<p>I always wanted to write a writeup about this challenge. I procrastinated until I forgot about it, and until the said famous result was mentioned in one of the classes I am auditing this semester.</p>

<p>Without further ado, let's get started!</p>

</font>

<!-- <font size="5"><b>crypto/Hardcore</b></font> -->
<font size="5"><b>crypto/Hardcore</b></font>

<font size="4">
<p>Author: <a href="https://github.com/mtanghu">mtanghu</a></p>
</font>

<center>
<img src="/images/etc/b01lersctf2022hardcore.png"  width="70%" height="70%">
<p></p>
</center>

```python
"""Hardcore.py"""
import numpy as np
from os import urandom
import binascii
import hashlib
from secret import FLAG1, FLAG2

# Helpers

def digest_to_array(digest):
    hex_digest = binascii.hexlify(digest)
    binary = bin(int(hex_digest, base=16)).lstrip('0b')
    binary = np.array(list(binary))
    
    # currently leading 0s are gone, add them back
    missing_zeros = np.zeros(256 - len(binary))
    binary = np.concatenate((missing_zeros, binary.astype(int)))
    
    return binary.astype(int)

def bitstring_to_bytes(s):
    return int(s, 2).to_bytes((len(s) + 7) // 8, byteorder='big')

####################################################################################

def generate_hardcore(secret, r):
    return int(np.sum(secret * r) % 2)

def predictor(r, probability = 1):
    x_r = (r.copy() != digest_to_array(FLAG))
    np.random.seed(x_r)
    chance = np.random.rand()
    
    prediction = 0
    if chance <= probability:
        prediction = generate_hardcore(digest_to_array(FLAG), r)
    else:
        prediction = 1 - generate_hardcore(digest_to_array(FLAG), r)
        
    return int(prediction)

def parse_input():
    bitstring = input()
    assert len(bitstring) == 256
    assert set(bitstring) <= set(["0", "1"])
    
    bitstring = bitstring_to_bytes(bitstring)
    array = digest_to_array(bitstring) % 2
    return array

def Level(probability):
    hasher = hashlib.sha256()
    hasher.update(FLAG)
    encrypted_secret = hasher.hexdigest()
    problem_statement = \
        f"We're looking to find the secret behind this SHA1 hash <{str(encrypted_secret)}>. " \
         "Luckily for you, this socket takes a bitstring and predicts the dot product " \
        f"of the secret with that bit string (mod 2) with {int(100 * probability)}% accuracy and sends you back the answer.\n"

    print(problem_statement)
    while True:
        array = parse_input()
        if array is None:
            return
        print(predictor(array, probability = probability))
    
def main():
    global FLAG
    diff = int(input("Select a difficulty (1/2):"))
    if diff == 1:
        FLAG = FLAG1
        Level(1)
    if diff == 2:
        FLAG = FLAG2
        Level(0.9)

if __name__ == "__main__":
    main()
```

## Part 1

<font size="4">
<p>There are a lot of things happening in the code, but fear not, let's read the "problem statement" carefully for the first part.</p>

{% highlight text %}
We're looking to find the secret behind this SHA1 hash <(hash)>. 
Luckily for you, this socket takes a bitstring and predicts 
the dot product of the secret with that bit string (mod 2) 
with 100% accuracy and sends you back the answer.
{% endhighlight %}

<p>
Let $f$ be a one-way function, which in this problem it is SHA1. You are given $f(x)$ for some secret bitstring $x$, which appears to be 256-bit long based on the code. When the user sends in a bitstring $r$, it takes a bit-wise inner product $\left<r,x\right>$ and returns it to the user. Based on $\left<r,x\right>$, we have to recover $x$ correctly. 
</p>

<p>
This is a pretty typical problem in security that appears in many research fields like MPC and differential privacy. If, for example, $x$'s least significant bit is $x_n = 1$, then by feeding $r = 0\dots 00$ and $r = 0\dots 01$:
</p>
\[
\begin{align}
\left< r,x \right> & = \left< 0\dots 00, \; x_1\dots x_{n-1} 1 \right> = 0 \\
\left< r,x \right> & = \left< 0\dots 01, \; x_1\dots x_{n-1} 1 \right> = 1
\end{align}
\]
<p>
we can retrieve the last bit $x_n = 1$; if $x_n = 0$ then they'd be both zeros. 
</p>
<p>
We can make this more communication-efficient. Notice that, if $r = 1\dots 11$,
</p>
\[
\left< r,x \right> = \left< 1\dots 11, \; x_1 \dots x_{n-1} x_n \right> = \sum_{i=1}^n x_i
\]
<p>
Say we flipped the $k$-th bit of $r$ from $1$ to $0$ (denoted $r_{\neg k}$). Then,
</p>
\[
\left< r_{\neg k},x \right> = \left< 1\dots 0 \dots 1, \; x_1\dots x_k \dots x_n \right> = \left( \sum_{i=1}^n x_i \right) - x_k
\]

<p>
That is, we can determine $x_k$ by comparing $\left< r,x \right>$ and $\left< r,x_{\neg k} \right>$. If they are the same, then $x_k = 0$; otherwise, $x_k=1$. 
</p>

{% highlight python %}
"""hardcore_sol.py"""
import numpy as np
from pwn import *
import hashlib
from Crypto.Util.number import long_to_bytes, bytes_to_long

def bitstring_to_bytes(s):
    return int(s, 2).to_bytes((len(s) + 7) // 8, byteorder='big')

nc_str = "nc internal.b01lers.com 9003"
_ , host, port = nc_str.split(" ")
nc_ed = remote(host, int(port))
nc_ed.recvuntil("(1/2):")
nc_ed.sendline("1")
nc_ed.recvuntil(" ")

payload = "1" * 256
flag_binary = [""] * 256

nc_ed.sendline(payload)
some_random_string = nc_ed.recv() # Just read until the answer
inner_prod_with_1 = nc_ed.recv() # b'1\n'
inner_prod_with_1 = str(inner_prod_with_1.decode("utf-8"))[0] # integer 1

for i in range(0,256):
    # This also works, in fact gives you less warning msgs.
    # if i == 0:
    #   payload = b'1' * (256-i-1) + b'0'
    # elif i != 0:
    #   payload = b'1' * (256-i-1) + b'0' + b'1' * i
    if i == 0:
        payload = "1" * (256-i-1) + "0"
    elif i != 0:
        payload = "1" * (256-i-1) + "0" + "1" * i

    nc_ed.sendline(payload)
    new_inner_prod = nc_ed.recv()
    new_inner_prod = str(new_inner_prod.decode("utf-8"))[0]
    if new_inner_prod != inner_prod_with_1:
        flag_binary[255 - i] = 1
    else:
        flag_binary[255 - i] = 0

flag_binary = ''.join([str(_ ) for _ in flag_binary])
flag_binary = int(flag_binary, 2)
print(long_to_bytes(flag_binary))
"""bctf{do_you_like_hardcore_chals}""" 
{% endhighlight %}
</font>

  <p></p>

**Flag1**: <code>bctf{do_you_like_hardcore_chals}</code>


## Part 2

<font size="4">
<p>Things are now a little tricky. </p>

{% highlight text %}
We're looking to find the secret behind this SHA1 hash <(hash)>. 
Luckily for you, this socket takes a bitstring and predicts 
the dot product of the secret with that bit string (mod 2) 
with 90% accuracy and sends you back the answer.
{% endhighlight %}

<p>Note that the 100% accuracy part has been changed to 90%. </p>
</font>

### Attempt 1

<font size="4">
<p>
One may naively think (like I did) that, since the accuracy is 90%, we can just send the same bitstring $x$ multiple times and take the majority; basically, we repeat Part 1 multiple times.
</p>

{% highlight python %}
"""hardcore_sol.py"""
import numpy as np
from pwn import *
import hashlib
from Crypto.Util.number import long_to_bytes, bytes_to_long

def bitstring_to_bytes(s):
    return int(s, 2).to_bytes((len(s) + 7) // 8, byteorder='big')

nc_str = "nc internal.b01lers.com 9003"
_ , host, port = nc_str.split(" ")
nc_ed = remote(host, int(port))
nc_ed.recvuntil("(1/2):")
nc_ed.sendline("2")
nc_ed.recvuntil(" ")

payload = "1" * 256
flag_binary = [""] * 256

nc_ed.sendline(payload)
some_random_string = nc_ed.recv() # Just read until the answer
inner_prod_with_1 = nc_ed.recv() # b'1\n'
inner_prod_with_1 = str(inner_prod_with_1.decode("utf-8"))[0] # integer 1

for i in range(0,256):
    if i == 0:
        payload = "0" * (256-i-1) + "1"
    elif i != 0:
        payload = "0" * (256-i-1) + "1" + "0" * i
    count = 0
    trial = 30

    for _ in range(0, trial):
        nc_ed.sendline(payload)
        new_inner_prod = nc_ed.recv()
        new_inner_prod = str(new_inner_prod.decode("utf-8"))[0]
        count += int(new_inner_prod)

    new_inner_prod = 1 if count / trial >= 0.5 else 0
    flag_binary[255 - i] = new_inner_prod

flag_binary = ''.join([str(_ ) for _ in flag_binary])
flag_binary = int(flag_binary, 2)
print(long_to_bytes(flag_binary))
{% endhighlight %}

<p>
But then you'd realize that this solution does not work at all. Why?!?
</p>
</font>

### Attempt 2 (Flag!)

<font size="4">
<p>
Upon inspecting the local variables in the code above, one should be able to realize that the outputs are deterministic as long as the input payload is fixed, the 'randomness' only comes from the input (and here, the input is the flag!). For example, <code>count</code> is always 0 or equal to <code>trial</code>. This is due to how random variable <code>chance</code> is computed in the <code>predictor</code>.
</p>

{% highlight python %}
"""from Hardcore.py"""
def predictor(r, probability = 1):
    x_r = (r.copy() != digest_to_array(FLAG))
    np.random.seed(x_r)
    chance = np.random.rand()    
    prediction = 0
    if chance <= probability:
        prediction = generate_hardcore(digest_to_array(FLAG), r)
    else:
        prediction = 1 - generate_hardcore(digest_to_array(FLAG), r)
    return int(prediction)
{% endhighlight %}

<p>
Note that <code>FLAG</code> is indeed fixed, so <code>x_r</code> is fixed as long as <code>r</code> is fixed, hence the randomness from the input only, and we cannot solve this problem by just replicating the solution from Part 1. Here, <code>x_r</code> is an array of boolean variables that we cannot predict as we do not know <code>FLAG</code>.
</p>

<p>
Since the randomness is, roughly speaking, based on the randomness of the inputs, the most natural thing is to randomize the input by XORing with random strings (because it is basically the one-time pad). For some people, this may seem like something that came out of the blue or rather ad-hoc at best, but it actually has a deep theoretical implication called <a href="https://en.wikipedia.org/wiki/Hard-core_predicate">Goldreich-Levin hardcore predicate</a>, which I will outline briefly below (but please feel free to skip). 
</p>

<p>
Security definition of one-way functions requires that it should be very difficult for any (polynomial time) adversary to invert $f(x)$ and recover $x$. Note that the function that returns $0$ for all input ($f(x) \equiv 0$) is not a one-way function because we can trivially find $x$ that returns $f(x)$ (by just picking any element $x$ from the domain, yawn). In a similar spirit, one can realize that $f(x)$'s security only guarantees that it 'hides' $x$ itself, may not guarantee that it hides everything about $x$ (for example, a bit of $x$).  
</p>

<p>
But given that $f$ is still a one-way function, there must exist a bit (or some bits) of $x$ that is hard to compute/guess just based on $f(x)$. More generally, there must be a (boolean) function $g(x)$ (that may reveal some information about $x$) that is hard to compute when you are just given $f(x)$. This is called <b>hardcore predicate</b>. It is known that, given a one-way function $f(x)$ and some (random) variable $r$, it is difficult to compute $g_r(x) = \left< r, x\right>$ without $x$, and this $g(x)$ is called <a href="https://en.wikipedia.org/wiki/Hard-core_predicate">Goldreich-Levin hardcore predicate</a>.  
</p>

<p>
In short, a hardcore predicate is a secret bit that is hard to compute. But, thinking ahead, this also means that, if there is an algorithm that predicts them efficiently, we may be able to use it to recover the secret $x$ efficiently. The server is running <code>Hardcore.py</code> which, upon input $r$, returns $b$ such that $b = \left<r,x\right>$ with probability $0.9$. So, our server is the oracle that predicts Goldreich-Levin hardcore predicate efficiently! And the algorithm that predicts $x$ based on $\left<r,x\right>$'s indeed exists already (by Goldreich and Levin, obviously, and hence the name). As you would've guessed, the key is to feed ($e \oplus r$)'s where $e$'s are random strings, not just $r$'s! <a href="https://www3.cs.stonybrook.edu/~omkant/S06.pdf">This</a> and <a href="https://www3.cs.stonybrook.edu/~omkant/S05.pdf">this</a> lecture notes by <a href="https://www3.cs.stonybrook.edu/~omkant/">Prof. Omkant Pandey</a> at Stony Brook outlines the algorithm and proof very nicely.
</p>
</font>

<font size="3">
  <p>(Warning: In the code below, I messed up the notations and denoted $e$ as payload strings and $r$ as random strings. My apologies)</p>
</font>

<font size="4">
{% highlight python %}
"""more_hardcore_sol.py"""
import numpy as np
from pwn import *
import hashlib
from Crypto.Util.number import long_to_bytes, bytes_to_long

import random
import math
 
#### Taken from 
# https://www.geeksforgeeks.org/python-program-to-generate-random-binary-string/
def generate_binary_string(n):
    # Generate a random number with n bits
    number = random.getrandbits(n)
    # Convert the number to binary
    binary_string = format(number, '0b')
    return binary_string
####

nc_str = "nc internal.b01lers.com 9003"
_ , host, port = nc_str.split(" ")
nc_ed = remote(host, int(port))

nc_ed.recvuntil("(1/2):")
nc_ed.sendline("2")
nc_ed.recvuntil(" ")

payload = "0" * 256
flag_binary = [""] * 256

nc_ed.sendline(payload)
some_random_string = nc_ed.recv() # Just read until the answer
print(some_random_string)
inner_prod_with_1 = nc_ed.recv() # b'0\n'
print(inner_prod_with_1)
inner_prod_with_1 = str(inner_prod_with_1.decode("utf-8"))[0] # integer 0
print(inner_prod_with_1)

for i in range(0,256):

    if i == 0:
        payload = "0" * (256-i-1) + "1"
    elif i != 0:
        payload = "0" * (256-i-1) + "1" + "0" * i
    count = 0
    trial = int(math.sqrt(256)) - 1

    for _ in range(0, trial):
        e_i = payload # string
        r_i = generate_binary_string(256) # string
        XOR_ei_ri = bin(int(e_i, 2) ^ int(r_i, 2))
        str_XOR_ei_ri = str(XOR_ei_ri)
        list_str_xor = list(str_XOR_ei_ri)
        list_str_xor = list_str_xor[2:]
        str_XOR_ei_ri = ''.join([str(_) for _ in list_str_xor])
        if len(str_XOR_ei_ri) != 256:
            list_str_xor = list(str_XOR_ei_ri)
            missing_zeros = ['0'] * (256 - len(str_XOR_ei_ri))
            list_str_xor = missing_zeros + list_str_xor
            str_XOR_ei_ri = ''.join([str(_) for _ in list_str_xor])
            assert len(str_XOR_ei_ri) == 256
        
        if len(r_i) != 256:
            list_str_ri = list(r_i)
            missing_zeros = ['0'] * (256 - len(r_i))
            list_str_ri = missing_zeros + list_str_ri
            r_i = ''.join([str(_) for _ in list_str_ri])
            assert len(r_i) == 256

        nc_ed.sendline(r_i)
        new_inner_prod_1 = nc_ed.recv()
        new_inner_prod_1 = str(new_inner_prod_1.decode("utf-8"))[0]
        
        nc_ed.sendline(str_XOR_ei_ri)
        new_inner_prod_2 = nc_ed.recv()
        new_inner_prod_2 = str(new_inner_prod_2.decode("utf-8"))[0]
        count += int(new_inner_prod_1) ^ int(new_inner_prod_2)

    new_inner_prod = 1 if count / trial >= 0.5 else 0
    flag_binary[255 - i] = new_inner_prod

flag_binary = ''.join([str(_ ) for _ in flag_binary])
flag_binary = int(flag_binary, 2)
print(long_to_bytes(flag_binary))

"""bctf{goldreich-levin-theorem.:D}"""
{% endhighlight %}
</font>


<p></p>

**Flag2**: <code>bctf{goldreich-levin-theorem.:D}</code>