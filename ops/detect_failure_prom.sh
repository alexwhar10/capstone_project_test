#!/usr/bin/env bash
set -euo pipefail
# shellcheck disable=SC1091
source ops/lib.sh

load_env
require curl
require jq

log "Checking Prometheus for failure signal..."
resp="$(prom_query "$FAIL_QUERY")"

# If any result exists, treat as failure
count="$(echo "$resp" | jq '.data.result | length')"
if [[ "$count" -gt 0 ]]; then
  log "FAILURE DETECTED (result count=$count)"
  echo "$resp" | jq .
  exit 1
else
  log "No failure detected."
fi