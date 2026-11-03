
#!/bin/bash

echo "===== DEVOPS MULTI-SERVER CHECK ====="

check_server() {
    server_name="$1"
    server_url="$2"

    echo "Checking $server_name..."

    if curl -fsS --max-time 5 -o /dev/null "$server_url"; then
        echo "SUCCESS: $server_name is responding"
    else
        echo "CRITICAL: $server_name is offline"
    fi

    echo "--------------------------------"
}

check_server "Web Server 1" "http://localhost:9000"
check_server "Web Server 2" "http://localhost:8080"
check_server "Web Server 3" "http://localhost:7000"

echo "===== MONITORING COMPLETE ====="
