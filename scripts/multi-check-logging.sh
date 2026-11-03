
#!/bin/bash

echo "===== DEVOPS SERVER MONITOR WITH LOGGING ====="

project_dir="/home/kali/devops/cloned-webserver"
log_file="$project_dir/logs/multi-server.log"

total_servers=0
healthy_servers=0
failed_servers=0

mkdir -p "$project_dir/logs"

check_server() {
    local server_name="$1"
    local server_url="$2"
    local timestamp

    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    total_servers=$((total_servers + 1))

    echo "Checking $server_name..."

    if curl -fsS --max-time 5 -o /dev/null "$server_url"; then
        echo "$timestamp - SUCCESS: $server_name is healthy" | tee -a "$log_file"
        healthy_servers=$((healthy_servers + 1))
    else
        echo "$timestamp - CRITICAL: $server_name is offline" | tee -a "$log_file"
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
