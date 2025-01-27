---
title: "SpookyCTF 2023 Writeups"
date: 2023-10-30
description: SpookyCTF 2023 Writeups
tags: ['CTF']
toc: true
mathjax: yes
last_modified_at: 2023-12-30
---

<script type="text/javascript" src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>

<font size="4">

<p>A Halloween-themed CTF! I again participated as a part of <a href="https://b01lers.com/">b01lers</a>, but in particular I worked with A1y mostly. I also worked with VinhChilling and King Fish.</p>

<p>Here is the link to the CTF website: <a href="https://spooky.ctfd.io/">https://spooky.ctfd.io/</a>, and the link to the CTFTime event page: <a href="https://ctftime.org/event/2137/">https://ctftime.org/event/2137/</a>.</p>

</font>

### What have we found here... (Crypto)

<details>
<summary><font size="4">Problem prompt (Click to expand)</font></summary>
<blockquote><font size="3">
<p>As the sun dipped below the horizon, casting long shadows across the barren landscape, I stood alone at the edge of the world. The map had brought me here, to this remote and desolate place, in pursuit of a mystery that had captivated the world's greatest minds.</p>

<p>A cryptic message had been found on the ground, a message from the cosmos itself, or so it seemed. It hinted at the existence of extraterrestrial life, hidden within the depths of space. The message, a series of seemingly random characters, held secrets that could change everything we knew about the universe.</p>

<p>My task was to decipher it, to unlock its hidden meaning. The characters appeared to be encoded in a complex language, something that I cannot seem to figure out. The key to understanding lay within those symbols, like a cosmic puzzle waiting to be solved.</p>

<p>As I gazed up at the starry night sky, seeing the Leo Minor constellation in the sky, I knew that the fate of humanity rested on my ability to decode this enigmatic message, to uncover the truth hidden within the stars.</p>

<p><code><a href="https://spooky.ctfd.io/files/3acbaa7cd6d613e29cf9e18bab0d6249/found_notes.txt?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MTF9.ZZC8yw.0bTvsKXmomHb_hjiz4h2FOWgGU0">found_notes.txt</a></code></p>

</font></blockquote>
</details>

<p></p>

<font size="4">
<p>We are given a file <code><a href="https://spooky.ctfd.io/files/3acbaa7cd6d613e29cf9e18bab0d6249/found_notes.txt?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MTF9.ZZC8yw.0bTvsKXmomHb_hjiz4h2FOWgGU0">found_notes.txt</a></code>, whose first few lines looks like this:</p>
</font>
<center>
<img src="/image/spctf_2023/spctf_found_notes.png">
</center>
<font size="4">

<p></p>

<p>It looks like a base64-encoded string, which we can try base64-decoding it with Python.</p>

{% highlight python %}
import base64

with open('found_notes.txt', 'r') as f:
    lines = f.readlines()
# print(len(lines)) 
# Outputs 1, so only one line. So lines[0] should be everything
lines = base64.b64decode(lines[0])
print(lines)
{% endhighlight %}

<p>The output string surprisingly includes a word that everyone is familiar with:</p>
</font>
<center>
<img src="/image/spctf_2023/spctf_found_notes_jfif.png" width="70%" height="70%">
</center>

<font size="4">
<p>which strongly suggests that this is a JPG file.</p>

{% highlight python %}
with open("found_notes_sol.jpg", "wb") as f:
  f.write(lines)
f.close()
{% endhighlight %}

<details>
<summary><font size="4">Output file <code>found_notes_sol.jpg</code> (Click to expand)</font></summary>
<center>
<img src="/image/spctf_2023/found_notes_sol.jpg" width="70%" height="70%">
</center>
</details>
<p></p>

<p>and whence the <b>flag: <code>NICC{just_chillin}</code></b>. For the sake of completeness, here is the full solution script, for your reference:</p>

<details>
<summary><font size="4"><code>sol.py</code> (Click to expand)</font></summary>
{% highlight python %}
import base64

with open('found_notes.txt', 'r') as f:
    lines = f.readlines()
# print(len(lines)) 
# Outputs 1, so only one line. So lines[0] should be everything
lines = base64.b64decode(lines[0])
print(lines)
# The first line has jfif. So this must be a image file!

# with open("found_notes_sol_bytes.txt", "wb") as f:
#   f.write(lines)
# f.close()
with open("found_notes_sol.jpg", "wb") as f:
  f.write(lines)
f.close()
{% endhighlight %}
</details>
</font>

### If the key fits... (Crypto)

<blockquote><font size="3">
<p>I am trying to escape this 64-story horror house and the only way to escape is by finding the flag in this text file! Can you help me crack into the file and get the flag? The only hint I get is this random phrase: MWwwdjM1eW1tM3RyMWNrM3Q1ISEh</p>

<p><code><a href="https://spooky.ctfd.io/files/ef4a3a201da074874a6825fcf4af8bd7/flag.txt.aes?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MTh9.ZZC82A.FkL50igZpxPbutlgf15byivEcn8">flag.txt.aes</a></code></p>

<p><b>Developed by</b> <a href="https://github.com/theamazins17">theamazins17</a></p>

</font></blockquote>

<font size="4">
<p>As usual, we start by opening the given file: <code><a href="https://spooky.ctfd.io/files/ef4a3a201da074874a6825fcf4af8bd7/flag.txt.aes?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MTh9.ZZC82A.FkL50igZpxPbutlgf15byivEcn8">flag.txt.aes</a></code>.</p>

<center>
<img src="/image/spctf_2023/spctf_keyfits.png" width="70%" height="70%">
</center>
</font>

<font size="4">

<p></p>

<p>So this file was encrypted using AES (the file extension checks out already), in particular using the program called <code>aescrypt</code> (on Windows).</p>

<p>The problem prompt has also given <code>MWwwdjM1eW1tM3RyMWNrM3Q1ISEh</code> as a hint, and says <i>I am trying to escape this <b>64</b>-story horror house</i>. From this, one could guess that this random string is a base64 string,</p>

{% highlight python %}
import base64
random_string = "MWwwdjM1eW1tM3RyMWNrM3Q1ISEh"
base64.b64decode(random_string)

# > b'1l0v35ymm3tr1ck3t5!!!'
{% endhighlight %}

<p>and it seems like I was right. Lucky me. This looks like the encryption key, but it is 21 bytes which is not a valid key size for (textbook) AES. I migrated to my Windows machine, downloaded and installed <code>aescrypt</code>, and ran it with <code>flag.txt.aes</code> as input and <code>1l0v35ymm3tr1ck3t5!!!</code> as the key. Then I got this (<code>flag.txt</code>):</p> 

{% highlight text %}
Congrats on finding the flag!

NICC{1-4m-k3yn0ugh!}
{% endhighlight %}

<p><b>Flag: <code>NICC{1-4m-k3yn0ugh!}</code></b>.</p>

</font>

### strange monuments (Crypto)

<blockquote><font size="3">
<p>Indiana is searching for alien artifacts deep in the jungle. He's following a winding river, and in order to not get lost he has charted its flow with the equation y^2 = x^3 + 7586x + 9001 (mod 46181).</p>

<p>Every point on the river's flow represents the site where an alien monument has been reported. Indiana starts at the monument location denoted on his chart with the point (20305,32781).</p>

<p>He follows the flow of the river from that monument and passes many others. However, he loses count due to some snakes that he had to run from! Indiana is now at the monument marked with the point (39234,12275) on his chart.</p>

<p>How many monuments did Indiana pass in total?</p>

<p><b>Developed by</b> <a href="https://github.com/thatLoganGuy">Logan DesRochers</a></p>

</font></blockquote>

<font size="4">

<p>We are given an equation
\( y^2 = x^3 + 7586x + 9001 \; (\text{mod } 46181) \). This is an elliptic curve. It is easy to verify that both points \( P = (20305,32781) \) and \( Q = (39234,12275) \) are on this elliptic curve. Since Indiana is <i>following the flow</i> of the river, the question basically is asking you to solve the discrete logarithm problem on elliptic curves: what is \( k \in \mathbb{N} \) such that \( Q = kP \)?
</p>

<p>Normally, this problem is very computationally difficult, but given that the size of the field is pretty small, this might be doable. So, let's give it a shot using Sage.</p>

{% highlight python %}
p = 46181
E = EllipticCurve(GF(p), [7586,9001])
P = E(20305,32781)
Q = E(39234,12275)
n = P.discrete_log(Q)
print(n)
print(n-1)

# > 3000
# > 2999
{% endhighlight %}

<p>The reason for subtracing 1 is that since the question asked for number of monuments Indiana <i>passed</i>, hence we exclude the monument it started from. </p>

<p><b>Flag: <code>NICC{2999}</code></b></p>

</font>


### I Have Become Death (Forensics)

<blockquote><font size="3">
<p>Oh boy... Things are becoming hectic and it is stressing me out.</p>

<p>My computer seems to be haunted as it prevents me from starting up my computer.</p>

<p>Thankfully, after multiple resets - it stopped. I checked the logs and it is in these weird folders named after COD maps. Can you discover which file, with its extension, and the time, keep as is, it was executed?</p>

<p>Flag Format: NICC{nameOfFile.extension_00:00}</p>

<p><code><a href="https://spooky.ctfd.io/files/b04fad9d5fd3eecd46136ba0ee0ed5ab/nuketown.zip?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MjB9.ZZC6BQ.zyS9viIscCL31utvKAf8Xn8yeO0">nuketown.zip</a></code></p>

<p><b>Developed by</b> <a href="https://github.com/theamazins17">theamazins17</a></p>

</font>
</blockquote>

<font size="4">

<p>The zip file (<code><a href="https://spooky.ctfd.io/files/b04fad9d5fd3eecd46136ba0ee0ed5ab/nuketown.zip?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MjB9.ZZC6BQ.zyS9viIscCL31utvKAf8Xn8yeO0">nuketown.zip</a></code>) provided contains too many directories and folders to go over each of them---running <code>os.walk</code> on Python returned 207 files:</p>

{% highlight python %}
import os
folder_name = "./nuketown"
arr_dirs = []
for roots, dirs, files in os.walk(folder_name):
    arr_dirs += files
print(len(arr_dirs))

# > 207
{% endhighlight %}

<p>The directory <code>nuketown</code> largely contain four folders.</p>

</font>

<center>
<img src="/image/spctf_2023/spctf_nuketown.png" width="70%" height="70%">
</center>

<font size="4">

<p></p>

<p>I am very sure nobody would be gladly willing to check 207 files all manually unless they are trying to procrastinate or stay away from something desperately. Just as the challenge description suggests, my direction was to see if there are any log files. Checking in the first folder <code>nuk3town</code> briefly tells us that the machine was running Windows OS. The third and fourth folders (<code>nuketown_84</code> and <code>nuketown_island</code>) look nearly useless for this challenge upon checking in.</p>

<p>The second folder <code>nuketown2025</code> also looks useless at first sight; it looks more like a folder for background musics, but your opinion might change once you read the file names carefully </p>

{% highlight terminal %}
jimmy@jimmy-G5-5587:~/nuketown/nuketown$ cd nuketown2025/
jimmy@jimmy-G5-5587:~/nuketown/nuketown/nuketown2025$ ls
 GoogleUpdateTaskMachineCore{E5E2FCDB-3E56-45AD-867D-7906B493F794}.mp3
 GoogleUpdateTaskMachineUA{9C2D9BE6-3FD9-4CB9-95BF-0985A86DE5B2}.mp3
 MicrosoftEdgeUpdateTaskMachineCore.mp3
 MicrosoftEdgeUpdateTaskMachineUA.mp3
 MicrosoftUpdateTaskForkBomb.mp3
 npcapwatchdog.mp3
'OneDrive Reporting Task-S-1-5-21-873893488-3415847396-2192196956-1000.mp3'
'OneDrive Standalone Update Task-S-1-5-21-873893488-3415847396-2192196956-1000.mp3'
{% endhighlight %}


<p>Let's see if we can open up (<code>cat</code>) the first file <code>GoogleUpdateTaskMachineCore{E5E2FCDB-3E56-45AD-867D-7906B493F794}.mp3</code>: </p>

<details><summary>(Suppressed due to length - Click to expand)</summary>
{% highlight xml %}
jimmy@jimmy-G5-5587:~/nuketown/nuketown/nuketown2025$ cat GoogleUpdateTaskMachineCore{E5E2FCDB-3E56-45AD-867D-7906B493F794}.mp3
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Version>1.3.36.312</Version>
    <Description>Keeps your Google software up to date. If this task is disabled or stopped, your Google software will not be kept up to date, meaning security vulnerabilities that may arise cannot be fixed and features may not work. This task uninstalls itself when there is no Google software using it.</Description>
    <URI>\GoogleUpdateTaskMachineCore{E5E2FCDB-3E56-45AD-867D-7906B493F794}</URI>
  </RegistrationInfo>
  <Triggers>
    <LogonTrigger>
      <Enabled>true</Enabled>
    </LogonTrigger>
    <CalendarTrigger>
      <StartBoundary>2023-10-17T14:37:13</StartBoundary>
      <ScheduleByDay>
        <DaysInterval>1</DaysInterval>
      </ScheduleByDay>
    </CalendarTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>S-1-5-18</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>false</StopOnIdleEnd>
    </IdleSettings>
    <Enabled>true</Enabled>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>"C:\Program Files (x86)\Google\Update\GoogleUpdate.exe"</Command>
      <Arguments>/c</Arguments>
    </Exec>
  </Actions>
{% endhighlight %}
</details>

<p></p>

<p>This looks very much like a log file and all the other files in this folder look like this as well. We are (finally) on the right folder! But which one represents the error that made this computer haunted? Looking closely at the names of the files again, we see something very familiar: <a href="https://en.wikipedia.org/wiki/Fork_bomb">Fork bomb</a>. And this explains why the machine "<i>prevents me from starting up my computer</i>."</p>

<p>Anyway, let's then check <code>MicrosoftUpdateTaskForkBomb.mp3</code>:</p>

<details><summary>(Suppressed due to length - Click to expand)</summary>
{% highlight xml %}
jimmy@jimmy-G5-5587:~/nuketown/nuketown/nuketown2025$ cat MicrosoftUpdateTaskForkBomb.mp3 
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Date>2023-10-17T14:54:02.9013933</Date>
    <Author>CTF\John Smith</Author>
    <Description>Will run a fork bomb everyday</Description>
    <URI>\Possibly a Fork Bomb</URI>
  </RegistrationInfo>
  <Triggers>
    <CalendarTrigger>
      <StartBoundary>2023-10-17T14:55:00</StartBoundary>
      <Enabled>true</Enabled>
      <ScheduleByDay>
        <DaysInterval>1</DaysInterval>
      </ScheduleByDay>
    </CalendarTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <RunLevel>HighestAvailable</RunLevel>
      <UserId>John Smith</UserId>
      <LogonType>Password</LogonType>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>true</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>P3D</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>"C:\Users\John Smith\AppData\Local\Programs\Python\Python312\Scripts\bomb.py"</Command>
    </Exec>
  </Actions>
</Task>
{% endhighlight %}
</details>

<p></p>

<p>There are way too much information here, but we just need the name of the file (and its file extension) that was being executed and the time it was executed at. And they are all here:</p>

{% highlight xml %}
...
    <CalendarTrigger>
      <StartBoundary>2023-10-17T14:55:00</StartBoundary>
      <Enabled>true</Enabled>
...
  <Actions Context="Author">
    <Exec>
      <Command>"C:\Users\John Smith\AppData\Local\Programs\Python\Python312\Scripts\bomb.py"</Command>
    </Exec>
  </Actions>
...
{% endhighlight %}

<p>It was <code>bomb.py</code> that was executed at 14:55. Hence, <b>flag: <code>NICC{bomb.py_14:55}</code></b> as desired.</p>

<p>As the author of this chall kind of admitted in the Discord server, I think this challenge could be guessy for those who have never heard of fork bomb before (or never played COD before---there is no such thing called fork bomb in COD).</p>

</font>


### Down the Wormhole (Forensics)

<blockquote><font size="3">
<p>An explosive chase with a UFO led us to a wormhole!</p>

<p>Make sure you have your bases covered before you head in and find the secrets hiding inside!</p>

<p><a href="https://spooky.ctfd.io/files/6d539c02da776aedd9f92f315d81ef03/wormhole.jpg?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MjF9.ZZDQJA.JTepNHYHYORGnItyslgrs0O6O0Y"><code>wormhole.jpg</code></a></p>

<p><b>Developed by</b> <a href="https://github.com/dmarriello">Daniel M.</a></p>


</font>
</blockquote>


<font size="4">

<p>I started by opening <a href="https://spooky.ctfd.io/files/6d539c02da776aedd9f92f315d81ef03/wormhole.jpg?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MjF9.ZZDQJA.JTepNHYHYORGnItyslgrs0O6O0Y"><code>wormhole.jpg</code></a> with text editor. On the first line, there is a very-base64-looking message: <code>cGFzc3dvcmQ6IGRpZ2dpbmdkZWVwZXI=</code>, which is a base64-encoding of the string <code>password: diggingdeeper</code>. </p>

<p>Now we do the real stegano stuff. I uploaded the image and password on this online stegano tool: <a href="https://futureboy.us/stegano/decinput.html">https://futureboy.us/stegano/decinput.html</a>. Then I got this as an output:</p>

{% highlight plaintext %}
After diving through the wormhole, you find yourself in front of a rabbit hole. What secrets lie inside?

https://niccgetsspooky.xyz/r/a/b/b/i/t/h/o/l/e/rabbit-hole.svg
{% endhighlight %}

<p>That URL looks, spook-ily sus, but I went in anyway. (Un)surprisingly, the link just has a picture of a rabbit hole, and that is it?</p>

</font>

<center>
<img src="/image/spctf_2023/spctf_rabbit_hole.png" width="70%" height="70%">
</center>

<font size="4">

<p>... of course that's not it. Upon inspecting the webpage using the developer tool, there is a comment block (starting from <code><!-</code>) between the two images that are part of the hole part of the image.</p>

</font>

<center>
<img src="/image/spctf_2023/spctf_dev_tool.png">
</center>

<font size="4">
<p>Apparently this comment is very massive that copy-pasting it here almost fills up the entire page (it is 5 MB). So instead, I just let our fine dining handle it. </p>

</font>

<center>
<img src="/image/spctf_2023/spctf_cyberchef.png">
</center>

<font size="4">

<p></p>

<p>The cyber "Swiss Army Knife" says that too-long-for-this-blog-post (fun fact: even CyberChef almost froze) comment is actually a base32-encoded Gzip file. I downloaded the decoded string as a <code>.gz</code> file. </p>

</font>

<center>
<img src="/image/spctf_2023/spctf_dir1.png" width="70%" height="70%">
</center>

<font size="4">
<p></p>
<p>Now the fun begins...</p>

</font>

<center>
<img src="/image/spctf_2023/spctf_dir2.png" width="70%" height="70%">
</center>
<p></p>
<center>
<img src="/image/spctf_2023/spctf_dir3.png" width="70%" height="70%">
</center>
<p></p>
<center>
<img src="/image/spctf_2023/spctf_dir4.png" width="70%" height="70%">
</center>

<font size="4">

<p></p>

<p>Nice, we got nested zipped tarballs! After 655*3 mouse clicks (<code>secrets655.zip.bz2.gz -> secrets655.zip.bz2 -> secrets655.zip -> secrets654.zip.bz2.gz -> ...</code>), you will reach <code>secrets0</code> which has <code>flag.txt</code>.</p>

{% highlight plaintext %}
NICC{TH3-UF0S-4R3-UP-N0T-D0WN-50-WHY-4R3-Y0U-D0WN-H3R3}
{% endhighlight %}

<p><b>Flag: <code>NICC{TH3-UF0S-4R3-UP-N0T-D0WN-50-WHY-4R3-Y0U-D0WN-H3R3}</code></b></p>

<p>I <b>strongly recommend that you automate the recursive unzipping step</b>, instead of clicking it 655*3 times like I did. I don't remember why I had chosen to do it manually, IIRC it was because I initially thought it'll stop at <code>secrets600</code> or around that point, (then <code>secrets550</code>, and then so on...) so clicking it very fast could be faster than coding it up.</p>

</font>

<center>
<img src="/image/spctf_2023/spctf_barehands.png" width="60%" height="60%">
</center>

### The Wizard (OSINT)

<font size="4">

<blockquote><font size="3">
<p>We intercepted a photo intended to be received by a suspected agent working with the Zorglaxians - or so it seems.</p>

<p>Can you find the location of the photo while our team works on decrypting the accompanying message?</p>

<p>We need the entire street address, city and abbreviated state or district of where it was taken to send our agents to investigate with the local authorities.</p>

<p><code># = Number <br>
XX = State abbreviation <br>
All spaces are underscores</code></p>

<p>flag format: NICC{#_Street_Address_City_XX}</p>

<p><code><a href="https://spooky.ctfd.io/files/6584eb767cd6d35f6e06b825f6f6f4c1/the-wizard.png?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MTR9.ZZHMFg.d_qS7ocYT7Z0iHtz1JRsoNDeZJc">the-wizard.png</a></code></p>

<p><b>Developed by</b> <a href="https://github.com/AlfredSimpson">Cyb0rgSw0rd</a></p>

</font></blockquote>

<p>First things first. I downloaded <code><a href="https://spooky.ctfd.io/files/6584eb767cd6d35f6e06b825f6f6f4c1/the-wizard.png?token=eyJ1c2VyX2lkIjo0ODUsInRlYW1faWQiOjI1NSwiZmlsZV9pZCI6MTR9.ZZHMFg.d_qS7ocYT7Z0iHtz1JRsoNDeZJc">the-wizard.png</a></code>.</p>

</font>

<center>
<img src="/image/spctf_2023/spctf_the-wizard.png" width="70%" height="70%">
</center>

<font size="4">

<p></p>

<p>Google image search returned LOTS of websites, each with a photo of the same graffiti but different addresses. For example, the first website that we stumbled on was <a href="https://theclio.com/entry/144943">https://theclio.com/entry/144943</a>, which gave us the address: 938 24th St NW, Washington, DC. </p>

</font>

<p></p>

<center>
<img src="/image/spctf_2023/spctf_thewizard_1.png">
</center>

<font size="4">

<p></p>

<p>But allegedly, this was not the correct answer. After a few more wrong answers, we found the official website of Washington DC government that has the picture of this graffiti. <a href="https://washington.org/es/visit-dc/where-to-find-street-murals-washington-dc">https://washington.org/es/visit-dc/where-to-find-street-murals-washington-dc</a>.</p>

</font>

<center>
<img src="/image/spctf_2023/spctf_thewizard_sol.png" width="60%" height="60%">
</center>

<font size="4">

<p>This must be the correct answer, and it indeed was. </p>

<p><b>Flag: <code>NICC{950_24th_St_NW_Washington_DC}</code></b></p>

</font>

