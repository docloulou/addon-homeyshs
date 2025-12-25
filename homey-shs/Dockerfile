ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy entrypoint wrapper that configures persistent storage before application startup.
# The wrapper creates a symlink from /homey/user to /data to map the application's expected
# data location to Home Assistant's persistent storage directory.
COPY rootfs/usr/local/bin/entrypoint-wrapper.sh /usr/local/bin/entrypoint-wrapper.sh
RUN chmod a+x /usr/local/bin/entrypoint-wrapper.sh

# Copy wrapper script that intercepts rrdcached calls to handle path resolution issues.
# Baked into the image to avoid runtime script generation.
COPY rootfs/usr/local/bin/rrdcached /usr/local/bin/rrdcached
RUN chmod a+x /usr/local/bin/rrdcached

# Override ENTRYPOINT so the wrapper runs before the base image's CMD.
# The base image's CMD will be passed as arguments to the wrapper.
ENTRYPOINT ["/usr/local/bin/entrypoint-wrapper.sh"]

