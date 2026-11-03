#!/bin/bash

echo "=== DEVOPS REUSABLE MONITOR ==="

server_url="$1"
log_file="/home/kali/devops/cloned-webserver/logs/reusable-monitor.log"

if [ -z "$server_url" ]; then
    echo "ERROR: No server URL provided"
    echo "Usage: $0 <server_url>"
    exit 2
fi

mkdir -p "$(dirname "$log_file")"

echo "Checking server: $server_url"

timestamp=$(date "+%F %T")

if curl -fsS -o /dev/null --max-time 5 "$server_url"; then
    message="SUCCESS: $server_url is responding"
    exit_code=0
else
    message="CRITICAL: $server_url is offline"
    exit_code=1
fi

echo "$timestamp - $message" | tee -a "$log_file"

exit "$exit_code"
