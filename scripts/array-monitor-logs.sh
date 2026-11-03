#!/bin/bash

echo "===== DEVOPS ARRAY MONITOR WITH LOGGING ====="

project_dir="$(cd "$(dirname "$0")" && pwd)"
log_file="$project_dir/logs/array-monitor.log"

mkdir -p "$project_dir/logs"

servers=(
    "http://localhost:9000"
    "http://localhost:8080"
    "http://localhost:7000"
)

healthy=0
failed=0

for server in "${servers[@]}"
do
    timestamp=$(date "+%F %T")

    if curl -fs --max-time 5 -o /dev/null "$server"; then
        message="SUCCESS: $server is responding"
        healthy=$((healthy + 1))
    else
        message="CRITICAL: $server is not responding"
        failed=$((failed + 1))
    fi

    echo "$timestamp - $message" | tee -a "$log_file"
done

echo "===== MONITORING SUMMARY ====="
echo "Total servers: ${#servers[@]}"
echo "Healthy servers: $healthy"
echo "Failed servers: $failed"

if [ "$failed" -gt 0 ]; then
    exit 1
else
    exit 0
fi
