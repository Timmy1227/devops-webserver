#!/bin/bash

set -e

echo "=== DEVOPS FINAL MONITOR ==="

server_url="http://localhost:9000"
log_file="/home/kali/devops/cloned-webserver/logs/final-monitor.log"

mkdir -p "$(dirname "$log_file")"

timestamp=$(date "+%F %T")

echo "Checking web server..."

if curl -fsS -o /dev/null --max-time 5 "$server_url"; then
    message="SUCCESS: Web server is responding"
    echo "$timestamp - $message" | tee -a "$log_file"
    exit 0
else
    message="CRITICAL: Web server is offline"
    echo "$timestamp - $message" | tee -a "$log_file"
    exit 1
fi
