#!/bin/bash

# Load configuration
source /home/kali/devops/cloned-webserver/config/monitor.conf

echo "===== CONFIGURABLE DEVOPS MONITOR ====="
echo "Server: $SERVER_NAME"
echo "URL: $SERVER_URL"

timestamp=$(date "+%F %T")

if curl -fs -o /dev/null "$SERVER_URL"; then
    message="SUCCESS: $SERVER_NAME is responding"
    exit_code=0
else
    message="CRITICAL: $SERVER_NAME is offline"
    exit_code=1
fi

echo "$timestamp - $message" | tee -a "$LOG_FILE"

exit "$exit_code"
