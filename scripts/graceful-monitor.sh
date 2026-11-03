#!/bin/bash

echo "===== DEVOPS GRACEFUL MONITOR ====="

cleanup() {
    echo
    echo "Stopping DevOps monitoring..."
    echo "Monitoring stopped safely."
    exit 0
}

trap cleanup INT TERM

while true
do
    echo
    echo "Monitoring started: $(date)"

    ./scripts/state-alert-monitor.sh

    result=$?

    if [ "$result" -eq 0 ]; then
        echo "SUCCESS: All servers are healthy"
    else
        echo "WARNING: One or more servers are offline"
    fi

    echo "Next check in 10 seconds..."
    sleep 10
done
