# 12 — Cache 深入与结构化编程（W19）
## Memory Hierarchy: Caches Deep Dive & Structured Programming

---

## 1. Cache 深入 Caches Deep Dive

> 前置知识见 [[计算机笔记/05-存储系统\|05-存储系统]]（Cache 基本概念、3C Miss、写策略）

### 1.1 Cache 组织方式详解

#### 直接映射 Direct Mapped Cache

```
内存地址 = Tag | Index | Offset

例：64KB Cache，每行 64 字节，地址 32 位：
  Offset = log₂(64) = 6 位（行内偏移）
  Index  = log₂(64KB/64) = log₂(1024) = 10 位（行号）
  Tag    = 32 - 6 - 10 = 16 位（标记）

┌──────────┬──────────┬──────────┐
│  Tag     │  Index   │  Offset  │
│  16 位   │  10 位   │  6 位    │
└──────────┴──────────┴──────────┘

Index → 找到 Cache 行
Tag  → 检查是否匹配（有效位也要为 1）
Offset → 找到行内的具体字节
```

**冲突 Miss 场景**：
```
地址 A 和地址 B 的 Index 相同但 Tag 不同 → 互相踢出
如果程序交替访问 A 和 B → 每次都是 Miss → 冲突 Miss 爆炸
```

#### 组相联 Set Associative Cache

```
N 路组相联 = 每组有 N 行

2 路组相联：
┌─────┬──────┬──────┐
│ Set │ Way0 │ Way1 │
├─────┼──────┼──────┤
│  0  │ TagA │ TagB │
│  1  │ TagC │ TagD │
│ ... │ ...  │ ...  │
│  N  │ TagX │ TagY │
└─────┴──────┴──────┘

地址：Tag | Index | Offset
Index 选组（set），组内对比所有 Way 的 Tag

直接映射 = 1 路组相联
全相联   = 全部行在一个组里
```

#### 三种映射对比

| 方式 | 一个地址能放的位置 | 查找速度 | 冲突率 |
|:-----|:------------------|:---------|:-------|
| 直接映射 | 1 个位置 | 最快 | 最高 |
| N 路组相联 | N 个位置 | 较快 | 较低 |
| 全相联 | 任意位置 | 最慢（全搜索）| 最低 |

**现代 CPU 通常**：L1 Cache: 8 路组相联, L2 Cache: 16 路组相联

#### 替换策略 Replacement Policy

组相联或全相联中，新数据进来需要**踢出**某一行：

| 策略 | 说明 | 效果 |
|:-----|:-----|:-----|
| **LRU** (Least Recently Used) | 踢出最久没用过的 | 好，但复杂 |
| **FIFO** | 踢出最早进来的 | 一般 |
| **Random** | 随机踢 | 简单，性能还行 |
| **NRU** (Not Recently Used) | 近似 LRU | 折中 |

### 1.2 写策略深入 Write Policies

| 策略 | 写 Cache | 写内存 | 优点 | 缺点 |
|:-----|:---------|:-------|:-----|:-----|
| **Write-through** | ✅ 同时写 | ✅ 同时写 | 内存始终最新 | 慢（每次写都走总线）|
| **Write-back** | ✅ 只写 Cache | ❌ 换出时才写 | 快（减少总线访问）| 内存可能过时 |

**Write-back 的脏位 Dirty bit**：
```
每行 Cache 有一个脏位（Dirty bit）
D=0: 该行和内存一致（Clean）
D=1: 该行被修改过（Dirty），换出时必须写回内存
```

### 1.3 Cache 性能公式

```
平均访问时间 = Hit Time + Miss Rate × Miss Penalty

例：Hit Time = 1ns, Miss Rate = 5%, Miss Penalty = 100ns
  平均访问时间 = 1 + 0.05 × 100 = 6ns

如果 Miss Rate 降到 2%：
  平均访问时间 = 1 + 0.02 × 100 = 3ns（提速一倍！）

影响 Miss Rate 的因素：
  1. Cache 大小（容量越大，Miss Rate 越低）
  2. 相联度（组数越多，冲突 Miss 越少）
  3. 行大小（行太大 → 空间局部性浪费，行太小 → Tag 开销大）
  4. 程序本身的局部性
```

### 1.4 TB2 重点：Caches 与流水线的交互

```
Cache Miss → CPU 停顿（stall）→ 流水线气泡
Cache Hit  → 流水线正常运行

所以：Cache 的 Miss Rate 直接影响 CPU 的实际性能
  CPU 主频再高，如果 Cache 频繁 Miss，性能也上不去
```

---

## 2. 结构化编程 Structured Programming

### 什么是结构化编程？

> 用**顺序、选择、循环**三种基本结构来编写程序，避免使用 goto

### 三种基本结构

```
顺序 Sequence：
  ┌─────────┐
  │ Step 1  │
  ├─────────┤
  │ Step 2  │
  ├─────────┤
  │ Step 3  │
  └─────────┘

选择 Selection（if-else）：
       ┌─────┐
       │条件？│
       └──┬──┘
      ┌───┴───┐
      ▼       ▼
   ┌─────┐ ┌─────┐
   │Then │ │ Else│
   └─────┘ └─────┘

循环 Iteration（while/for）：
          ┌─────┐
    ┌────►│条件？│
    │     └──┬──┘
    │    True│
    │   ┌────▼────┐
    │   │ 循环体   │
    │   └────┬────┘
    └───────┘ False
```

### 结构化编程与汇编

**为什么在体系结构课上讲这个？**

高级语言的结构化控制流（if/while/for）必须翻译成汇编的**条件跳转+无条件跳转**。

```
C 代码：                 汇编实现：
while (i < 10) {     loop: CMP i, #10
    sum += i;              JGE exit
    i++;                   ADD sum, i
}                          INC i
                           JMP loop
                       exit:
```

### if-else 的汇编翻译

```
C 代码：
if (a > b) {
    max = a;
} else {
    max = b;
}

汇编：
    LDA a_addr      ; R0 = a
    SUB b_addr      ; R0 = a - b
    JGE a_greater   ; if a >= b, 跳
    LDA b_addr      ; else: R0 = b
    STA max_addr    ; max = b
    JMP done
a_greater:
    LDA a_addr      ; R0 = a
    STA max_addr    ; max = a
done:
    HLT
```

### 结构化编程与流水线的矛盾

```
结构化编程 → 条件分支多（if/while/for）
条件分支   → 控制冒险（分支预测可能猜错）
猜错       → 流水线刷新 → 性能损失

所以：
  - 好的编译器会优化分支（如减少分支、条件传送）
  - 好的 CPU 有更好的分支预测器
```

---

## ⚡ 考试重点 Exam Focus

### 🔥 High-Frequency Topics / 高频考点

| Topic / 考点 | How it appears / 出现形式 | Priority / 重要程度 |
|:-------------|:--------------------------|:-------------------|
| **Cache mapping calculation / Cache 映射计算** | Given address → compute Tag/Index/Offset, hit/miss / 给地址算 Tag/Index/Offset | ⭐⭐⭐⭐⭐ |
| **Three mapping schemes / 三种映射对比** | Direct-mapped vs Set-associative vs Fully-associative / 优缺点对比 | ⭐⭐⭐⭐ |
| **Write policy / 写策略** | Write-through vs Write-back + dirty bit / 脏位 | ⭐⭐⭐⭐ |
| **Replacement policy / 替换策略** | LRU: which line gets evicted? / LRU 替换哪一行 | ⭐⭐⭐⭐ |
| **Cache performance formula / 性能公式** | Avg access time = Hit Time + Miss Rate × Miss Penalty | ⭐⭐⭐ |
| **3C Misses / 三种 Miss** | Compulsory vs Capacity vs Conflict / 区分三种缺失 | ⭐⭐⭐ |

### 📝 Classic Exam Question: Cache Mapping / 经典考题：Cache 映射计算

**Direct-mapped Cache: Tag/Index/Offset calculation / 直接映射 Cache 的 Tag/Index/Offset 计算**

```
Question / 题目：
  64 KB direct-mapped cache, 64-byte lines, 32-bit address
  64 KB 直接映射 Cache，每行 64 字节，32 位地址
  Access address 0x12345678: what are Tag, Index, Offset?
  访问地址 0x12345678：Tag、Index、Offset 是多少？

Solution / 解法：
  Offset = log₂(64) = 6 bits / 位
  Number of lines / 行数 = 64KB / 64B = 1024
  Index  = log₂(1024) = 10 bits / 位
  Tag    = 32 - 10 - 6 = 16 bits / 位

  Offset = addr & 0x3F           ; low 6 bits / 低 6 位
  Index  = (addr >> 6) & 0x3FF  ; next 10 bits / 接下来 10 位
  Tag    = addr >> 16            ; remaining 16 bits / 剩下 16 位
```

**LRU Replacement / LRU 替换**

```
Question / 题目：2-way set-associative cache, empty initially
                 2 路组相联 Cache，某组初始为空
  Access sequence / 访问序列：A, B, C, A, B
  Hit or Miss each time? Final content?
  每次 Hit/Miss？最后组里有哪些行？

Answer / 答案：
  A: Miss, put in Way0 [A, -]
  B: Miss, put in Way1 [A, B]
  C: Miss, LRU evicts A, put C [C, B]
  A: Miss, LRU evicts B, put A [C, A]
  B: Miss, LRU evicts C, put B [B, A]
  → Thrashing / 颠簸！ A and B keep evicting each other / 反复互相踢出
```

### ⚠️ Common Mistakes / 易错点
- **When computing Index, don't forget Offset!** Index = (addr >> OffsetBits) & (NumSets-1)
- **Set-associative**: Index chooses the **set**, then compare **all Tags** in that set / Index 选组，组内对比所有 Tag
- **Write-back + dirty bit**: dirty line MUST write back to memory on eviction; clean line can be overwritten / 脏行换出时必须写回
- **3C Misses / 三种 Miss 区分**:
  - Compulsory = first access ever / 第一次访问
  - Capacity = working set too big / 工作集太大
  - Conflict = multiple blocks fight for same cache line / 映射冲突

| English | 中文 |
|:--------|:-----|
| cache line / block | 缓存行 / 块 |
| tag / index / offset | 标记 / 索引 / 偏移 |
| associativity | 相联度 |
| set associative | 组相联 |
| replacement policy | 替换策略 |
| LRU (Least Recently Used) | 最近最少使用 |
| dirty bit | 脏位 |
| hit time | 命中时间 |
| miss penalty | 缺失惩罚 |
| average access time | 平均访问时间 |
| structured programming | 结构化编程 |
| sequence / selection / iteration | 顺序 / 选择 / 循环 |
| control flow graph | 控制流图 |
