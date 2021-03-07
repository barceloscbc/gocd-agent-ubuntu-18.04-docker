ARG GOCD_VERSION=v21.1.0
FROM gocd/gocd-agent-ubuntu-18.04:${GOCD_VERSION}
ARG DOCKERGID=999

USER root
VOLUME ["/var/run/docker.sock"]
RUN \
  groupadd -g ${DOCKERGID} docker && \ 
  adduser go docker && \
  curl --fail --location --silent --show-error "https://download.docker.com/linux/static/stable/x86_64/docker-19.03.5.tgz" | tar zxO docker/docker > /usr/bin/docker && \
  chmod a+x /usr/bin/docker

RUN \
  apt-get update -qqy \
  && apt-get install -qqy --no-install-recommends \
       gnupg \
       gpg-agent \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
