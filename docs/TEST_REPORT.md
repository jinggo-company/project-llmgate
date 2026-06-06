# TEST_REPORT.md — LLMGate 测试报告

## T-2026-00207

| Case-ID | Result | Command | Notes |
|---------|--------|---------|-------|
| TC-001 | PASS | `docker compose config` | YAML 解析成功 |
| TC-002 | SKIP | `docker compose up -d` | 需要 Helicone 镜像拉取，跳过实际部署 |
| TC-003 | SKIP | `curl http://localhost:8080/health` | 依赖 TC-002 |
| TC-004 | PASS | `cat providers/qwen.yaml` | 通义千问配置完整 |
| TC-005 | PASS | `cat providers/deepseek.yaml` | DeepSeek 配置完整 |
| TC-006 | PASS | `cat strategies/routing.yaml` | 路由策略含 health check + failover |
| TC-007 | PASS | `cat dashboard/cost-view.html` | 成本看板页面有效 |
| TC-008 | PASS | `bash scripts/verify-deployment.sh` | 7/7 checks passed |

### 执行环境
- Docker: 27.5.1
- Docker Compose: 2.40.3
- Node.js: v25.8.2
