#!/bin/bash
# tests/unit/test-configs.sh — Unit tests for LLMGate configs and scripts
set -uo pipefail

PASS=0
FAIL=0
PROJ_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

check() {
  local desc="$1"
  shift
  if eval "$@" >/dev/null 2>&1; then
    echo "[PASS] $desc"
    PASS=$((PASS+1))
  else
    echo "[FAIL] $desc"
    FAIL=$((FAIL+1))
  fi
}

echo "=== LLMGate Unit Tests: Script Validation ==="

# deploy.sh
check "deploy.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/deploy.sh ]]"
check "deploy.sh has shebang" "head -1 $PROJ_ROOT/scripts/deploy.sh | grep -q '^#!/bin/bash'"
check "deploy.sh has set -euo pipefail" "grep -q 'set -euo pipefail' $PROJ_ROOT/scripts/deploy.sh"
check "deploy.sh uses docker compose" "grep -q 'docker compose' $PROJ_ROOT/scripts/deploy.sh"
check "deploy.sh checks health endpoint" "grep -q '/health' $PROJ_ROOT/scripts/deploy.sh"

# verify-deployment.sh
check "verify-deployment.sh exists and is executable" "[[ -x $PROJ_ROOT/scripts/verify-deployment.sh ]]"
check "verify-deployment.sh has shebang" "head -1 $PROJ_ROOT/scripts/verify-deployment.sh | grep -q '^#!/bin/bash'"
check "verify-deployment.sh checks provider configs" "grep -q 'providers/qwen.yaml' $PROJ_ROOT/scripts/verify-deployment.sh"
check "verify-deployment.sh checks routing strategy" "grep -q 'strategies/routing.yaml' $PROJ_ROOT/scripts/verify-deployment.sh"

echo ""
echo "=== LLMGate Unit Tests: YAML Config Validation ==="

# docker-compose.yml
check "docker-compose.yml exists" "[[ -f $PROJ_ROOT/docker-compose.yml ]]"
check "docker-compose.yml is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/docker-compose.yml\"))' 2>/dev/null"
check "docker-compose.yml has helicone-gateway service" "grep -q 'helicone-gateway' $PROJ_ROOT/docker-compose.yml"
check "docker-compose.yml has postgres service" "grep -q 'postgres:' $PROJ_ROOT/docker-compose.yml"
check "docker-compose.yml has redis service" "grep -q 'redis:' $PROJ_ROOT/docker-compose.yml"
check "docker-compose.yml has clickhouse service" "grep -q 'clickhouse:' $PROJ_ROOT/docker-compose.yml"
check "docker-compose.yml has healthcheck for gateway" "grep -q 'healthcheck' $PROJ_ROOT/docker-compose.yml"

# Provider configs
check "Qwen provider config exists" "[[ -f $PROJ_ROOT/providers/qwen.yaml ]]"
check "Qwen provider config is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/providers/qwen.yaml\"))' 2>/dev/null"
check "DeepSeek provider config exists" "[[ -f $PROJ_ROOT/providers/deepseek.yaml ]]"
check "DeepSeek provider config is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/providers/deepseek.yaml\"))' 2>/dev/null"

# Routing strategy
check "Routing strategy exists" "[[ -f $PROJ_ROOT/strategies/routing.yaml ]]"
check "Routing strategy is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/strategies/routing.yaml\"))' 2>/dev/null"

# CI configs
check "github-actions.yml exists" "[[ -f $PROJ_ROOT/ci/github-actions.yml ]]"
check "github-actions.yml is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/ci/github-actions.yml\"))' 2>/dev/null"
check "gitlab-ci.yml exists" "[[ -f $PROJ_ROOT/ci/gitlab-ci.yml ]]"
check "gitlab-ci.yml is valid YAML" "python3 -c 'import yaml; yaml.safe_load(open(\"$PROJ_ROOT/ci/gitlab-ci.yml\"))' 2>/dev/null"

# .env.example
check ".env.example exists" "[[ -f $PROJ_ROOT/.env.example ]]"
check ".env.example has required env vars" "grep -q 'HELICONE' $PROJ_ROOT/.env.example || grep -q 'API_KEY' $PROJ_ROOT/.env.example || grep -q 'DATABASE' $PROJ_ROOT/.env.example"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
exit 0
