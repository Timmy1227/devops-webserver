#!/bin/bash

set -e

echo "=== DEVOPS SAFE ERROR HANDLING ==="

server_url="http://localhost:9000"

echo "Checking web server..."

if curl -fsS -o /dev/null --max-time 5 "$server_url"; then
    echo "SUCCESS: Web server is responding"
else
    echo "CRITICAL: Web server is not responding"
fi

echo "Monitoring check completed"
