#!/bin/bash

#collect server information
server_name=$(hostname)
current_user=$(whoami)
current_directory=$(pwd)
today=$(date)
kernel_version=$(uname -r)


#Display server information
echo "==== SERVER INFORMATION ===="
echo "Hostname: $server_name"
echo "Current user: $current_user"
echo "Current directory: $current_directory"
echo "Date: $today"
echo "Kernel Version: $kernel_version"


echo "==== END OF REPORT ===="
