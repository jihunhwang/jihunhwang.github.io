---
title: Talks
permalink: /talks/
toc: true
toc_sticky: yes
search: exclude
sitemap: false
---


On this page, you will find the notes and slides I made for the talks I presented.

<!--
talk_list.html is the code, it is in /_includes folder.
talks_invited.yml and talks_conference.yml are the data files, they are in /_data folder.
-->

## Invited Talks

{% include talk_list.html data_file="talks_invited" %}


## Conference Talks

{% include talk_list.html data_file="talks_conference" %}


## Informal Talks

### Reading Seminar Talks

{% include talk_list.html data_file="talks_informal" %}


### In-class Talks

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

/* Talk link buttons and abstract toggle: see "Publications and talks" in assets/css/main.scss */

</style>
