#!/bin/bash

echo "===== DEVOPS RECOVERY MONITOR ====="

server_url="http://localhost:9000"
# state_file="logs/server9000.state"
# event_log="logs/recovery-monitor.log"
state_file="/home/kali/devops/cloned-webserver/logs/server9000.state"
event_log="/home/kali/devops/cloned-webserver/logs/recovery-monitor.log"


# mkdir -p logs
mkdir -p /home/kali/devops/cloned-webserver/logs

# Read the previous state
if [ -f "$state_file" ]; then
    previous_state=$(cat "$state_file")
else
    previous_state="UNKNOWN"
fi

timestamp=$(date "+%F %T")

# Check the current server state
if curl -fs -o /dev/null "$server_url"; then
    current_state="UP"
else
    current_state="DOWN"
fi

echo "Previous state: $previous_state"
echo "Current state: $current_state"

# Detect changes
if [ "$previous_state" = "UP" ] && [ "$current_state" = "DOWN" ]; then
    echo "$timestamp - ALERT: Server went offline" | tee -a "$event_log"

elif [ "$previous_state" = "DOWN" ] && [ "$current_state" = "UP" ]; then
    echo "$timestamp - RECOVERY: Server is back online" | tee -a "$event_log"

elif [ "$previous_state" = "UNKNOWN" ]; then
    echo "$timestamp - INITIAL: Server is $current_state" | tee -a "$event_log"

else
    echo "No server status change detected"
fi

# Save current state for next execution
echo "$current_state" > "$state_file"

if [ "$current_state" = "UP" ]; then
    exit 0
else
    exit 1
fi
