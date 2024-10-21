#!/bin/bash

# Check if USBIP_SERVER and USBIP_BUS_ID environment variables are set
if [[ -z "$USBIP_SERVER" || -z "$USBIP_BUS_ID" ]]; then
    echo "Error: USBIP_SERVER and USBIP_BUS_ID must be provided."
    exit 1
fi

# Connect to the remote USB device
echo "Connecting to USB device at $USBIP_SERVER with bus ID $USBIP_BUS_ID"
# usbip list -r "$USBIP_SERVER"
# usbip attach -r "$USBIP_SERVER" -b "$USBIP_BUS_ID"

# Run your binary file
echo "Starting the binary executable..."
JAVA_HOME=/usr/local/openjdk-17 /app/InfoPower/InfoPower

# Keep the container running
exec "$@"

# exec sleep infinity