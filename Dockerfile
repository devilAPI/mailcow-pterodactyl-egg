FROM debian:trixie-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        sed \
        grep \
        && \
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* get-docker.sh

RUN if [ ! -f /usr/local/bin/docker-compose ]; then \
        ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose; \
    fi

RUN useradd -m -d /home/container -s /bin/bash container
USER container
WORKDIR /home/container
