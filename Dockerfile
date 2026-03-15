# Use the official Pterodactyl Docker yolk as base
FROM ghcr.io/pterodactyl/yolks:docker

# Install additional utilities required by the egg's install script and mailcow
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        ca-certificates \
        sed \
        grep \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# Ensure docker-compose (the standalone command) is available
# The base image already has docker-compose-plugin, which provides both
# 'docker compose' and (usually) a symlink at /usr/local/bin/docker-compose.
# But to be safe, we create the symlink explicitly if it's missing.
RUN if [ ! -f /usr/local/bin/docker-compose ]; then \
        ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose; \
    fi

# Switch to the non‑root user expected by Pterodactyl
USER container
WORKDIR /home/container
