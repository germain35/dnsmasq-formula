# Include :download:`map file <map.jinja>` of OS-specific package names and
# file paths. Values can be overridden using Pillar.
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

include:
  - dnsmasq.install

{%- if dnsmasq.service_running %}

dnsmasq_service:
  service.running:
    - name: {{ dnsmasq.service }}
    - enable: {{ dnsmasq.service_enabled }}
    - reload: {{ dnsmasq.service_reload }}
    - require:
      - sls: dnsmasq.install

{%- else %}

dnsmasq_service:
  service.dead:
    - name: {{ dnsmasq.service }}
    - enable: {{ dnsmasq.service_enabled }}
    - require:
      - sls: dnsmasq.install

{%- endif %}
