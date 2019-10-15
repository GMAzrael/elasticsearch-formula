# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import elasticsearch with context %}
  {%- if elasticsearch.pkg.use_upstream_repo %}
    {%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}
  {%- set oss_url = "" %}
  {%- if elasticsearch.pkg.use_oss_pkg %}
    {%- set oss_url = elasticsearch.pkg.oss_url %}
  {%- endif %}

elasticsearch-package-repo-install-pkgrepo-managed:
  pkgrepo.managed:
    - {{ elasticsearch.pkg.os }}: {{ elasticsearch.pkg.baseurl }}/{{ oss_url }}{{ elasticsearch.version }}/{{ elasticsearch.pkg.type }}
    {{- format_kwargs(elasticsearch.pkg.repo) }}
  {%- endif %}
