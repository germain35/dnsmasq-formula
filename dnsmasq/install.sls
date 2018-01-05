{% from "dnsmasq/map.jinja" import dnsmasq with context %}

{%- if dnsmasq.pxe_enabled %}
dnsmasq_pxe_packages:
  pkg.installed:
    - pkgs: {{ dnsmasq.packages }}
{%- endif %}

dnsmasq_packages:
  pkg.installed:
    - pkgs: {{ dnsmasq.packages }}
