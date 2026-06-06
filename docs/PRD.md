# LLMGate — PRD v1

## 需求概述
LLMGate 是基于 Helicone 的 LLM 网关平台，提供多 Provider 适配、智能路由降级和成本看板能力。

## 验收标准 (AC)
- AC-1: Helicone Docker Compose 部署验证
- AC-3: 通义千问/DeepSeek Provider 插件开发
- AC-5: 智能路由策略（可用性探测 + 自动降级）+ 成本看板基础版

## 测试场景

### 场景 1：网关部署验证
1. docker compose up -d 启动全栈服务
2. curl http://localhost:8080/health 返回 OK

### 场景 2：路由降级
1. 配置 qwen 为优先 provider (权重 70)
2. 模拟 qwen 不可用，验证自动降级到 deepseek
