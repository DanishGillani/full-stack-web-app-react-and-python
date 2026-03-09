#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "==> Starting Full-Stack Application..."

# ── Kill any existing processes on our ports ──
"$PROJECT_ROOT/scripts/kill-ports.sh" 2>/dev/null || true

# ── Start Flask backend ──
echo "==> Starting Flask server on port 5001..."
cd "$PROJECT_ROOT/server"

if [ ! -d "venv" ]; then
    echo "==> Creating Python virtual environment..."
    python3 -m venv venv
fi

source venv/bin/activate
pip install -q -r requirements.txt

python server.py &
FLASK_PID=$!
echo "    Flask PID: $FLASK_PID"

# ── Start Vite dev server ──
echo "==> Starting Vite dev server on port 5173..."
cd "$PROJECT_ROOT/client"

if [ ! -d "node_modules" ]; then
    echo "==> Installing npm dependencies..."
    npm install
fi

npm run dev &
VITE_PID=$!
echo "    Vite PID: $VITE_PID"

echo ""
echo "========================================="
echo "  App running at:"
echo "  Frontend:  http://localhost:5173"
echo "  Backend:   http://localhost:5001"
echo "========================================="
echo ""
echo "Press Ctrl+C to stop all servers."

# ── Cleanup on exit ──
cleanup() {
    echo ""
    echo "==> Shutting down servers..."
    kill "$FLASK_PID" 2>/dev/null || true
    kill "$VITE_PID" 2>/dev/null || true
    echo "==> Done."
}

trap cleanup EXIT INT TERM

wait
