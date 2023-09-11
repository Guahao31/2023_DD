# 实验四 实验工具的使用

!!! warning "请在上课前完成"
    参考[实验工具安装](./tools_installation.md)完成 Logisim Evolution 以及 Vivado 的安装。


## 实验目的

1. 熟悉利用 Logisim Evolution 进行电路原理图绘制、电路仿真的方法。
2. 熟悉利用 Vivado 进行 FPGA 工程管理的方法。

## 实验任务

1. 使用 Logisim 实现指定电路并进行仿真。
2. 利用 Vivado 对电路生成的 Verilog 代码进行仿真。
3. 利用 Vivado 进行上板验证。

## Logisim 的基本操作 {: #logisim-example}

!!! tip
    本节内容为 Logisim Evolution 的简单使用，包括电路图绘制和将电路图导出为 Verilog。
    
    我们将使用一个简单的电路展示 Logisim 的使用，请你在**浏览**本节内容后，完成[动手做](#logisim-example_lets-do-it)小节的**另一个**电路的设计。

### 绘图与仿真

**绘图**

* `Ctrl+5` 或鼠标点击对应按钮，可添加输入端口进入电路原理图中。

* `Ctrl+7/8/9/0` 或用鼠标点击对应按钮，可以分别向电路原理图中添加非门、与门、或门、异或门。

* `Ctrl+6` 或用鼠标点击对应按钮，可以向电路原理图中添加输出端口。

* `Ctrl+3` 或用鼠标点击对应按钮后，可以在电路原理图中画线，找到连线的一端并按住鼠标拖动即可：

    <img src="../pic/lab4/4.png" alt="添加线路" />

* 点击 `File > Save` 保存电路图。

**仿真检查电路功能**

画好电路原理图之后，`Ctrl+1` 后即可通过**点击**输入端口来改变输入端口的输入值，从而可以通过遍历所有输入值来检查电路功能是否正常。其中，深绿色表示低电平，亮绿色表示高电平。

<img src="../pic/lab4/5.png" alt="logisim 仿真" />

**为输入输出端口命名，以便转为 Verilog**

`Ctrl+2` 或鼠标点击对应图标后，双击输入输出端口，即可为其命名。*只有将输入、输出端口命名，才可将其正常地转为 Verilog*。

<img src="../pic/lab4/10.png" alt="命名" />

### 导出为Verilog

Vivado 无法读取 Logisim 的工程文件或原理图文件，需要通过将 Logisim 电路图转化为 Verilog 之后，方可在 Vivado 中进行电路实现。通过 Logisim 电路原理图导出 Verilog 的方法如下：

- 选择上方状态栏的 `FPGA > Synthesize & Download`。

- 在弹出的窗口中，选择目标板(Target board)为 `FPGA4U`。
    
    <img src="../pic/lab4/8.png" alt="导出3" />

- 点击 `Settings` 按钮，并且将弹出窗口中 `FPGA Commander Settings` 选项下的 `Hardware discription language used for FPGA commander` 选项更改为 `Verilog`，随后可关闭弹出窗口。

    <img src="../pic/lab4/9.png" alt="导出4" />

- 点击 `Execute`，随后点击弹出窗口中的 `Done` 即可完成。你可以忽略这一步给出的 *Design is not completely mapped* 的警告。

- 此时即可在工作目录下的 `verilog/` 子目录中看到生成的 Verilog 文件，如果你不知道文件保存到了哪里，请查看弹窗 `Info` 中的信息确定你的工作目录以及导出文件的位置。
对于本实验来说，有意义的代码文件存储在 `circuit/` 与 `gates/` 目录下。

### 动手做 {: #logisim-example_lets-do-it}

1. 浏览 Logisim 基本操作后，请**绘制**以下电路图。请注意，**端口名称**一定不要写错，三个输入端口分别为 `I0`、`I1`、`I2`，输出端口为 `res`。

    <img src="../pic/lab4/logisim_example.png" alt="logisim example" style="zoom:70%">

2. 在完成电路图绘制后，请进行**仿真**，将仿真结果填入下表（在实验报告中，你不需要画出表格，将结果从上到下依次书写即可）：

    | I0 | I1 | I2 | res |
    |---|---|---|---|
    | 0 | 0 | 0 | |
    | 0 | 0 | 1 | |
    | 0 | 1 | 0 | |
    | 1 | 0 | 0 | |
    | 0 | 1 | 1 | |
    | 1 | 1 | 0 | |
    | 1 | 0 | 1 | |
    | 1 | 1 | 1 | |

3. 将绘制的电路图**导出为 Verilog**。

## Vivado 的基本操作 {: vivado-example}

### 创建 Vivado 工程

**新建工程**

* 启动 Vivado 之后，选择顶部快捷栏中的 `File -> Project -> New`。

* 在 **Project Name** 界面中修改工程名称及路径，请注意，路径和名称中不要有中文，以避免一些问题。

* 在 **Project Type** 界面，选择 `RTL Project`，子选项保持默认即可。

- 选择 `xc7k160tffg676-2L` 型号：

<img src="../pic/lab4/17.png" alt="创建工程" />

- 点击 `Finish` 即可完成工程创建。

- 工程创建完成后，可在`Flow Navigator`的 `Project Manager` 中选择 `Add Sources`，即可在工程中添加或创建文件。

- 选择 `Add or Create Design Source`

<img src="../pic/lab4/20.png" alt="创建工程" />

- 选择 Logisim 工程目录的 verilog 子目录下的 circuit 和 gates 子目录的 Verilog 文件全部拷贝到工程中，随后点击 Finish 完成：

<img src="../pic/lab4/21.png" alt="创建工程" />
