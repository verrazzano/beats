FROM oraclelinux:7.8 as build_base

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

WORKDIR /go/src/github.com/elastic/beats/filebeat
RUN make

FROM oraclelinux:7-slim

WORKDIR /usr/share/filebeat
COPY --from=build_base /go/src/github.com/elastic/beats/filebeat/filebeat .
COPY --from=build_base /go/src/github.com/elastic/beats/filebeat/module ./module
COPY --from=build_base /go/src/github.com/elastic/beats/filebeat/modules.d ./modules.d

COPY  LICENSE.txt licenses/APACHE-LICENSE-2.0.txt licenses/APACHE-LICENSE-2.0-header.txt NOTICE.txt README.md THIRD_PARTY_LICENSES.txt /license/

COPY verrazzano/filebeat/run.sh .
RUN chmod u+x run.sh

ENTRYPOINT ["/usr/share/filebeat/run.sh"]
