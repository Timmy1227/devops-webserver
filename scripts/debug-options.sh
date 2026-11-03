#!/bin/bash

set -x

echo "Starting DevOps debugging"

server="Web Server 1"

echo "Checking $server"

if curl -fsS -o /dev/null http://localhost:9000; then
    echo "SUCCESS: Server is responding"
else
    echo "CRITICAL: Server is offline"
fi

set +x

echo "Debugging completed"
