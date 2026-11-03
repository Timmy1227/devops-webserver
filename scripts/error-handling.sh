#!/bin/bash

set +e

echo "Starting DevOps automation"

echo "Checking project directory"
pwd

echo "Checking a file that does not exist"
ls missing-file.txt

echo "Automation completed successfully"
