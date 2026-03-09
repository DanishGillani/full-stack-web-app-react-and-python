#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "==> Clearing all caches..."

# ── Python caches ──
echo "    Removing Python __pycache__ directories..."
find "$PROJECT_ROOT/server" -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find "$PROJECT_ROOT/server" -name "*.pyc" -delete 2>/dev/null || true
find "$PROJECT_ROOT/server" -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true

# ── Node caches ──
echo "    Removing node_modules..."
rm -rf "$PROJECT_ROOT/client/node_modules"

echo "    Removing Vite cache..."
rm -rf "$PROJECT_ROOT/client/node_modules/.vite" 2>/dev/null || true

echo "    Removing build output..."
rm -rf "$PROJECT_ROOT/client/dist"

echo ""
echo "==> All caches cleared."
echo "    Run the following to reinstall:"
echo "      cd client && npm install"
echo "      cd server && pip install -r requirements.txt"
