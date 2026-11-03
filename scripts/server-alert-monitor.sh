
#!/bin/bash

echo "===== DEVOPS SERVER ALERT MONITOR ====="

servers=(
    "http://localhost:9000"
    "http://localhost:8080"
    "http://localhost:7000"
)

log_file="logs/server-alerts.log"

mkdir -p logs

total_servers=0
healthy_servers=0
failed_servers=0

for server in "${servers[@]}"
do
    total_servers=$((total_servers + 1))

    echo "Checking $server ..."

    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    if curl -fsS -o /dev/null --max-time 5 "$server"; then
        echo "SUCCESS: $server is healthy"
        healthy_servers=$((healthy_servers + 1))
    else
        message="$timestamp - CRITICAL: $server is offline"
        echo "$message" | tee -a "$log_file"
        failed_servers=$((failed_servers + 1))
    fi

    echo "---------------------------"
done

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
