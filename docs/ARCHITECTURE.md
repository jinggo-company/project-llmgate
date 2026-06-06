# ARCHITECTURE.md — LLMGate 架构设计

## 模块概览

```
┌─────────────────────────────────────────────────┐
│                  LLMGate Gateway                 │
├────────────┬──────────────┬─────────────────────┤
│  Helicone  │  Provider    │  Routing Engine     │
│  Proxy     │  Plugins     │                     │
│            │              │                     │
│ • Request  │ • Qwen       │ • Health check      │
│   routing  │   adapter    │   (every 30s)       │
│ • Response │ • DeepSeek   │ • Auto failover     │
│   caching  │   adapter    │ • Weighted routing  │
│ • Rate     │ • Custom     │ • Cost optimization │
│   limiting │   plugins    │                     │
├────────────┴──────────────┴─────────────────────┤
│                  Infrastructure                  │
├─────────────┬──────────────┬─────────────────────┤
│  PostgreSQL │  ClickHouse  │  Cost Dashboard     │
│             │              │                     │
│ • Config    │ • Request    │ • Token usage       │
│ • Users     │   logs       │ • Cost per model    │
│ • API keys  │ • Analytics  │ • Daily spend       │
└─────────────┴──────────────┴─────────────────────┘
```

## PRD AC 映射

| AC | 架构覆盖 | 实现位置 |
|----|----------|----------|
| AC-1 | Helicone Docker Compose 部署 | docker-compose.yml, scripts/deploy.sh |
| AC-3 | 通义千问/DeepSeek Provider 插件 | providers/qwen.yaml, providers/deepseek.yaml |
| AC-5 | 智能路由 + 成本看板 | strategies/routing.yaml, dashboard/cost-view.html |
