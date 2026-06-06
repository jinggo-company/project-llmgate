#!/bin/bash
# deploy.sh — LLMGate 部署脚本
set -euo pipefail

echo "[LLMGate] Starting deployment..."
docker compose up -d
echo "[LLMGate] Waiting for services to be ready..."
sleep 30

HEALTH=$(curl -s http://localhost:8080/health 2>/dev/null || echo "unreachable")
echo "[LLMGate] Health check: $HEALTH"
echo "[LLMGate] Deployment complete."
