#!/bin/bash

# Copyright (C) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

set -x -e

cat /etc/filebeat/filebeat.yml
exec /usr/share/filebeat/filebeat -e -c /etc/filebeat/filebeat.yml
