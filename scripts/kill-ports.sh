#!/usr/bin/env bash
set -euo pipefail

PORTS=(5001 5173)

echo "==> Killing processes on ports: ${PORTS[*]}"

for PORT in "${PORTS[@]}"; do
    PIDS=$(lsof -ti :"$PORT" 2>/dev/null || true)
    if [ -n "$PIDS" ]; then
        echo "    Killing PID(s) on port $PORT: $PIDS"
        echo "$PIDS" | xargs kill -9 2>/dev/null || true
    else
        echo "    Port $PORT is free"
    fi
done

echo "==> Done."
