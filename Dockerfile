FROM analogic/poste.io:latest

# Copy the custom start script
COPY start.sh /start.sh
RUN chmod +x /start.sh
RUN ln -s /home/container/s6 /var/run/s6

# Use it as the new entrypoint
ENTRYPOINT ["/start.sh"]
