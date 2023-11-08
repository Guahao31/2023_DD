# 全加器

## 背景介绍

**全加器**可以将两个二进制数 `A, B` 和一个进位输入 `Cin` 相加，得到一个和输出 `S` 以及一个进位输出 `Cout`。

### 一位全加器 {: #one-bit-full-adder}

根据一位全加器功能，很容易得到其真值表：

<img src="../pic/truth_table.png" style="zoom:70%">

根据真值表，可以获得输出 `S, Cout` 关于输入 `A, B, Cin` 的函数：

$$
\begin{align}
    S &= A \oplus B \oplus C_{in} \\
    C_{out} &= AB + BC_{in} + AC_{in}
\end{align}
$$

### 行波加法器

将 N 个一位全加器“依次相连”来拓展位宽，可以得到 N 位行波加法器，其模式图如下：

<img src="../pic/serial_carry_full_adder.png" style="zoom:65%">

### 超前进位加法器

行波加法器的组合时延会随着位宽拓展线性增加，其时延代价较大。使用超前进位加法器可以减少高位宽加法器的时延，感兴趣的同学可以查看[超前进位加法器](https://zh.wikipedia.org/zh-hans/%E5%8A%A0%E6%B3%95%E5%99%A8#%E8%B6%85%E5%89%8D%E8%BF%9B%E4%BD%8D%E5%8A%A0%E6%B3%95%E5%99%A8)。

## 全加器实现

### 一位全加器

!!! tip "必须使用原理图完成"
    模块 `Adder1b` 必须使用原理图完成

根据[背景介绍](#one-bit-full-adder)中得到的布尔表达式，我们可以使用以下电路图实现一位全加器：

<img src="../pic/circuit_one_bit_full_adder.png" style="zoom:70%">

请确保模块定义为：

```verilog linenums="1"
module Adder1b (
    input A,
    input B,
    input Cin,
    output S,
    output Cout
)
```

### 四位行波加法器

