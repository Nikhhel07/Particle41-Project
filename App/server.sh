#!/bin/bash

PORT=8080

while true; do
  {
    # Read request (ignore it)
    while read -r line && [[ "$line" != $'\r' ]]; do :; done

    # Get IP (from Docker logs, best we can do with netcat)
    IP=$(echo "$SOCAT_PEERADDR" || echo "unknown")

    # Get timestamp
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Output HTTP response
    RESPONSE=$(cat <<EOF
HTTP/1.1 200 OK
Content-Type: application/json

{
  "timestamp": "$TIMESTAMP",
  "ip": "$IP"
}
EOF
)
    echo "$RESPONSE"
  } | nc -l -p $PORT -q 1;
done
