# 多路选择器

!!! tip "请注意"
    从本次实验开始，要求必须画原理图的部分会**特别说明**，其他实验均可直接使用 Verilog 完成。

## 实验背景

### 多路选择器

多路选择器（Multiplexer，简称 MUX）是组合逻辑部件，用于在多个输入信号中选择一个进行输出。它有多个数据输入端，一组选择信号以及一个数据输出端。

<img src="../pic/multiplexer.png">

以 4-1 多路选择器为例，数据输入端口 `D0, D1, D2, D3`，选择信号 `S0, S1`，数据输出端口 `Y`。当 `S1S0` 分别为 `0, 1, 2, 3` 时，数据输出端口将分别输出 `D0, D1, D2, D3` 的值。

### 时钟分频

时钟分频可从一个时钟源获得多个不同频率的时钟信号，一些常见的硬件时钟分频方法：

* 二分频：将输入时钟信号的频率减半。可以通过一个触发器实现，每个上升沿（或下降沿）产生一个输出时钟脉冲。
* N 分频：将输入时钟信号的频率除以 N。可以通过计数器和用于重置的逻辑电路实现，计数器在每次时钟周期递增直到 N-1，重置归零并产生一个输出时钟脉冲。
* 锁相环(Phase-Locked Loop, PLL)：可以通过比较输入时钟信号和内部参考时钟信号的相位差来控制输出时钟信号的频率。

### 四位七段数码管动态显示

在之前的实验中，我们提到因为 Arduino 上四个七段数码管共用管脚，因此同一时间只能显示相同的数字。一个可行的方式是利用[视觉暂留效应](https://zh.wikipedia.org/zh-hans/%E8%A6%96%E8%A6%BA%E6%9A%AB%E7%95%99)，使用扫描的逻辑，每次只亮起一个数码管并显示对应数字，四个数码管循环显示。当每一个数码管的数字显示频率至少达到 10 次/秒时，我们会认为这四个七段数码管在“同时”显示了四个不同的数字。

利用多路选择器可以实现“扫描”，扫描的本质是**周期性**地选择出合适的打印数字和相应的使能信号，将四个十六进制数字输入作为 4-1 多路选择器的**数据输入**，将时钟分频器输出的某两位连续信号作为**选择信号**，即可周期性的选择出要打印的数字。四个七段数码管的使能信号也可以用多路选择器选择出来，每次选择出一个数码管进行显示。系统示意图如下：

<img src="../pic/degisn_diagram_display.png" style="zoom:60%">

需要注意使能信号的选择和输出数字的选择要同步，否则打印数字的位置和数值可能会与预期不符。

## 多路选择器的实现

### 一位 4-1 多路选择器

!!! tip "必须使用原理图完成"
    模块 `Mux4to1` 必须使用原理图完成

可以参考下图完成 `Mux4to1` 模块的设计，请注意修改电路名并确保端口名与图相同（选择信号 `S`）：

<img src="../pic/circuit_mux4to1.png" style="zoom:60%">

### 四位 4-1 多路选择器

将一位多路选择器拓展为四位时，可以重用地址选择的信号（即原理图中的 2-4 译码器部分），可以直接使用 Verilog 完成，模块定义如下：

```verilog linenums="1"
module Mux4to1b4(
    input  [1:0] S,
    input  [3:0] D0,
    input  [3:0] D1,
    input  [3:0] D2,
    input  [3:0] D3,
    output [3:0] Y
);
```

如果希望通过原理图实现，可以参考下图：

??? note "原理图"
    <img src="../pic/circuit_mux4to1b4.png">

实现后，请自行书写仿真代码，在 Vivado 中进行仿真。

## 时钟分频

实现一个简单的时钟分频器，其输出在每个**时钟信号上升沿**自增。复位信号为同步复位，当时钟信号的正边沿到来且复位信号为有效时（本实验中复位信号为高电平有效）进行复位。请补全下列代码，实现 `clkdiv` 模块：

```verilog linenums="1"
module clkdiv(
    input               clk,
    input               rst, // Active-high
    output reg [31:0]   clkdiv
);

    always @(_some_code_here) begin     // When postive edge of `clk` comes
        if(rst == 1'b1) begin
            clkdiv <= 32'b0;
        end else
            clkdiv <= _some_code_here;  // Increase `clkdiv` by 1
        end
    end

endmodule
```

## 简单应用

使用多路选择器和一些模块实现四位七段数码管动态显示，并实现一个“计分板”。

### 计分模块 CreateNumber

这里直接提供 `CreateNumber` 模块的 Verilog 代码：

???+ note "CreateNumber.v"
    ```verilog linenums="1"
    module CreateNumber(
        input [3:0]         btn,
        output reg [15:0]   num
    );

        wire [3:0] A, B, C, D;

        initial num <= 16'b1010_1011_1100_1101;

        assign A = num[15:12] + 4'b1;
        assign B = num[11: 8] + 4'b1;
        assign C = num[ 7: 4] + 4'b1;
        assign D = num[ 3: 0] + 4'b1;

        always @(posedge btn[0]) num[15:12] <= A;
        always @(posedge btn[1]) num[11: 8] <= B;
        always @(posedge btn[2]) num[ 7: 4] <= C;
        always @(posedge btn[3]) num[ 3: 0] <= D;

    endmodule
    ```

