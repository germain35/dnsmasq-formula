{% from "dnsmasq/map.jinja" import dnsmasq with context %}

{%- if dnsmasq.pxe %}
dnsmasq_pxe_packages:
  pkg.installed:
    - pkgs: {{dnsmasq.packages}}
{%- endif %}

dnsmasq_packages:
  pkg.installed:
    - pkgs: {{dnsmasq.packages}}
