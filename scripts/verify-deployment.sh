#!/bin/bash
# verify-deployment.sh — LLMGate 部署验证
set -uo pipefail

PASS=0
FAIL=0

check() {
  local desc="$1"
  shift
  if eval "$@"; then
    echo "[PASS] $desc"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc"
    FAIL=$((FAIL+1))
  fi
}

echo "=========================================="
echo " LLMGate Deployment Verification"
echo "=========================================="

check "docker-compose.yml exists" "[[ -f docker-compose.yml ]]"
check "Qwen provider config exists" "[[ -f providers/qwen.yaml ]]"
check "DeepSeek provider config exists" "[[ -f providers/deepseek.yaml ]]"
check "Routing strategy exists" "[[ -f strategies/routing.yaml ]]"
check "Cost dashboard exists" "[[ -f dashboard/cost-view.html ]]"
check ".env.example exists" "[[ -f .env.example ]]"

# Docker compose config validation
if command -v docker &>/dev/null; then
  check "docker compose config valid" "cd $PWD && docker compose config > /dev/null 2>&1"
fi

echo "=========================================="
echo " Results: $PASS passed, $FAIL failed"
echo "=========================================="

[ "$FAIL" -gt 0 ] && exit 1
exit 0
