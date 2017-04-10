{% from "dnsmasq/map.jinja" import dnsmasq with context %}

dnsmasq:
  pkg.installed:
    - pkgs: {{dnsmasq.packages}}
