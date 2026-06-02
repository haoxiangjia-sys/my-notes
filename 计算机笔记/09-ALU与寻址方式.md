# 09 — ALU 与寻址方式（W14）
## Arithmetic Logic Unit & Addressing Modes

---

## 1. ALU 深入（TI 74181）

### ALU 功能回顾

ALU = **算术逻辑单元**，CPU 的"计算核心"

### TI 74181 芯片

**74181** 是经典的 4 位 ALU 芯片，课程用它来讲解 ALU 内部原理：

| 特性 | 说明 |
|:-----|:------|
| **位宽** | 4 位（可级联成 8/16/32 位）|
| **功能** | 16 种逻辑运算 + 16 种算术运算（共 32 种）|
| **选择线** | S0-S3（4 位，选哪种运算）|
| **模式线** | M（M=0 算术，M=1 逻辑）|
| **进位** | 进位输入 \$C_{-n}\$ + 进位输出 \$C_{n+4}\$ |

```
          ┌──────────┐
  A0 ────►│          │
  A1 ────►│          │
  A2 ────►│  74181   │────► F0
  A3 ────►│   ALU    │────► F1
          │          │────► F2
  B0 ────►│          │────► F3
  B1 ────►│          │
  B2 ────►│          │────► \$C_{n+4}\$ (进位输出)
  B3 ────►│          │
          └──┬───┬───┘
             │   │
     S0-S3 (选择) M (模式)
```

### 典型 74181 运算举例

| S3-S0 | M=1（逻辑）| M=0（算术）|
|:-----:|:----------|:-----------|
| 0000 | \$\overline{A}\$ | A 加 1（取反加）|
| 0001 | \$\overline{A+B}\$ (NOR) | A \| B 加 1 |
| 0010 | \$\overline{A} \cdot B\$ | A + B 加 1（取反加B）|
| 0110 | \$A \oplus B\$ (XOR) | A 减 B |
| 1010 | B | A + B |
| 1100 | 0 | A 加 A（左移一位）|

### 级联 Cascade（扩展位宽）

```
4 位 ALU → 8 位 ALU：
  低位芯片的进位输出 \$C_{n+4}\$ → 高位芯片的进位输入 \$C_{-n}\$

  例：Hex 8 的 ALU 用 2 片 74181 级联成 8 位
```

---

## 2. 寻址方式 Addressing Modes

### 什么是寻址方式？

**寻址方式** = 指令中如何指定**操作数**的位置 / How an instruction specifies where its operand is

### Hex 8 的局限性

> 因为 Hex 8 指令只有 4 位 operand，**直接寻址只能访问前 16 个内存地址**（0-15）。

解决办法：用不同的**寻址方式**来访问更多内存。

### 常见寻址方式

| 方式 | 说明 | 示例 | 访问位置 |
|:-----|:-----|:-----|:---------|
| **立即数 Immediate** | 操作数就在指令里 | `LDI #5` | operand = 5 |
| **直接寻址 Direct** | 操作数是内存地址 | `LDA 20` | M[20] |
| **寄存器 Register** | 操作数在寄存器里 | `ADD R1` | R0 = R0 + R1 |
| **间接寻址 Indirect** | 地址在寄存器/内存里 | `LDA (R1)` | M[M[R1]] |
| **变址 Indexed** | 基址 + 偏移量 | `LDA 100(R1)` | M[R1 + 100] |
| **基址 Base** | 基址寄存器 + 偏移 | `LDA (R1+5)` | M[R1 + 5] |
| **相对寻址 PC-relative** | PC + 偏移量 | `BEQ +10` | PC + 10 |
| **自动增/减量 Auto-increment** | 访问后地址+1 | `LDA (R1)+` | M[R1], 然后 R1++ |

### Hex 8 如何用寻址突破 4 位限制？

```
技巧 1：用 R1 存高位地址
  LDI  #15        ; R0 = 15
  STA  R1         ; R1 = 15（存高位）
  LDI  #0         ; R0 = 0
  ADD  R1         ; R0 = 15 + 0 = 15? 不对，这是加法不是地址

实际 Hex 8 通过变址间接寻址来扩展：
  把 R1 当作地址指针，用类似 LDA (R1) 的方式
  这样能访问 0-255 的完整地址空间
```

---

## 3. Hex 8 寻址实验

### 如何实现间接寻址？

```
直接寻址：ADD  addr   →  R0 = R0 + M[addr]
间接寻址：ADD (addr)  →  R0 = R0 + M[M[addr]]

即：先读 addr 处的值作为"指针"，再读指针指向的位置
```

### 实验：用 Hex 8 实现数组访问

```
内存布局：
  addr 0:  存数组首地址（如 100）
  addr 1:  存数组索引（如 5）
  addr 100-105: 数组数据

要求：R0 = arr[5]

实现思路：
  1. LDA 0      ; R0 = 首地址 100
  2. STA R1     ; R1 = 100（基址）
  3. LDA 1      ; R0 = 索引 5
  4. ADD R1     ; R0 = 105（目标地址）
  5. ...        ; 访问 M[105]
```

---

## ⚡ 考试重点 Exam Focus

### 🔥 High-Frequency Topics / 高频考点

| Topic / 考点 | How it appears / 出现形式 | Priority |
|:-------------|:--------------------------|:---------|
| **74181 ALU function table / ALU 功能表** | Given S3-S0 and M, what operation? / 给控制信号问运算 | ⭐⭐⭐⭐ |
| **Ripple-carry adder / 行波进位加法器** | How cascading works / 如何级联扩展位宽 | ⭐⭐⭐ |
| **Adder-subtractor / 加减法器** | Using XOR + carry-in for two's complement / XOR + 进位实现减法 | ⭐⭐⭐ |
| **Addressing modes / 寻址方式** | Classify: immediate/direct/indirect/indexed/base/PC-relative / 分类各种寻址方式 | ⭐⭐⭐⭐ |

### 📝 Question Bank Exam Question / Question Bank 考题

```
Q: An adder-subtractor uses XOR gates to combine one input with the control
signal. Which gate is used? Why?
题目：加减法器用哪种逻辑门来组合输入和控制信号？为什么？

A: XOR gate / XOR 门
   Because XOR flips the bit when control=1 (for subtraction / 减法时取反)
   and passes it through when control=0 (for addition / 加法时不变)

   XOR truth table / 真值表：
   control | input | output
      0    |   0   |   0    ← pass through / 直通
      0    |   1   |   1    ← pass through / 直通
      1    |   0   |   1    ← invert / 取反
      1    |   1   |   0    ← invert / 取反
```

### ⚠️ Common Mistakes / 易错点
- **74181 is 4-bit** — two chips needed for 8-bit (Hex 8) / 两片级联成 8 位
- **Immediate vs Direct addressing** — immediate: value is IN the instruction; direct: value is AT the address in the instruction / 立即数 vs 直接寻址的区别
- **Indirect addressing** = M[M[addr]] — two memory accesses / 两次访存

| English | 中文 |
|:--------|:-----|
| ALU (Arithmetic Logic Unit) | 算术逻辑单元 |
| 74181 | 4 位 ALU 芯片 |
| cascade / ripple carry | 级联 / 行波进位 |
| addressing mode | 寻址方式 |
| immediate | 立即数寻址 |
| direct addressing | 直接寻址 |
| indirect addressing | 间接寻址 |
| indexed addressing | 变址寻址 |
| base addressing | 基址寻址 |
| PC-relative | 相对寻址 |
