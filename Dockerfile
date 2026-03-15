FROM debian:trixie-slim

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        sed \
        grep \
        jq \
        sudo \
        && \
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* get-docker.sh

# Ensure docker-compose symlink exists
RUN if [ ! -f /usr/local/bin/docker-compose ]; then \
        ln -s /usr/libexec/docker/cli-plugins/docker-compose /usr/local/bin/docker-compose; \
    fi

# Copy custom start script
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Set working directory (matches Pterodactyl server mount)
WORKDIR /home/container

# Default command (can be overridden by Pterodactyl startup command)
CMD ["/usr/local/bin/start.sh"]
