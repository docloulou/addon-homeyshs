#!/bin/sh
# Entrypoint wrapper that configures persistent storage before starting the application.
# Home Assistant mounts persistent data at /data, but the application expects /homey/user.

echo "========================================="
echo "Setting up Homey Self-Hosted Server environment..."
echo "========================================="

echo "[INFO] Setting up persistent storage..."

mkdir -p /data /homey
mkdir -p /data/rrd

# Create symlink from /homey/user to /data to map the application's expected data location
# to Home Assistant's persistent storage directory. Handles migration from previous versions
# where /homey/user may have been a directory instead of a symlink.
if [ -L "/homey/user" ]; then
    TARGET=$(readlink -f /homey/user 2>/dev/null || readlink /homey/user 2>/dev/null || echo "")
    if [ "$TARGET" = "/data" ]; then
        echo "[INFO] Symlink /homey/user -> /data already exists"
    else
        echo "[INFO] Removing incorrect symlink and creating new one"
        rm -f /homey/user
        ln -sf /data /homey/user
        echo "[INFO] Created symlink /homey/user -> /data"
    fi
elif [ -d "/homey/user" ] && ! mountpoint -q /homey/user 2>/dev/null; then
    # Backward compatibility: migrate data from directory-based storage to symlink-based storage
    if [ "$(ls -A /homey/user 2>/dev/null)" ] && [ ! "$(ls -A /data 2>/dev/null)" ]; then
        echo "[INFO] Migrating data from /homey/user to /data..."
        cp -a /homey/user/. /data/ 2>/dev/null || true
    fi
    rm -rf /homey/user
    ln -sf /data /homey/user
    echo "[INFO] Created symlink /homey/user -> /data"
elif [ ! -e "/homey/user" ]; then
    ln -sf /data /homey/user
    echo "[INFO] Created symlink /homey/user -> /data"
fi

if [ ! -d "/data/rrd" ]; then
    mkdir -p /data/rrd
    echo "[INFO] Created /data/rrd directory"
fi

# Verify that /data is mounted by Home Assistant to ensure persistence works
if mountpoint -q /data 2>/dev/null; then
    DATA_SOURCE=$(findmnt -n -o SOURCE /data 2>/dev/null || echo "")
    echo "[INFO] /data is mounted from: $DATA_SOURCE"
else
    echo "[WARN] /data is NOT a mount point - this might indicate an issue with Home Assistant's persistent storage"
fi

# Verify symlink functionality and write permissions before starting the application
if [ -L "/homey/user" ]; then
    SYMLINK_TARGET=$(readlink -f /homey/user 2>/dev/null || readlink /homey/user 2>/dev/null || echo "")
    echo "[INFO] Symlink verification: /homey/user -> $SYMLINK_TARGET"
    
    if touch /homey/user/.test-write 2>/dev/null; then
        rm -f /homey/user/.test-write
        echo "[INFO] Write test to /homey/user successful"
    else
        echo "[ERROR] Cannot write to /homey/user"
    fi
fi

echo "[INFO] Contents of /data:"
ls -la /data/ 2>/dev/null | head -10 || echo "  /data is empty or not accessible"

echo "[INFO] Persistent storage setup complete"
echo "========================================="

# Verify wrapper exists to handle path resolution issues
if [ -f "/usr/local/bin/rrdcached" ]; then
    echo "[INFO] rrdcached wrapper is ready"
else
    echo "[WARN] rrdcached wrapper not found, rrdcached may fail"
fi

# Execute the base image's CMD, falling back to default if no arguments provided
if [ $# -eq 0 ]; then
    echo "[INFO] No arguments provided, using default command"
    exec node --conditions=typescript apps/homey-shs/index.mts
else
    echo "[INFO] Executing: $@"
    exec "$@"
fi

