
#!/bin/bash

echo "===== DEVOPS STATE ALERT MONITOR ====="

servers=(
    "http://localhost:9000"
    "http://localhost:8080"
    "http://localhost:7000"
)

mkdir -p logs/state

log_file="logs/state-alerts.log"
failed_servers=0

for server in "${servers[@]}"
do
    port="${server##*:}"
    state_file="logs/state/server-${port}.state"

    previous_state="UNKNOWN"

    if [ -f "$state_file" ]; then
        previous_state=$(cat "$state_file")
    fi

    if curl -fsS -o /dev/null --max-time 5 "$server"; then
        current_state="UP"
    else
        current_state="DOWN"
        failed_servers=$((failed_servers + 1))
    fi

    echo "Server: $server"
    echo "Previous state: $previous_state"
    echo "Current state: $current_state"

    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    if [ "$previous_state" = "UNKNOWN" ]; then
        echo "INITIAL: Server state is $current_state"

    elif [ "$previous_state" = "UP" ] &&
         [ "$current_state" = "DOWN" ]; then

        message="$timestamp - ALERT: $server went offline"
        echo "$message" | tee -a "$log_file"

    elif [ "$previous_state" = "DOWN" ] &&
         [ "$current_state" = "UP" ]; then

        message="$timestamp - RECOVERY: $server is back online"
        echo "$message" | tee -a "$log_file"

    else
        echo "No state change detected"
    fi

    echo "$current_state" > "$state_file"
    echo "---------------------------"
done

if [ "$failed_servers" -gt 0 ]; then
    exit 1
else
    exit 0
fi
