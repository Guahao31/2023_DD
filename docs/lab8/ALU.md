# 算术逻辑单元

## 背景介绍

### 算术逻辑单元

算术逻辑单元（Arithmetic Logic Unit，下称 ALU）是一种对**二进制整数**执行算术运算（加法、减法等）或位运算（与、或、异或等）的组合逻辑数字电路。我们主要关注的信号是两个操作数输入、运算结果输出以及操作码输入，操作码输入主要是用来选择 ALU 进行运算的种类。除了上述端口，还有各类状态信号，比如进位信号、零信号、溢出信号、奇偶校验结果等，主要是对计算结果的特征进行说明。

### 全加器

**全加器**将两个二进制数 `A, B` 和一个进位输入 `Cin` 相加，得到一个和输出 `S` 以及一个进位输出 `Cout`。

#### 一位全加器 {: #one-bit-full-adder}

根据一位全加器功能，很容易得到其真值表：

<img src="../pic/truth_table.png" style="zoom:70%">

根据真值表，可以获得输出 `S, Cout` 关于输入 `A, B, Cin` 的函数：

$$
\begin{align}
    S &= A \oplus B \oplus C_{in} \\
    C_{out} &= AB + BC_{in} + AC_{in}
\end{align}
$$

#### 行波加法器

将 N 个一位全加器“依次相连”来拓展位宽，可以得到 N 位行波加法器，其模式图如下：

<img src="../pic/serial_carry_full_adder.png" style="zoom:65%">

#### 超前进位加法器

行波加法器的组合时延会随着位宽拓展线性增加，其时延代价较大。使用超前进位加法器可以减少高位宽加法器的时延，感兴趣的同学可以查看[超前进位加法器](https://zh.wikipedia.org/zh-hans/%E5%8A%A0%E6%B3%95%E5%99%A8#%E8%B6%85%E5%89%8D%E8%BF%9B%E4%BD%8D%E5%8A%A0%E6%B3%95%E5%99%A8)。

### 加减法器 {: #sub-adder}

在得到全加器实现后，可以为其添加一些逻辑实现加减法器。减法 `A-B` 可以看作 `A+(-B)`，其中 `-B` 使用 `B` 的[补码](https://zh.wikipedia.org/zh-hans/%E4%BA%8C%E8%A3%9C%E6%95%B8)表示，即可使用全加器得到减法的结果。


## 加减法器实现

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

### 四位加减法器

!!! tip "必须使用原理图完成"
    模块 `AddSub4b` 必须使用原理图完成

根据[背景介绍](#sub-adder)，减数 `B` 的补码可以写作 `~B + 1`。观察加法的 `B` 与减法的 `-B`，差别在于加法器第二个操作数**是否取反**以及是否有最低的进位，联想到异或操作的特性（一个操作数为 1 时，结果为另一个操作数的反；一个操作数为 0 时，结果与另一个操作数相同），可以得到以下原理图：

<img src="../pic/circuit_addsub.png">

请确保模块定义为：

```verilog linenums="1"
module AddSub4b (
    input [3:0] A,
    input [3:0] B,
    input       Ctrl,
    output[3:0] S,
    output      Cout
)
```

## ALU 实现

