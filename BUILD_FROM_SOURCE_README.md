# Build Instructions

The base tag this release is branched from is `v6.8.3`


Build and Push Images

```
export DOCKER_REPO=<Docker Repository>
export DOCKER_NAMESPACE=<Docker Namespace>
export DOCKER_TAG=<Image Tag>

# Build and publish filebeat
docker build --file verrazzano/filebeat/Dockerfile --tag ${DOCKER_REPO}/${DOCKER_NAMESPACE}/filebeat:${DOCKER_TAG}  .
docker push ${DOCKER_REPO}/${DOCKER_NAMESPACE}/filebeat:${DOCKER_TAG}

# Build and publish journalbeat
docker build --file verrazzano/journalbeat/Dockerfile --tag ${DOCKER_REPO}/${DOCKER_NAMESPACE}/journalbeat:${DOCKER_TAG} .
docker push ${DOCKER_REPO}/${DOCKER_NAMESPACE}/journalbeat:${DOCKER_TAG}
```
