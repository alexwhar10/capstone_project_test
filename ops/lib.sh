#!/usr/bin/env bash
set -euo pipefail

load_env() {
  if [[ -f "ops/.env" ]]; then
    # shellcheck disable=SC1091
    source ops/.env
  fi
}

log() { printf '[%s] %s\n' "$(date -Is)" "$*"; }

require() {
  command -v "$1" >/dev/null 2>&1 || { echo "Missing dependency: $1"; exit 2; }
}

prom_query() {
  local query="$1"
  curl -sS --get "$PROM_URL/api/v1/query" --data-urlencode "query=$query"
}