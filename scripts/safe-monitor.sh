#!/bin/bash

config_file="/home/kali/devops/cloned-webserver/config/monitor.conf"

echo "===== DEVOPS SAFE MONITOR ====="

# Check configuration file exists
if [ ! -f "$config_file" ]; then
    echo "ERROR: Configuration file not found"
    exit 2
fi

# Load configuration
source "$config_file"

# Validate required variables
if [ -z "$SERVER_NAME" ] || [ -z "$SERVER_URL" ] || [ -z "$LOG_FILE" ]; then
    echo "ERROR: Required configuration is missing"
    exit 2
fi

# Ensure logging directory exists
mkdir -p "$(dirname "$LOG_FILE")"

echo "Monitoring: $SERVER_NAME"
echo "Server URL: $SERVER_URL"

timestamp=$(date "+%F %T")

if curl -fsS -o /dev/null --max-time 5 "$SERVER_URL"; then
    message="SUCCESS: $SERVER_NAME is responding"
    exit_code=0
else
    message="CRITICAL: $SERVER_NAME is offline"
    exit_code=1
fi

echo "$timestamp - $message" | tee -a "$LOG_FILE"

exit "$exit_code"
