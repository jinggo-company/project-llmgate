# TEST_CASES.md — LLMGate 测试案例

## T-2026-00207: LLMGate F1 — Helicone 网关部署 + 通义千问/DeepSeek 适配

### AC-1: Helicone Docker Compose 部署验证

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-001 | docker-compose.yml 语法验证 | `docker compose config` | YAML 解析成功 |
| TC-002 | 部署启动 | `docker compose up -d` | 容器启动，exit 0 |
| TC-003 | 健康检查 | `curl -s http://localhost:8080/health` | HTTP 200 |

### AC-3: 通义千问/DeepSeek Provider 插件

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-004 | Qwen Provider 配置验证 | `cat providers/qwen.yaml` | 包含正确的 API 端点和模型列表 |
| TC-005 | DeepSeek Provider 配置验证 | `cat providers/deepseek.yaml` | 包含正确的 API 端点和模型列表 |

### AC-5: 智能路由 + 成本看板

| Case-ID | 描述 | 执行命令 | 预期结果 |
|---------|------|----------|----------|
| TC-006 | 路由策略配置验证 | `cat strategies/routing.yaml` | 包含 health check + failover 配置 |
| TC-007 | 成本看板页面存在 | `cat dashboard/cost-view.html` | HTML 文件有效 |
| TC-008 | 部署验证脚本 | `bash scripts/verify-deployment.sh` | 全部检查通过 |
