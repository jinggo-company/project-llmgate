# project-llmgate

> LLMGate — 面向中国企业的 LLM 统一接入与观测平台（基于 Helicone）

## 状态
- **Phase:** `dev`
- **Project ID:** P-2026-00028
- **Lead Dev:** quanchen

## 概述
LLMGate 是基于 Helicone 的 LLM 统一接入网关，提供：
- Helicone Docker Compose 部署
- 通义千问（Qwen）/ DeepSeek Provider 插件
- 智能路由策略（可用性探测 + 自动降级）
- 成本看板基础版

## 本地运行
```bash
docker compose up -d
sleep 30
curl http://localhost:8080/health
```

## 项目结构
```
project-llmgate/
├── README.md
├── docs/
│   ├── TECH_STACK.md
│   ├── ARCHITECTURE.md
│   └── TEST_CASES.md
├── docker-compose.yml
├── .env.example
├── scripts/
│   ├── deploy.sh
│   └── verify-deployment.sh
├── providers/
│   ├── qwen.yaml
│   └── deepseek.yaml
├── strategies/
│   └── routing.yaml
├── dashboard/
│   └── cost-view.html
└── ci/
    ├── github-actions.yml
    └── gitlab-ci.yml
```
