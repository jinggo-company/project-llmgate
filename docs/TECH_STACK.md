# TECH_STACK.md — LLMGate 技术栈

## 核心技术

| 组件 | 版本 | 说明 |
|------|------|------|
| Helicone | 1.x+ | LLM 观测与代理网关（核心） |
| Docker Compose | 2.20+ | 容器编排部署 |
| PostgreSQL | 15 | Helicone 数据存储 |
| Redis | 7 | 缓存与速率限制 |
| ClickHouse | 24.x | 日志分析与成本统计 |
| Node.js | 20.x | Provider 插件与路由策略 |

## Provider 适配

### 通义千问（Qwen）
- API 格式: OpenAI 兼容
- Base URL: `https://dashscope.aliyuncs.com/compatible-mode/v1`
- 模型: qwen-turbo, qwen-plus, qwen-max

### DeepSeek
- API 格式: OpenAI 兼容
- Base URL: `https://api.deepseek.com/v1`
- 模型: deepseek-chat, deepseek-reasoner

## 智能路由

- 可用性探测: HTTP health check 每 30s
- 降级策略: 主 Provider 不可用时自动切换
- 路由配置: YAML 格式，支持权重分配
