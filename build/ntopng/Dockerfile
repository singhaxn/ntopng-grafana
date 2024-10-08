FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

ADD setup /setup
RUN chmod +x /setup/install.sh && /setup/install.sh && rm -rf /setup

ENTRYPOINT ["ntopng", "-d", "/var/lib/ntopng"]
