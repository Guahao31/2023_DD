# 锁存器与触发器

## 实验背景

!!! tip "关于本节"
    本节内容多来自于维基百科 [Flip-flop(electronics)](https://en.wikipedia.org/wiki/Flip-flop_(electronics)) 词条。

**锁存器**(Latch)以及**触发器**(Flip-flop)被称为双稳态多谐振荡器(Bistable multivibrator)，即拥有两个稳定状态并可以用来记录和表达两种状态信息的电子部件，可以用来存储 **1 比特**的数据（两种状态分别为 0 和 1）。

锁存器与触发器通常分为几种类型：**SR**("set-reset") **D**("data" or "delay") **T**("toggle") **JK**，本实验中主要关注 SR 与 D 两种类型的锁存器和触发器。

### 锁存器

锁存器结构较简单，在此介绍 SR 锁存器、D 锁存器以及“门控”的概念。

#### SR 锁存器

SR 锁存器通过两个输入端口(`S, R`)对锁存器保存数据进行修改或保持，其功能表如下，`S` 含义为 set 即将数据设置为 1，`R` 含义为 reset 即将数据重置为 0：

<img src="../pic/sr-latch-truth-table.png" style="display: block; margin: 0 auto; zoom:60%">

具体实现上，根据使用逻辑门（输入端口有效电平）的不同分为 **SR NOR latch** 和 **$\overline{SR}$ NAND latch**。后者名字中的“非”表示其值为假时（低电平）有效，将上表 S 和 R 列的 **0 与 1 互换**即可得到 $\overline{SR}$ NAND latch 的功能表。SR 锁存器的原理图如下，图中 `Qbar` 为存储数据 `Q` 的反：

<img src="../pic/circuit-sr-latch.png" style="zoom: 75%">

将图中的 NOR 门换为 NAND 门，并交换输出端口（或者输入端口）即可获得 $\overline{SR}$ 锁存器：

<img src="../pic/circuit-snrn-latch.png" style="zoom: 75%">

#### 门控 SR 锁存器

为 SR 锁存器添加一个输入 `C`，只有它的值为 1 时才能对锁存器存储的值进行修改。以门控 $\overline{SR}$ 锁存器的原理图为例：

<img src="../pic/circuit-csnrn-latch.png" style="zoom: 75%">

#### D 锁存器 & 门控 D 锁存器

可以观察到，SR 锁存器存在**不稳定状态**这一问题，不稳定状态与其输入相关，很容易想到一种解决方法，即只用一个输入端口 `D` 来对存储内容进行修改（当然，这样就无法做到“保持状态”）。

<img src="../pic/circuit-d-latch.png" style="zoom: 75%">

为其加上“门控”，可以得到本实验要求实现的门控 D 锁存器：

<img src="../pic/circuit-cd-latch.png" style="zoom: 75%">