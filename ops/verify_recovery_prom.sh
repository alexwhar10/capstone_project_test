#!/usr/bin/env bash
set -euo pipefail
# shellcheck disable=SC1091
source ops/lib.sh

load_env
require curl
require jq

log "Verifying recovery in Prometheus..."
resp="$(prom_query "$RECOVERY_QUERY")"

# Recovery query should return 1 result with value "1" OR no failure results depending on your PromQL
log "Prometheus response:"
echo "$resp" | jq .

log "If dashboards are wired, this is where the alert clears / panel turns green."