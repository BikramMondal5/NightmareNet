#!/bin/bash

# --- Color Definitions ---
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}[System] Starting NightmareNet local development environment...${NC}"

# --- Process Lifecycle Management ---
cleanup() {
    echo -e "\n${RED}[System] Shutting down servers gracefully...${NC}"
    kill 0
    exit 0
}
trap cleanup SIGINT

# --- Boot API (Uvicorn ASGI Server) ---
echo -e "${CYAN}[API] Starting Uvicorn backend server...${NC}"
uvicorn nightmarenet.api.app:app --reload --host 127.0.0.1 --port 8000 | sed -e 's/^/[API] /' &

# --- Boot Frontend (Next.js) ---
echo -e "${YELLOW}[Frontend] Starting Next.js development server...${NC}"
cd frontend && npm run dev | sed -e 's/^/[Frontend] /' &

wait