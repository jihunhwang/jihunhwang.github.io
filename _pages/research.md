---
title: Research
# layout: splash
author_profile: true
permalink: /research/
# toc: true
search: exclude
sitemap: false
---


## Publications

<font size="3">
<p><i>Nota Bene: Authors are usually listed alphabetically, often even arbitrarily, among mathematicians and theoretical computer scientists. See <a href="http://www.ams.org/profession/leaders/CultureStatement04.pdf">this statement</a> from the American Mathematical Society for details.</i></p>
</font>

<!-- Template
<li>
	<b>title</b>
	<br>
	{{ "with (author names)" | link_colleagues }}
	<br>
	<b>(conference)</b> [<a href="link">PDF</a>] 
	<br>
	<details class="abstract-details" closed>
		<summary class="abstract-summary"></summary>
			<p>
				<span class="indented">
					text
				</span>
				<span class="indented">
					text
				</span>
				<span class="indented">
					text
				</span>
			</p>
	</details>
</li>
-->

Papers that reflects my current primary research interest the best:

{% include publication_list.html data_file="publications_phd" %}

<!-- <ol>
{% for paper in site.data.publications_phd %}
  <li>
    <b>{{ paper.title }}</b><br>
    with {% assign authors_count = paper.authors | size %}
    {% assign second_last_index = authors_count | minus:2 %}
    {% for author in paper.authors %}
      {% assign url = site.data.colleagues[author] %}
      {% if url %}<a href="{{ url }}">{{ author }}</a>{% else %}{{ author }}{% endif %}{% if forloop.index0 < second_last_index %},{% elsif forloop.index0 == second_last_index %}, and{% endif %}
    {% endfor %}
    <br>
    <b>{{ paper.venue }}</b>
    {% if paper.pdf %}
      [<a href="{{ paper.pdf }}">PDF</a>]
    {% endif %}
    {% if paper.full_version %}
      [<a href="{{ paper.full_version }}">Full version</a>]
    {% endif %}
    {% if paper.LIPIcs %}
      [<a href="{{ paper.LIPIcs }}">LIPIcs</a>]
    {% endif %}
    {% if paper.NTRS %}
      [<a href="{{ paper.NTRS }}">NTRS</a>]
    {% endif %}
    {% if paper.slides %}
      [<a href="{{ paper.slides }}">Slides</a>]
    {% endif %}
    {% if paper.demo %}
      [<a href="{{ paper.demo }}">Demo</a>]
    {% endif %}
    {% if paper.github %}
      [<a href="{{ paper.github }}">GitHub</a>]
    {% endif %}
    {% if paper.video %}
      [<a href="{{ paper.video }}">Video</a>]
    {% endif %}
    <br>
    <details class="abstract-details" closed>
      <summary class="abstract-summary"></summary>
      {% for paragraph in paper.abstract %}
        <p><span class="indented">{{ paragraph }}</span></p>
      {% endfor %}
    </details>
  </li>
{% endfor %}
</ol> -->

I also have a side interest in network algorithms/modeling, and computer security in general:

{% include publication_list.html data_file="publications_side" %}



## Unpublished Writeups


## People

<style>
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
