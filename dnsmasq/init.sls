{% from "dnsmasq/map.jinja" import dnsmasq with context %}

include:
  - dnsmasq.install
  - dnsmasq.config
  - dnsmasq.service
