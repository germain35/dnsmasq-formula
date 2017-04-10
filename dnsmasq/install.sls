{% from "dnsmasq/map.jinja" import dnsmasq with context %}

dnsmasq_packages:
  pkg.installed:
    - pkgs: {{dnsmasq.packages}}
