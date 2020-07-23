# Copyright (C) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

FROM container-registry.oracle.com/os/oraclelinux:7.8@sha256:46fc083cf0250ed5260fa6fe822d7d4c139ca1f7fc38e4a17ba662464bd1df4a as build_base

ARG VERSION

# Install golang via Oracle's yum servers per <https://yum.oracle.com/oracle-linux-golang.html>
RUN yum update -y \
    && yum-config-manager --save --setopt=ol7_ociyum_config.skip_if_unavailable=true \
    && yum install -y oracle-golang-release-el7 \
    && yum-config-manager --enable ol7_developer_golang113 \
    && yum-config-manager --add-repo http://yum.oracle.com/repo/OracleLinux/OL7/developer/golang113/x86_64 \
    && yum install -y git gcc make golang-1.13.3-1.el7.x86_64 \
    && yum clean all \
    && go version

# Compile to /usr/bin
ENV GOBIN=/usr/bin

# Set go path
ENV GOPATH=/go

RUN yum install -y python-virtualenv systemd-devel

WORKDIR /go/src/github.com/elastic/beats
COPY . .

WORKDIR /go/src/github.com/elastic/beats/journalbeat
RUN make

FROM container-registry.oracle.com/os/oraclelinux:7-slim@sha256:9b86d1332a883ee8f68dd44ba42133de518b2e0ec1cc70257e59fb4da86b1ad3

# journalbeat uses go-systemd which uses wrapper around c libs for journald/systemd
RUN yum install -y systemd-devel system-libs && yum clean all && rm -rf /var/cache/yum

WORKDIR /usr/share/journalbeat
COPY --from=build_base /go/src/github.com/elastic/beats/journalbeat/journalbeat .

COPY  LICENSE.txt licenses/APACHE-LICENSE-2.0.txt licenses/APACHE-LICENSE-2.0-header.txt NOTICE.txt README.md THIRD_PARTY_LICENSES.txt /license/

COPY verrazzano/journalbeat/run.sh .

RUN chmod u+x run.sh journalbeat
RUN useradd --no-log-init -r -g root -u 1000 journalbeat
RUN chown -R journalbeat run.sh journalbeat .

USER 1000

ENTRYPOINT ["/usr/share/journalbeat/run.sh"]
