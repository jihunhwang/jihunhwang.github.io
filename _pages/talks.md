---
title: Talks
permalink: /talks/
# toc: true
# toc_sticky: yes
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

On this page, you will find the notes and slides I made for the talks I presented.

<!--
talk_list.html is the code, it is in /_includes folder.
talks_invited.yml is the data file, it is in /_data folder.
-->

## Invited / Conference Talks

{% include talk_list.html data_file="talks_invited" %}


## Informal Talks (Reading Seminar, etc.)

{% include talk_list.html data_file="talks_informal" %}


## In-class Talks

{% include talk_list_inclass.html data_file="talks_inclass" %}


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
  margin-right: 5px;
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
</style>
