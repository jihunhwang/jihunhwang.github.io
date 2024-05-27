---
title: Blog
permalink: /blog/
layout: posts
search: exclude
toc: true
---

<script async src="https://www.googletagmanager.com/gtag/js?id=362935606"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '362935606');
</script>

<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.3/MathJax.js?config=TeX-MML-AM_CHTML">
    MathJax.Hub.Config({
        tex2jax: {
            inlineMath: [["$", "$"], ["\\(", "\\)"]],
            processEscapes: true
        }
    });
</script>

<!---
{% assign posts = site.posts | sort: 'date' %}
{% for post in posts %}
  <p><a href="{{ post.url }}">{{ post.title }}</a>
{% endfor %}
--->

<a href="/tags/" style="color: gray; text-decoration: underline;text-decoration-style: dotted; text-decoration-thickness: 1px;">Click here to sort posts by tag.</a>
