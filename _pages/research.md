---
title: Research
# layout: splash
author_profile: true
permalink: /research/
# toc: true
search: exclude
sitemap: false
---

<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.3/MathJax.js?config=TeX-MML-AM_CHTML">
    MathJax.Hub.Config({
        tex2jax: {
            inlineMath: [["$", "$"], ["\\(", "\\)"]],
            processEscapes: true
        }
    });
</script>

## Publications

<font size="3"> 
<p><i>Nota Bene: Authors are usually listed alphabetically, often even arbitrarily, among mathematicians and theoretical computer scientists. See <a href="http://www.ams.org/profession/leaders/CultureStatement04.pdf">this statement</a> from the American Mathematical Society for details.</i></p>
</font>

<!--
Note for myself
publication_list.html is under _includes
publications_phd.yml and publications_side.yml are under _data
colleagues.yml is also under _data
-->

Papers that reflect my current primary research interest the best:

{% include publication_list.html data_file="publications_phd" %}

I also have a side interest in network algorithms/modeling, and computer security in general:
{% assign prev_count = site.data["publications_phd"] | size | plus: 1 %}
{% include publication_list.html data_file="publications_side"  start_num=prev_count %}




## Coauthors

#### People I published with

{% assign all_papers = site.data.publications_phd | concat: site.data.publications_side %}

{% assign coauthors_all = "" | split: "," %}
{% for paper in all_papers %}
  {% if paper.coauthors %}
    {% assign coauthors_all = coauthors_all | concat: paper.coauthors %}
  {% endif %}
{% endfor %}
{% assign coauthors_unique = coauthors_all | uniq | sort %}

<div class="collab-columns">
{% for person in coauthors_unique %}
  {% assign person_url = site.data.people[person] %}
  {% assign links = "" %}
  {% assign is_first = true %}
  {% for paper in all_papers %}
    {% if paper.coauthors contains person %}
      {% assign n = forloop.index %}
      {% if is_first %}
        {% assign links = links | append: '<a href="#paper-' | append: n | append: '">[' | append: n | append: ']</a>' %}
        {% assign is_first = false %}
      {% else %}
        {% assign links = links | append: ', <a href="#paper-' | append: n | append: '">[' | append: n | append: ']</a>' %}
      {% endif %}
    {% endif %}
  {% endfor %}
  <div class="collab-item">
  {% if person_url %}<a href="{{ person_url }}">{{ person }}</a>{% else %}{{ person }}{% endif %}
  ({{ links }})
  </div>
{% endfor %}
</div>




<style>
/* Venue badge */
abbr.venue-badge {
  display: inline-block;
  padding: 2px 7px;
  border-radius: 4px;
  font-size: 0.8em;
  font-weight: bold;
  font-style: normal;
  color: white;
  vertical-align: middle;
  margin-right: 3px;
  white-space: nowrap;
  text-decoration: none;
}

abbr.venue-badge a {
  color: white;
  text-decoration: none;
}

abbr.venue-badge a:hover {
  text-decoration: underline;
}

/* Abstract summary */
summary.abstract-summary {
  font-size: 0.8em;   /* smaller summary font */
  text-decoration: underline;
}

details.abstract-details p {
  font-size: 0.8em; /* slightly smaller */
  padding-left: 1em;  /* indent the summary text */
  display: block;     /* ensures padding applies properly */
  margin: 0.2em 0;
}

details.abstract-details li {
  font-size: 0.8em;
}

summary.abstract-summary::after {
  content: " Abstract (click to expand)";
}

details[open] summary.abstract-summary::after {
  content: " Abstract (click to collapse)";
}

/* BibTeX summary */
summary.bibtex-summary {
  font-size: 0.7em; /* even smaller */
}

summary.bibtex-summary::after {
  content: " BibTeX (click to expand)";
}

details[open] summary.bibtex-summary::after {
  content: " BibTeX (click to collapse)";
}

p span.indented {
  display: block;      /* each line behaves like a block */
  text-indent: 1em;    /* indent the first line of each block */
}


.collab-columns {
  columns: 3 220px;      /* up to 3 columns, each at least 220px wide, auto-collapses on narrow screens */
  column-gap: 1.5em;
}

.collab-item {
  break-inside: avoid-column;  /* keep each person's entry from splitting across columns */
  margin-bottom: 0.1em;
}
</style>
