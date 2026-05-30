# Agent 学习路线

## 核心概念

### 什么是 AI 应用工程师？
- 传统后端开发 **融入** 大模型能力的角色
- 除常规后端能力（并发、一致性、分布式）外，还需理解 LLM 的调用方式与特性

### 什么是 Agent？
Agent 是能**思考、调用工具、执行任务**的程序系统，核心要素：

| 组件 | 角色 | 说明 |
|:----|:----|:------|
| 🧠 **大模型（LLM）** | 大脑 | 理解任务、推理、决策 |
| 🛠️ **工具（Tools）** | 手脚 | 调用 API、查询数据库、执行代码 |
| 💾 **记忆（Memory）** | 记忆 | 短期（对话上下文）+ 长期（向量数据库） |
| 📋 **规划（Planning）** | 规划 | 任务拆解、子任务编排 |

---

## 学习路线概览（共 3~4 阶段）

```
阶段一：AI 扫盲 + 大模型基础认知
    ↓
阶段二：AI 应用基础（提示工程 → Function Calling → RAG）
    ↓
阶段三：Agent 进阶（多智能体、工具编排、记忆系统）
    ↓
阶段四：生产级 Agent 工程（稳定性、观测、评估）
```

---

## 阶段一：AI 扫盲 + 大模型基础认知

### 核心知识点

| 概念 | 说明 |
|:----|:------|
| **Token** | LLM 输入输出的基本单位，计费和上下文长度的基础 |
| **上下文窗口（Context Window）** | 模型一次能处理的 Token 上限 |
| **温度（Temperature）** | 控制输出随机性，低=确定/保守，高=创造/发散 |
| **Top-p（核采样）** | 累积概率阈值采样，与 Temperature 配合使用 |
| **幻觉（Hallucination）** | LLM 生成不实内容的倾向，需要 RAG/验证机制缓解 |
| **提示工程（Prompt Engineering）** | 设计高效 Prompt 引导模型输出，是 Agent 的基础技能 |

### 学习资料
- [OpenAI Prompt Engineering Guide](https://platform.openai.com/docs/guides/prompt-engineering)
- Anthropic Prompt Engineering（根据具体使用的模型选择）

---

## 阶段二：AI 应用基础

### 1. 提示工程进阶：结构化输出
- 重点从"写 Prompt"转向**接口协议控制**
- 控制大模型输出**结构化 JSON**（JSON Mode / Structured Output）
- 定义清晰的输出 Schema，便于下游程序解析和处理

### 2. Function Calling（工具调用）
- 让大模型根据用户意图**调用 API 或执行函数**
- 核心流程：定义工具 → 模型决策调用 → 执行工具 → 返回结果给模型
- 这是 Agent 调用外部世界的**基础能力**

### 3. RAG（检索增强生成）
> Agent 技术栈中**应用最广**的技术

#### RAG 解决什么问题
| 问题 | 说明 |
|:----|:------|
| 私有数据缺失 | 模型训练数据不包含企业/个人私有知识 |
| 幻觉 | 模型可能编造事实，RAG 提供事实依据 |
| 无法实时更新 | 模型知识有截止日期，RAG 可检索最新信息 |

#### RAG 基本流程
```
用户提问 → 检索（向量数据库/搜索引擎）→ 获取相关文档 → 拼接 Prompt → LLM 生成答案
```

---

## 阶段一自测：做一个小项目

> **知识问答 Agent**

- 上传文档
- 将文档**向量化**存入向量数据库
- 用户提问时检索相关片段
- 大模型基于检索到的文档内容提取回答

---

## 阶段三：Agent 进阶（后续课程）

- 多智能体系统（Multi-Agent）
- Agent 的评估与测试
- 记忆系统设计（短期记忆、长期记忆、持久化）
- 复杂任务规划与拆解

## 阶段四：生产级 Agent 工程（后续课程）

- Agent 稳定性
- Agent 可观测性（Logging、Tracing）
- Agent 评估体系（Eval）
- 安全与对齐

---

> 本路线根据课程笔记整理，后续将分阶段推出详细课程内容。

---

## 📺 B站视频教程

### 阶段一：AI 扫盲 + 大模型基础
| 标题 | 链接 | 说明 |
|:----|:----|:------|
| 【全748集】AI大模型零基础全套教程（2026最新版） | [BV1xfBkB4Etb](https://www.bilibili.com/video/BV1xfBkB4Etb/) | Python→Prompt→Transformer→RAG→Agent→微调，一站到底 |
| AI应用开发工程师四大核心能力 | [BV1WnV46DEV4](https://www.bilibili.com/video/BV1WnV46DEV4/) | 了解AI应用工程师需要什么能力 |

### 阶段二：RAG 专题
| 标题 | 链接 | 说明 |
|:----|:----|:------|
| 【强烈推荐】2025最新最全RAG教程 | [BV1jQEwzwEDU](https://www.bilibili.com/video/BV1jQEwzwEDU/) | **首选**：原理→LangChain→DeepSeek→LlamaIndex→GraphRAG |
| 【B站首推】RAG入门到精通实战 | [BV1hccSeJEUD](https://www.bilibili.com/video/BV1hccSeJEUD/) | 40+小节，3个企业级实战项目 |
| LangChain入门到精通 + RAG + Agent | [BV1pfuFzLEiv](https://www.bilibili.com/video/BV1pfuFzLEiv/) | LangChain+LangGraph生态，侧重Agent+RAG结合 |
| 翻遍B站讲的最好的RAG教程 | [BV1nC1rBPEJ8](https://www.bilibili.com/video/BV1nC1rBPEJ8/) | 零基础入门，通俗易懂 |
| 【全748集】AI智能体搭建教程 | [BV1CXfRBrEdZ](https://www.bilibili.com/video/BV1CXfRBrEdZ/) | LangChain、LangGraph、AutoGen、CrewAI全框架 |

### 阶段三：Agent 开发
| 标题 | 链接 | 说明 |
|:----|:----|:------|
| 【2026最新】全B站最详细AI Agent开发教程 | [BV1zWQFBtEAn](https://www.bilibili.com/video/BV1zWQFBtEAn/) | 从零搭建企业级Agent |
| 【如何成为Agent工程师】2026最强AI智能体教程 | [BV1P6PmzKEt5](https://www.bilibili.com/video/BV1P6PmzKEt5/) | 大模型基础→架构设计→工具调用→多智能体 |
| 【2026最新】12个Agent实战项目 | [BV1sNFSzAExU](https://www.bilibili.com/video/BV1sNFSzAExU/) | 12个项目从环境搭建到Docker部署 |

---

## 🐙 GitHub 开源项目

### 系统学习型
| 仓库 | Stars | 说明 |
|:----|:----:|:------|
| [rag-mastery-hub](https://github.com/KlementMultiverse/rag-mastery-hub) | ⭐ | **143个文件，70+技术栈，6级进阶**：基础RAG→高级RAG→多Agent→生产部署 |
| [awesome-llm-apps](https://github.com/Shubhamsaboo/awesome-llm-apps) | ⭐35k+ | 75+ Agent蓝图，含RAG模式、多Agent、MCP协议 |
| [agents-towards-production](https://github.com/NirDiamant/agents-towards-production) | ⭐ | **生产级Agent完整教程**：工具集成→RAG→记忆系统→多Agent→部署 |
| [production-agentic-rag-course](https://github.com/jamwithai/production-agentic-rag-course) | ⭐ | **7周生产级RAG课程**：FastAPI→PostgreSQL→Airflow→LangGraph |

### 动手实战型
| 仓库 | 说明 |
|:----|:------|
| [rag-agents-workshop](https://github.com/alexeygrigorev/rag-agents-workshop) | 从0开始：基础RAG → Agentic RAG → Agentic Search |
| [agentic-rag-for-dummies](https://github.com/GiovanniPasq/agentic-rag-for-dummies) | LangGraph Agentic RAG，模块化架构，可切换任意模型 |
| [genai-agent-hackathon-cairo-2025](https://github.com/stakpak/genai-agent-hackathon-cairo-2025) | 两个Workshop：RAG+工具调用 / 从0写Coding Agent |
| [BilibiliAgent](https://github.com/linteng0516/BilibiliAgent) | 基于B站视频字幕的多轮对话RAG系统，有完整源码 |

---

## 📌 推荐学习顺序

```
B站教程：
  ① 零基础扫盲 → BV1xfBkB4Etb（AI大模型全套）的前半部分
  ② RAG 入门  → BV1jQEwzwEDU（2025最全RAG教程）
  ③ Agent 实战 → BV1zWQFBtEAn（AI Agent开发教程）
  
GitHub 配合：
  ① 边学边练  → rag-mastery-hub（从Level 1开始）
  ② 深入生产  → agents-towards-production（生产级能力）
  ③ 项目实战  → awesome-llm-apps（参考75+蓝图）
```
