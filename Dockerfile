# Use a lightweight Debian base
FROM debian:bullseye-slim

# Install Docker CLI and required tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        sed \
        grep \
        && \
    # Install Docker CLI using the official convenience script
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* get-docker.sh

# Ensure the docker-compose plugin is available (creates a symlink if needed)
RUN if [ ! -f /usr/local/bin/docker-compose ]; then \
        ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose; \
    fi

# Create and switch to a non-root user (Pterodactyl expects this)
RUN useradd -m -d /home/container -s /bin/bash container
USER container
WORKDIR /home/container
