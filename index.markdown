---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: toc
permalink-en: contents.htm
---

# Tabla de contenido

[&rarr; Enlace a la versión en inglés (Go to English version)]({{ site.url }}/{{ page.permalink-en }})

<div id="toc" markdown="1" style="column-count:2">

{% for i in (1..8) %}
  {% assign section = site.data.sections | where: "index",i | first %}
  {% include toc-block.html %}
{% endfor %}

</div>