{% from "sysctl/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('sysctl:lookup')) %}

{% for p in salt['pillar.get']('sysctl:params') %}
 {% if p.set|default('sysctl') == 'manual' %}
sysctl-{{ p.name }}-manual:
  cmd:
    - run
    - name: echo '{{ p.value }}' > {{ p.name }}
    - unless: /usr/bin/test "$(/bin/cat {{ p.name }})" = {{ p.value }}
 {% else %}
sysctl-{{ p.name }}:
  sysctl:
    - {{ p.ensure|default('present') }}
    - name: {{ p.name }}
    - value: {{ p.value }}
 {% endif %}
{% endfor %}
