# Include :download:`map file <map.jinja>` of OS-specific package names and
# file paths. Values can be overridden using Pillar.
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

include:
  - dnsmasq.install
  - dnsmasq.service

dnsmasq_conf_dir:
  file.recurse:
    - name: {{ dnsmasq.dnsmasq_conf_dir }}
    - source: {{ salt['pillar.get']('dnsmasq:dnsmasq_conf_dir', 'salt://dnsmasq/files/dnsmasq.d') }}
    - template: jinja
    - require:
      - sls: dnsmasq.install

dnsmasq_hosts:
  file.managed:
    - name: {{ dnsmasq.dnsmasq_hosts }}
    - source: {{ salt['pillar.get']('dnsmasq:dnsmasq_hosts', 'salt://dnsmasq/templates/dnsmasq.hosts') }}
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - sls: dnsmasq.install
    - watch_in:
      - service: dnsmasq

dnsmasq_cnames:
  file.managed:
    - name: {{ dnsmasq.dnsmasq_cnames }}
    - source: {{ salt['pillar.get']('dnsmasq:dnsmasq_cnames', 'salt://dnsmasq/templates/dnsmasq.cnames') }}
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - sls: dnsmasq.install
      - file: dnsmasq_conf_dir
    - watch_in:
      - service: dnsmasq

dnsmasq_conf:
  file.managed:
    - name: {{ dnsmasq.dnsmasq_conf }}
    - source: {{ salt['pillar.get']('dnsmasq:dnsmasq_conf', 'salt://dnsmasq/templates/dnsmasq.conf') }}
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      addn_hosts: {{ dnsmasq.dnsmasq_hosts }}
    - require:
      - sls: dnsmasq.install
    - watch_in:
      - service: dnsmasq
