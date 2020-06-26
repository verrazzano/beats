#!/bin/bash
set -x -e

cat /etc/journalbeat/journalbeat.yml
exec /usr/share/journalbeat/journalbeat -e -c /etc/journalbeat/journalbeat.yml
