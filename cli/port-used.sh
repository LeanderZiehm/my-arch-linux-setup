#!/usr/bin/env bash

# Check if a port is available
check_port() {
  local port=$1
  if ss -tuln | awk '{print $5}' | grep -q ":$port\$"; then
    return 1 # Port is in use
  else
    return 0 # Port is free
  fi
}

# Show usage
usage() {
  echo "Usage: $0 <port>"
  exit 1
}

# Ensure a port number is provided
if [ $# -ne 1 ]; then
  usage
fi

PORT=$1

# Validate input is a number
if ! [[ $PORT =~ ^[0-9]+$ ]]; then
  echo "Error: Port must be a number."
  exit 1
fi

# Check main port
if check_port $PORT; then
  echo "Port $PORT is available ✅"
else
  echo "Port $PORT is in use ❌"
  echo "Checking nearby ports..."
  for offset in 1 2 3; do
    for sign in + -; do
      candidate=$((PORT))
      if [ "$sign" = "+" ]; then
        candidate=$((PORT + offset))
      else
        candidate=$((PORT - offset))
      fi
      # Only consider valid ports
      if [ $candidate -ge 1 ] && [ $candidate -le 65535 ]; then
        if check_port $candidate; then
          echo "Available port: $candidate"
        fi
      fi
    done
  done
fi
