---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

# Libro de Urología Pediátrica

{% for i in (1..8) %}
  {% assign section = site.data.sections | where: "index",i | first %}
## Sección {{ i }}: {{ section.title }}

  {% if section.subsections == nil %}
    {% assign section_chapters = site.chapters | where: "section", i | sort: "sort-key" %}
    {% for chapter in section_chapters %}
- <a href="/es{{ chapter.url }}">{{ chapter.title }}</a>
    {% endfor %}
  {% else %}
    {% for subsection in section.subsections %}
### Subsección {{ subsection.index }}: {{ subsection.title }}
      {% assign subsection_chapters = site.chapters | where: "section", section.index | where: "subsection", subsection.index | sort: "sort-key" %}
      {% for chapter in subsection_chapters  %}
- <a href="/es{{ chapter.url }}">{{ chapter.title }}</a>
      {% endfor %}
    {% endfor %}
  {% endif %}
{% endfor %}