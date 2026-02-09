#!/usr/bin/env bash
set -euo pipefail

echo "=== CAPSTONE DEMO: Detect -> Fix -> Verify ==="

if ops/detect_failure_prom.sh; then
  echo "No failure right now. (For demo, intentionally break the job/workload first.)"
  exit 0
fi

ops/fix_rerun_job.sh
ops/verify_recovery_prom.sh

echo "=== Demo complete ==="