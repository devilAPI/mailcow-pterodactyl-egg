FROM analogic/poste.io:latest

# Create a writable directory for s6 runtime files
RUN mkdir -p /home/container/s6 && \
    # Symlink /var/run/s6 to the writable location
    rm -rf /var/run/s6 && \
    ln -s /home/container/s6 /var/run/s6

# Optional: Ensure permissions
RUN chown -R container:container /home/container/s6
