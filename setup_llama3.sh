#!/usr/bin/env bash
set -euo pipefail
if ! command -v ollama >/dev/null 2>&1; then
  echo "Ollama is not installed or is not on PATH. Install it, then run this script again."
  exit 1
fi
echo "Pulling Llama 3 8B. This downloads several GB once."
ollama pull llama3:8b
echo "Llama 3 is ready. Start the dashboard with ./run_dashboard.sh"
