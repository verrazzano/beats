# Copyright (C) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

FROM container-registry.oracle.com/os/oraclelinux:7.9@sha256:5aa7df08f9ab8cd6237223b0b6c5fd605f140164235b462a01e8b9d56fb03daf as build_base

ARG VERSION

# Install golang via Oracle's yum servers per <https://yum.oracle.com/oracle-linux-golang.html>
RUN yum update -y \
    && yum-config-manager --save --setopt=ol7_ociyum_config.skip_if_unavailable=true \
    && yum install -y oracle-golang-release-el7 \
    && yum-config-manager --add-repo http://yum.oracle.com/repo/OracleLinux/OL7/developer/golang114/x86_64 \
    && yum install -y git gcc make golang-1.14.4-1.el7 \
    && yum clean all \
    && go version

# Compile to /usr/bin
ENV GOBIN=/usr/bin

# Set go path
ENV GOPATH=/go

RUN yum install -y python-virtualenv systemd-devel

WORKDIR /go/src/github.com/elastic/beats
COPY . .

WORKDIR /go/src/github.com/elastic/beats/filebeat
RUN make

FROM container-registry.oracle.com/os/oraclelinux:7-slim@sha256:fcc6f54bb01fc83319990bf5fa1b79f1dec93cbb87db3c5a8884a5a44148e7bb

WORKDIR /usr/share/filebeat
COPY --from=build_base /go/src/github.com/elastic/beats/filebeat/filebeat .
COPY --from=build_base /go/src/github.com/elastic/beats/filebeat/module ./module
COPY --from=build_base /go/src/github.com/elastic/beats/filebeat/modules.d ./modules.d

COPY  LICENSE.txt licenses/APACHE-LICENSE-2.0.txt licenses/APACHE-LICENSE-2.0-header.txt NOTICE.txt README.md THIRD_PARTY_LICENSES.txt /license/

COPY verrazzano/filebeat/run.sh .
RUN chmod u+x run.sh

ENTRYPOINT ["/usr/share/filebeat/run.sh"]
