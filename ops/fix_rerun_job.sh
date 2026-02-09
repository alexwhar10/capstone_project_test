#!/usr/bin/env bash
set -euo pipefail
# shellcheck disable=SC1091
source ops/lib.sh

load_env
require kubectl

log "Re-running job: $JOB_NAME in namespace: $NAMESPACE"
kubectl -n "$NAMESPACE" delete job "$JOB_NAME" --ignore-not-found
kubectl -n "$NAMESPACE" apply -f k8s/jobs/"$JOB_NAME".yaml

log "Waiting for job to complete..."
kubectl -n "$NAMESPACE" wait --for=condition=complete job/"$JOB_NAME" --timeout=180s

log "Job completed successfully."