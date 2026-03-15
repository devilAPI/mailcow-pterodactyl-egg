FROM analogic/poste.io:latest

# Copy the custom start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Use it as the new entrypoint
ENTRYPOINT ["/start.sh"]
