FROM golang:1.10.8
MAINTAINER Nicolas Ruflin <ruflin@elastic.co>

RUN set -x && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
         netcat python-pip rsync virtualenv libpcap-dev && \
    apt-get clean

RUN pip install --upgrade setuptools

# Setup work environment
ENV FILEBEAT_PATH /go/src/github.com/elastic/beats/filebeat

COPY  LICENSE.txt licenses/APACHE-LICENSE-2.0.txt licenses/APACHE-LICENSE-2.0-header.txt NOTICE.txt README.md THIRD_PARTY_LICENSES.txt /license/

RUN mkdir -p $FILEBEAT_PATH/build/coverage
WORKDIR $FILEBEAT_PATH
