# Full-Stack Web App — React & Python

A full-stack web application template using **React 19**, **TypeScript**, **Vite**, and **Flask**.

## Project Structure

```
├── client/                  # Frontend (React + TypeScript + Vite)
│   ├── src/
│   │   ├── components/
│   │   │   ├── App.tsx
│   │   │   └── App.test.tsx
│   │   ├── main.tsx
│   │   ├── setup-tests.ts
│   │   └── vite-env.d.ts
│   ├── index.html
│   ├── package.json
│   ├── tsconfig.json
│   ├── vite.config.ts
│   ├── eslint.config.js
│   └── .prettierrc
├── server/                  # Backend (Flask + Python)
│   ├── app/
│   │   ├── __init__.py      # App factory
│   │   └── routes.py        # API routes
│   ├── tests/
│   │   ├── conftest.py      # Pytest fixtures
│   │   └── test_routes.py   # Route tests
│   ├── server.py            # Entry point
│   ├── requirements.txt
│   ├── pyproject.toml       # Ruff + pytest config
│   ├── .env                 # Local env vars (git-ignored)
│   └── .env.example         # Template for env vars
├── scripts/                 # Utility scripts
│   ├── start.sh             # Start all servers
│   ├── kill-ports.sh        # Kill processes on ports 5001/5173
│   └── clear-cache.sh       # Clear all caches and build artifacts
├── .gitignore
├── LICENSE
└── README.md
```

## Prerequisites

- **Python 3.10+** — [Install Python](https://www.python.org/downloads/)
- **Node.js 18+** — [Install Node.js](https://nodejs.org/)
- **npm 9+** — Comes with Node.js

## Quick Start

The fastest way to get running:

```bash
# Start everything (installs deps automatically)
./scripts/start.sh
```

This starts:
- **Frontend** at [http://localhost:5173](http://localhost:5173) (Vite dev server with HMR)
- **Backend** at [http://localhost:5001](http://localhost:5001) (Flask API server)

API calls from the frontend are automatically proxied to the backend.

## Manual Setup

### Backend

```bash
cd server

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate        # macOS/Linux
# venv\Scripts\activate         # Windows

# Install dependencies
pip install -r requirements.txt

# Set up environment variables
cp .env.example .env            # Then edit .env as needed

# Start the server
python server.py
```

### Frontend

```bash
cd client

# Install dependencies
npm install

# Start dev server (with hot reload)
npm run dev
```

## Available Commands

### Frontend (client/)

| Command              | Description                         |
|----------------------|-------------------------------------|
| `npm run dev`        | Start Vite dev server with HMR      |
| `npm run build`      | Type-check and build for production  |
| `npm run preview`    | Preview production build locally     |
| `npm run lint`       | Run ESLint and auto-fix issues       |
| `npm run format`     | Format code with Prettier            |
| `npm test`           | Run tests once                       |
| `npm run test:watch` | Run tests in watch mode              |

### Backend (server/)

| Command                   | Description                      |
|---------------------------|----------------------------------|
| `python server.py`        | Start Flask server               |
| `pytest`                  | Run all tests                    |
| `pytest -v`               | Run tests with verbose output    |
| `ruff check .`            | Lint Python code                 |
| `ruff check . --fix`      | Lint and auto-fix Python code    |
| `ruff format .`           | Format Python code               |

### Utility Scripts (scripts/)

| Command                    | Description                                  |
|----------------------------|----------------------------------------------|
| `./scripts/start.sh`      | Start both frontend and backend servers       |
| `./scripts/kill-ports.sh` | Kill all processes on ports 5001 and 5173     |
| `./scripts/clear-cache.sh`| Clear all caches, node_modules, and build output |

### All Bash Commands

```bash
# ── Setup ──
cd client && npm install                    # Install frontend dependencies
cd server && python3 -m venv venv           # Create Python virtual environment
source server/venv/bin/activate             # Activate virtual environment (macOS/Linux)
pip install -r server/requirements.txt      # Install backend dependencies
cp server/.env.example server/.env          # Set up environment variables

# ── Development ──
./scripts/start.sh                          # Start both servers at once
cd client && npm run dev                    # Start Vite dev server (port 5173)
cd server && python server.py               # Start Flask server (port 5001)

# ── Build ──
cd client && npm run build                  # Type-check and build for production
cd client && npm run preview                # Preview production build locally

# ── Testing ──
cd client && npm test                       # Run frontend tests once
cd client && npm run test:watch             # Run frontend tests in watch mode
cd client && npm run test:coverage          # Run frontend tests with coverage
cd server && pytest                         # Run backend tests
cd server && pytest -v                      # Run backend tests (verbose)

# ── Linting & Formatting ──
cd client && npm run lint                   # Lint frontend code (ESLint, auto-fix)
cd client && npm run format                 # Format frontend code (Prettier)
cd server && ruff check .                   # Lint backend code
cd server && ruff check . --fix             # Lint and auto-fix backend code
cd server && ruff format .                  # Format backend code

# ── Utilities ──
./scripts/kill-ports.sh                     # Kill processes on ports 5001/5173
./scripts/clear-cache.sh                    # Clear all caches and build artifacts
```

## Environment Variables

Server environment variables are managed via the `server/.env` file. See `server/.env.example` for all available options:

| Variable          | Default                    | Description                        |
|-------------------|----------------------------|------------------------------------|
| `FLASK_DEBUG`     | `false`                    | Enable Flask debug mode            |
| `PORT`            | `5001`                     | Flask server port                  |
| `SECRET_KEY`      | `dev-secret-...`           | Flask secret key (change in prod!) |
| `ALLOWED_ORIGINS` | `http://localhost:5173`    | CORS allowed origins               |

## Architecture

### Development Mode

```
Browser → Vite Dev Server (:5173) ─── /api/* proxy ──→ Flask (:5001)
              │
              └── HMR (hot module replacement for instant updates)
```

### Production Mode

```bash
cd client && npm run build      # Outputs to client/dist/
cd server && python server.py   # Flask serves client/dist/ as static files
```

```
Browser → Flask (:5001) ─── serves ──→ client/dist/index.html
              │
              └── /api/* ──→ Flask route handlers
```

## Tech Stack

| Layer      | Technology          | Purpose                     |
|------------|---------------------|-----------------------------|
| Frontend   | React 19            | UI library                  |
| Language   | TypeScript 5.7      | Type-safe JavaScript        |
| Bundler    | Vite 6              | Fast dev server and bundler |
| Backend    | Flask 3.1           | Python web framework        |
| Linting    | ESLint 9 + Ruff     | JS/TS and Python linting    |
| Formatting | Prettier + Ruff     | Code formatting             |
| Testing    | Vitest + pytest     | Frontend and backend tests  |

## License

MIT
