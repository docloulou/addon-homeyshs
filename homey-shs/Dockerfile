FROM ghcr.io/athombv/homey-shs:latest

# Copy initialization script to s6-overlay's cont-init.d directory
# This sets up the data directory mapping before services start
COPY run.sh /etc/cont-init.d/99-homey-data-setup.sh
RUN chmod a+x /etc/cont-init.d/99-homey-data-setup.sh

# Don't override CMD/ENTRYPOINT - let the base image handle starting Homey SHS
# The base image should have its own startup mechanism that works when run directly

