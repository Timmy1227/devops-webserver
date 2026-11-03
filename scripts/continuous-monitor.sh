
#!/bin/bash

echo "===== DEVOPS CONTINUOUS MONITOR ====="
echo "Press Ctrl+C to stop monitoring"

monitor_script="/home/kali/devops/cloned-webserver/scripts/state-alert-monitor.sh"

if [ ! -f "$monitor_script" ]; then
    echo "ERROR: Monitoring script not found"
    exit 2
fi

while true
do
    echo "================================"
    echo "Monitoring started: $(date)"

    bash "$monitor_script"
    result=$?

    if [ "$result" -ne 0 ]; then
        echo "WARNING: One or more servers are offline"
    else
        echo "SUCCESS: All servers are healthy"
    fi

    echo "Next check in 10 seconds..."
    sleep 10
done
