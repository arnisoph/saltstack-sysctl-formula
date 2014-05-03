{% from "sysctl/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('sysctl:lookup')) %}

{% for p in salt['pillar.get']('sysctl:params') %}
sysctl-{{ p.name }}:
  sysctl:
    - {{ p.ensure|default('present') }}
    - name: {{ p.name }}
    - value: {{ p.value }}
{% endfor %}
