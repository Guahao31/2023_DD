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

可以得到电路图，电路名为 `Counter4b`：

<img src="../pic/circuit_counter4b.png" style="zoom:70%">

电路图中的 `FD` 为 D 触发器，但我们在 Lab9 中实现的触发器没有重置或初始化的值，因此在 Logisim 中画一个“空壳”即可，导出 Verilog 代码后，将 `FD.v` 中的内容替换如下：

```verilog linenums="1"
module FD(
    input clk,
    input D,
    output Q,
    output Qn
);

    reg Q_reg = 1'b0;
    always @(posedge clk) begin
        Q_reg <= D;    
    end
    
    assign Q = Q_reg;
    assign Qn = ~Q_reg;

endmodule
```

请确保模块端口定义如下：

```verilog
module Counter4b(
    input clk,
    output Qa, Qb, Qc, Qd,
    output Rc
)
```

### 仿真

自行书写仿真文件，对 `Counter4b` 进行仿真。

### 下板验证

顶层模块如下：

```verilog linenums="1"
module Top( 
	input wire clk,
	output wire LED,
	output wire [7:0] SEGMENT,
	output wire [3:0] AN
);
	 
	wire Qa;
	wire Qb;
	wire Qc;
	wire Qd;
	wire [3:0] Hex;
	
	/* module clk_1s at submodules/clk_1s.v */
	clk_1s m0(.clk(clk), .clk_1s(clk_1s));
	
	/* You need to implement module Counter4b */
	Counter4b m1(.clk(clk_1s), .Qa(Qa), .Qb(Qb), .Qc(Qc), .Qd(Qd), .Rc(LED));

	assign Hex = {Qd, Qc, Qb, Qa};

	// Please replace module below with your module completed in Lab 6
	// Pay attention to the correctness of the module name and port name
	// NOTE: SEGMENT and Segement are different port names

	// BTN[0]: LE, valid with value 0
	// BTN[1]: point, light with value 1
	// SW[7:4]: AN, light with value 1(AN[i] = ~SW[i+4])
	// SW[3:0]: number to display
	DispNum display(.BTN(2'b00), .SW({4'b0001, Hex}), .SEGMENT(SEGMENT), .AN(AN));

endmodule
```

子模块 `clk_1s` 文件 [clk_1s.v](../attachment/clk_1s.v)与[约束文件](../attachment/constraints_labA_part1.xdc)。

## 十六位可逆同步二进制计数器

