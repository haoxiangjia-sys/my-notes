# 10 — 控制流与 ISA 案例研究（W15）
## Control Flow, Processor Control & Arm/x86 Case Study

---

## 1. 控制流 Control Flow

### 什么是控制流？

控制流 = 程序执行的**顺序**。默认是顺序执行（PC 递增），控制流指令改变这个顺序。

### 控制流指令类型

| 类型 | 指令 | 说明 |
|:-----|:-----|:------|
| **无条件跳转** | `JMP addr` | PC = addr，一定跳 |
| **条件跳转** | `JZ addr` | 如果结果为 0 则跳 |
| | `JNZ addr` | 如果结果不为 0 则跳 |
| | `JGE addr` | 如果 ≥ 0 则跳 |
| | `JLT addr` | 如果 < 0 则跳 |
| **子程序调用** | `CALL addr` | 跳转并保存返回地址 |
| | `RET` | 从子程序返回 |
| **条件码标志** | Flags (NZCV) | Negative, Zero, Carry, oVerflow |

### 条件码寄存器 Status/Flag Register

```
ALU 运算结果会设置标志位：
┌───┬───┬───┬───┐
│ N │ Z │ C │ V │  ← 条件码
└───┴───┴───┴───┘
│   │   │   │
│   │   │   └── oVerflow（溢出：结果超出 8 位范围）
│   │   └────── Carry（进位/借位）
│   └────────── Zero（结果为 0）
└────────────── Negative（结果为负，即最高位为 1）
```

**Hex 8 的条件跳转**：
- JGE 检查 Negative 标志：N=0 则跳
- JNZ 检查 Zero 标志：Z=0 则跳

### 控制流示例：条件分支

```
C 代码：              Hex 8 汇编：
if (x >= 0)           LDA  x_addr     ; R0 = x
    y = 1;            JGE  positive   ; 如果 R0 ≥ 0 跳转
else                  LDI  #0         ; R0 = 0
    y = -1;           STA  y_addr     ; y = -1
                      JMP  done
positive:             LDI  #1         ; R0 = 1
                      STA  y_addr     ; y = 1
done:                 HLT
```

### 控制流示例：循环

```
C 代码：              Hex 8 汇编：
sum = 0;              LDI  #0         ; R0 = 0
for (i=0; i<10; i++)  STA  sum_addr   ; sum = 0
    sum += i;         LDI  #0         ; R0 = 0
                      STA  i_addr     ; i = 0
loop:                 LDA  i_addr     ; R0 = i
                      ADI  #-10       ; R0 = i - 10
                      JGE  exit       ; if i >= 10, exit
                      LDA  i_addr     ; R0 = i
                      ADD  sum_addr   ; R0 = sum + i
                      STA  sum_addr   ; sum = sum + i
                      LDA  i_addr     ; R0 = i
                      ADI  #1         ; R0 = i + 1
                      STA  i_addr     ; i = i + 1
                      JMP  loop       ; 继续循环
exit:                 HLT
```

---

## 2. 处理器控制 Processor Control

### 控制单元的两层结构

```
指令 → 控制单元（组合逻辑或微编码）
         ├── 数据通路控制：RegWrite, ALUSrc, MemWrite, MemRead...
         └── 处理器控制：中断处理、复位、暂停...
```

### 硬连线控制 vs 微编码控制（复习 + TB2 深度）

| 对比 | 硬连线 Hardwired | 微编码 Microprogrammed |
|:-----|:----------------|:----------------------|
| **实现** | 组合逻辑门阵列 | ROM 中存微指令序列 |
| **速度** | 快（直接逻辑） | 慢（读 ROM 延迟） |
| **灵活性** | 不易修改 | 容易（改 ROM 内容）|
| **适用** | RISC、现代 CPU | CISC、旧 x86 |
| **Hex 8** | 默认用硬连线控制 | 也可以用微编码实现 |

### Hex 8 控制单元设计

```
Hex 8 的 4 位 opcode → 控制信号：

opcode[7:4] = 0000 (HLT) →  halt = 1
opcode[7:4] = 0001 (LDA) →  mem_read = 1, reg_write = 1, alu_src = 0
opcode[7:4] = 0010 (STA) →  mem_write = 1
opcode[7:4] = 0011 (ADD) →  alu_op = ADD, mem_read = 1, reg_write = 1
...
```

---

## 3. Arm vs x86 案例研究

### 设计哲学对比

| 对比 | ARM | x86 |
|:-----|:----|:----|
| **架构类型** | RISC（精简指令集） | CISC（复杂指令集）|
| **指令长度** | 固定（4 字节 / 2 字节 Thumb） | 变长（1-15 字节）|
| **寄存器数量** | 16+ 个通用寄存器 | 8 个（原）→ 16 个（x86-64）|
| **寻址方式** | 少而规整 | 多而复杂 |
| **指令格式** | 统一 | 多种格式 |
| **内存操作** | 只有 load/store 访存 | 很多指令可以直接操作内存 |
| **典型用途** | 手机、嵌入式、Mac（M系列） | 桌面 PC、服务器 |
| **功耗** | 低 | 高 |

### ARM 的特点

```
ARM 指令特征：
  1. 所有指令 32 位（ARM模式）或 16 位（Thumb模式）
  2. Load/Store 架构：只有 LDR/STR 访存
  3. 每条指令可条件执行：ADDEQ R0, R1, R2  （等于才执行）
  4. 内置桶形移位器：ADD R0, R1, R2, LSL #2

  ARM 寄存器：
  R0-R12: 通用寄存器
  R13 (SP): 栈指针
  R14 (LR): 链接寄存器（存返回地址）
  R15 (PC): 程序计数器
```

### x86 的特点

```
x86 指令特征：
  1. 变长指令（1 到 15 字节）
  2. 许多指令可以直接操作内存
  3. 寄存器数量少，功能分化
  4. 有专门的 push/pop 指令

  x86-64 寄存器（原 8 个扩展为 16 个）：
  RAX (累加器), RBX (基址), RCX (计数), RDX (数据)
  RSI, RDI, RBP, RSP, R8-R15
```

### 同一个 C 代码的 ARM vs x86 对比

```c
// C: a = b + c;
```

```assembly
@ ARM 汇编：
LDR R0, [R1]        @ R0 = b
LDR R2, [R3]        @ R2 = c
ADD R0, R0, R2      @ R0 = b + c
STR R0, [R4]        @ a = R0

; x86 汇编：
MOV EAX, [b]        ; EAX = b
ADD EAX, [c]        ; EAX = b + c（允许内存操作数）
MOV [a], EAX        ; a = EAX
```

关键区别：**x86 的 ADD 可以直接从内存读一个操作数**，ARM 需要先用 LDR 加载。

---

## ✏️ Key Terms

| English | 中文 |
|:--------|:-----|
| control flow | 控制流 |
| branch instruction | 分支指令 |
| jump instruction | 跳转指令 |
| condition code / flag | 条件码 / 标志位 |
| status register | 状态寄存器 |
| NZCV flags | 负零进位溢出标志 |
| subroutine / procedure | 子程序 / 过程 |
| call and return | 调用与返回 |
| hardwired control | 硬连线控制 |
| microprogrammed control | 微编码控制 |
| ARM | 一种 RISC 架构 |
| x86 | 一种 CISC 架构 |
| Load/Store architecture | 加载/存储架构 |
| barrel shifter | 桶形移位器 |
