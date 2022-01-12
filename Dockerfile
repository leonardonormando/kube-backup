FROM alpine:3.11

RUN apk update && \
  apk add --update \
    bash \
    easy-rsa \
    git \
    openssh-client \
    curl \
    ca-certificates \
    libstdc++ \
    gpgme \
    && \
  rm -rf /var/cache/apk/*

RUN adduser -h /backup -D backup

ENV KUBECTL_VERSION 1.19.0
ENV KUBECTL_URI https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl

RUN curl -SL ${KUBECTL_URI} -o kubectl && chmod +x kubectl
RUN curl -SL https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o yq && chmod +x yq

ENV PATH="/:${PATH}"

COPY entrypoint.sh /
USER backup
ENTRYPOINT ["/entrypoint.sh"]
