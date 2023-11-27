# 同步计数器

计数器用来存储特定事件或过程发生次数的设备，每个时钟输入的脉冲都会使计数器增加或减少。计数器电路通常由多个触发器级联连接而成。本实验设计的**同步计数器**，所有触发器的时钟输入端连接在一起，由输入时钟脉冲触发，所有触发器的状态是同时改变的。

## 四位同步二进制计数器

!!! note "请注意"
    模块 `Counter4b` 必须使用原理图实现

四位二进制计数器输入时钟信号，输出为四位二进制值，二进制值从高位到低位分别是 `Qd, Qc, Qb, Qa`。每一个时钟信号的上升沿，`{Qd, Qc, Qb, Qa}` 的值就自增。根据功能描述，可以得到真值表如下，其中 `Q` 表示当前状态（输出），`D` 表示下一状态（下一个时钟上升沿到来后的输出）：

<img src="../pic/truth_table.png" style="zoom:60%">

根据真值表，可以得到以下激励函数：

\begin{align}
    D_A &= Q_A\\
    D_B &= \overline{Q_A \oplus \overline{Q_B}}\\
    D_C &= \overline{\overline{\overline{Q_A} + \overline{Q_B}} \oplus \overline{Q_C}}\\
    D_D &= \overline{\overline{\overline{Q_A} + \overline{Q_B} + \overline{Q_C}} \oplus \overline{Q_D}}
\end{align}

进位发生在四位数据均为 1 时，因此可以得到：

$$
R_C = Q_AQ_BQ_CQ_D = \overline{\overline{Q_A} + \overline{Q_B} + \overline{Q_C} + \overline{Q_D}}
$$

可以得到电路图：

<img src="../pic/circuit_counter4b.png" style="zoom:70%">