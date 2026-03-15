FROM analogic/poste.io:latest

RUN mkdir -p /home/container/s6 && \
    rm -rf /var/run/s6 && \
    ln -s /home/container/s6 /var/run/s6
