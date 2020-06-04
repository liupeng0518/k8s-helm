FROM alpine

LABEL maintainer="Samuel Liu <liuepng04@inspur.com>"

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.opencontainers.image.title="liupeng0518/k8s-helm" \
      org.opencontainers.image.url="https://helm.sh/docs/" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.source="https://github.com/liupeng0518/k8s-helm" \
      org.opencontainers.image.created=$BUILD_DATE

ENV HELM_LATEST_VERSION="v2.16.7"

RUN apk add --update ca-certificates \
 && apk add --update -t deps wget git openssl bash \
 && wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_LATEST_VERSION}-linux-arm64.tar.gz \
 && tar -xf helm-${HELM_LATEST_VERSION}-linux-arm64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm -f /helm-${HELM_LATEST_VERSION}-linux-arm64.tar.gz

ENTRYPOINT ["helm"]
CMD ["help"]
