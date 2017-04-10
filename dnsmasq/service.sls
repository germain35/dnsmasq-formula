# Include :download:`map file <map.jinja>` of OS-specific package names and
# file paths. Values can be overridden using Pillar.
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

include:
  - dnsmasq.install

dnsmasq:
  service.running:
    - name: {{ dnsmasq.service }}
    - enable: True
    - require:
      - sls: dnsmasq.install
