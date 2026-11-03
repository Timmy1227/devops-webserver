#!/bin/bash

set -e

echo "=== DEVOPS EXIT STATUS MONITOR ==="

server_url="http://localhost:9000"

echo "Checking web server..."

if curl -fsS -o /dev/null --max-time 5 "$server_url"; then
    echo "SUCCESS: Web server is healthy"
    exit 0
else
    echo "CRITICAL: Web server is offline"
    exit 1
fi
