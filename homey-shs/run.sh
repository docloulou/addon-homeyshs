#!/usr/bin/with-contenv bashio
set -e

# This script runs during s6-overlay's initialization phase (cont-init.d)
# It maps Home Assistant add-on persistent data directory to Homey's expected location
# Home Assistant provides /data as the persistent directory for add-ons
# Homey SHS expects data at /homey/user

echo "Setting up Homey data directory..."

# Ensure /data exists (Home Assistant add-on persistent directory)
mkdir -p /data

# Ensure /homey directory exists
mkdir -p /homey

# If /homey/user exists and is not a symlink, we need to handle migration
if [ -d "/homey/user" ] && [ ! -L "/homey/user" ]; then
    # If /homey/user has content and /data is empty, migrate it
    if [ "$(ls -A /homey/user 2>/dev/null)" ] && [ ! "$(ls -A /data 2>/dev/null)" ]; then
        echo "Migrating existing data from /homey/user to /data..."
        cp -r /homey/user/* /data/ 2>/dev/null || true
    fi
    # Remove the old directory to create symlink
    rm -rf /homey/user
fi

# Create symlink from /data to /homey/user for persistence
if [ ! -L "/homey/user" ]; then
    echo "Creating symlink from /data to /homey/user..."
    ln -s /data /homey/user
fi

# Ensure proper permissions
chmod -R 755 /homey/user 2>/dev/null || chmod -R 755 /data 2>/dev/null || true

echo "Homey data directory setup complete."

