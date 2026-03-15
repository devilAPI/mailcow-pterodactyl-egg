#!/bin/bash
set -e

cd /home/container/mailcow-dockerized

# Check if we should run generate_config.sh (controlled by egg variable)
# Convert to lowercase for case‑insensitive comparison
RUN_GEN=$(echo "${PTERODACTYL_RUN_GEN_CONFIG}" | tr '[:upper:]' '[:lower:]')
if [[ "${RUN_GEN}" == "yes" || "${RUN_GEN}" == "y" || "${RUN_GEN}" == "true" || "${RUN_GEN}" == "1" ]]; then
    echo "📝 Running generate_config.sh to create fresh mailcow.conf..."
    ./generate_config.sh

    # Override with user‑supplied variables from the egg
    echo "🔧 Applying egg variables to mailcow.conf"
    sed -i "s/^HTTP_PORT=.*/HTTP_PORT=${HTTP_PORT}/" mailcow.conf
    sed -i "s/^HTTPS_PORT=.*/HTTPS_PORT=${HTTPS_PORT}/" mailcow.conf
    sed -i "s/^SKIP_LETS_ENCRYPT=.*/SKIP_LETS_ENCRYPT=${SKIP_LETS_ENCRYPT}/" mailcow.conf
    # Note: MAILCOW_HOSTNAME is already set by generate_config.sh if the env var exists
fi

# Start mailcow
echo "🚀 Starting mailcow with docker-compose up"
exec docker-compose up
