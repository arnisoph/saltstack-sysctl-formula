#!jinja|yaml

{% set datamap = salt['formhelper.get_defaults']('sysctl', saltenv, ['yaml'])['yaml'] %}

{% for p in datamap.params|default([]) %}
 {% if p.set|default('sysctl') == 'manual' %}
sysctl_{{ p.name }}_manual:
  cmd:
    - run
    - name: echo '{{ p.value }}' > {{ p.name }}
    - unless: /usr/bin/test "$(/bin/cat {{ p.name }})" = {{ p.value }}
 {% else %}
sysctl_{{ p.name }}:
  sysctl:
    - {{ p.ensure|default('present') }}
    - name: {{ p.name }}
    - value: {{ p.value }}
 {% endif %}
{% endfor %}
