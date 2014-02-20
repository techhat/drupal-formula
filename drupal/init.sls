include:
    - php

drupal:
    archive:
        - extracted
        - tar_options: J
        - archive_format: tar
        - name:  {{ salt['pillar.get']('drupal:home', '/var/www/drupal') }}
        - source: http://ftp.drupal.org/files/projects/drupal-{{ salt['pillar.get']('drupal:version', '7.26') }}.tar.gz
        - source_hash: {{ salt['pillar.get']('drupal:source_hash') }}
        - if_missing: {{ salt['pillar.get']('drupal:home', '/var/www/drupal') }}


{% if salt['pillar.get']('webserver:apache2', 'apache2') %}

/etc/apache2/sites-available/salt['pillar.get']('drupal:name'):
    file.managed:
        - source: salt://drupal/files/apache2
{% elif salt['pillar.get']('webserver:nginx') %}

/etc/nginx/salt['pillar.get']('drupal:name'):
    file.managed:
        - source: salt://drupal/files/nginx
# TODO: Add support for webserver
{% elif salt['pillar.get']('webserver:lighthttpd') %}

/etc/lighthtpd/salt['pillar.get']('drupal:name'):
    file.managed:
        - source: salt://drupal/files/lighthttpd
# TODO: Add support for webserver
{% endif %}
        - user: {{ salt['pillar.get']('webserver:user') }}
        - group: {{ salt['pillar.get']('webserver:group') }}
        - mode: 644
        - template: jinja
        - defaults:
            name: salt['pillar.get']('drupal:name')