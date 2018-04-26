# Include :download:`map file <map.jinja>` of OS-specific package names and
# file paths. Values can be overridden using Pillar.
{%- from "dnsmasq/map.jinja" import dnsmasq with context %}

include:
  - dnsmasq.install
  - dnsmasq.service

dnsmasq_default_file:
  file.managed:
    - name: {{ dnsmasq.default_file }}
    - source: salt://dnsmasq/templates/default
    - user: root
    - mode: 644
    - template: jinja
    - require:
      - sls: dnsmasq.install
    - watch_in:
      - service: dnsmasq_service

dnsmasq_conf_dir:
  file.recurse:
    - name: {{ dnsmasq.conf_dir }}
    - source: salt://dnsmasq/files/dnsmasq.d
    - template: jinja
    - require:
      - sls: dnsmasq.install

dnsmasq_hosts_file:
  file.managed:
    - name: {{ dnsmasq.hosts_file }}
    - source: salt://dnsmasq/templates/dnsmasq.hosts
    - user: root
    - mode: 644
    - template: jinja
    - require:
      - sls: dnsmasq.install
    - watch_in:
      - service: dnsmasq_service

dnsmasq_cnames_file:
  file.managed:
    - name: {{ dnsmasq.cnames_file }}
    - source: salt://dnsmasq/templates/dnsmasq.cnames
    - user: root
    - mode: 644
    - template: jinja
    - require:
      - sls: dnsmasq.install
      - file: dnsmasq_conf_dir
    - watch_in:
      - service: dnsmasq_service

dnsmasq_conf_file:
  file.managed:
    - name: {{ dnsmasq.conf_file }}
    - source: salt://dnsmasq/templates/dnsmasq.conf
    - user: root
    - mode: 644
    - template: jinja
    - context:
      addn_hosts: {{ dnsmasq.hosts_file }}
    - require:
      - sls: dnsmasq.install
    - watch_in:
      - service: dnsmasq_service
