
#!/bin/bash

echo "===== DEVOPS SERVER MONITOR ====="

total_servers=0
healthy_servers=0
failed_servers=0

check_server() {
    local server_name="$1"
    local server_url="$2"

    total_servers=$((total_servers + 1))

    echo "Checking $server_name..."

    if curl -fsS --max-time 5 -o /dev/null "$server_url"; then
        echo "SUCCESS: $server_name is healthy"
        healthy_servers=$((healthy_servers + 1))
    else
        echo "CRITICAL: $server_name is offline"
        failed_servers=$((failed_servers + 1))
    fi

    echo "-----------------------------"
}

check_server "Web Server 1" "http://localhost:9000"
check_server "Web Server 2" "http://localhost:8080"
check_server "Web Server 3" "http://localhost:7000"

echo "===== MONITORING SUMMARY ====="
echo "Total servers: $total_servers"
echo "Healthy servers: $healthy_servers"
echo "Failed servers: $failed_servers"

if [ "$failed_servers" -gt 0 ]; then
    echo "WARNING: Server failures detected!"
    exit 1
else
    echo "SUCCESS: All servers are healthy!"
    exit 0
fi
