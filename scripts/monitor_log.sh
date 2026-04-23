#!/bin/bash

LOG_FILE="/var/log/apache2/access.log"
MAX_SIZE=$((1024*1024*1024))   # 1GB
JENKINS_URL="http://localhost:8080/job/upload-accesslog-to-s3/build"

FILE_SIZE=$(stat -c%s "$LOG_FILE")

echo "Current log size: $FILE_SIZE bytes"

if [ $FILE_SIZE -ge $MAX_SIZE ]; then
    echo "Log file exceeded 1GB. Triggering Jenkins job..."
    curl -X POST $JENKINS_URL
else
    echo "Log file size is under limit."
fi