#!/bin/bash
set -x -e

cat /etc/filebeat/filebeat.yml
exec /usr/share/filebeat/filebeat -e -c /etc/filebeat/filebeat.yml
