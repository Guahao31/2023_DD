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

* `Ctrl+5` 或鼠标点击对应按钮，可添加输入端口进入电路原理图中：

    <img src="../pic/lab4/1.png" alt="添加输入端口" style="zoom:34%"  />

* `Ctrl+7/8/9/0` 或用鼠标点击对应按钮，可以分别向电路原理图中添加非门、与门、或门、异或门：

    <img src="../pic/lab4/2.png" alt="添加门" style="zoom:34%"  />

* 按 `Ctrl+6` 或用鼠标点击对应按钮，可以向电路原理图中添加输出端口：

    <img src="../pic/lab4/3.png" alt="添加输出" style="zoom:34%"  />

* 按 `Ctrl+3` 或用鼠标点击对应按钮，可以在电路原理图中画线：

    <img src="../pic/lab4/4.png" alt="添加线路" style="zoom:34%"  />

**仿真检查电路功能**

画好电路原理图之后，`Ctrl+1` 即可通过点击输入端口来改变输入端口的输入值，从而可以通过遍历所有输入值来检查电路功能是否正常。其中，深绿色表示低电平，亮绿色表示高电平。

<img src="../pic/lab4/5.png" alt="logisim 仿真" style="zoom:34%"  />

**为输入输出端口命名，以便转为 Verilog**

`Ctrl+2` 或鼠标点击对应图标后，双击输入输出端口，即可为其命名。*只有将输入、输出端口命名，方可将其正常地转为 Verilog*。

<img src="../pic/lab4/10.png" alt="命名" style="zoom:34%"  />

### 导出为Verilog

Vivado 无法读取 Logisim 的工程文件或原理图文件，需要通过将 Logisim 电路图转化为 Verilog 之后，方可在 Vivado 中进行电路实现。通过 Logisim 电路原理图导出 Verilog 的方法如下：

- 选择上方状态栏的FPGA > Synthesize & Download

- 在弹出的窗口中，选择目标板(Target board)为 `FPGA4U`
    
    <img src="../pic/lab4/8.png" alt="导出3" style="zoom:34%"  />

- 点击 `Settings` 按钮，并且将弹出窗口中 `FPGA Commander Settings` 选项下的 `Hardware discription language used for FPGA commander` 选项更改为 `Verilog`，随后可关闭弹出窗口。

    <img src="../pic/lab4/9.png" alt="导出4" style="zoom:34%"  />

- 点击 `Execute`，随后点击弹出窗口中的 `Done` 即可完成

    <img src="../pic/lab4/12.png" alt="导出6" style="zoom:34%"  />

- 此时即可在工作目录下 `./verilog` 子目录中看到生成的 Verilog 文件。

### 动手做 {: #logisim-example_lets-do-it}



#### （2）楼道灯控制的电路设计及仿真

楼道灯控制电路的功能需求为：由两个开关控制一盏灯，两个开关中任意一个的开关状态发生改变时，灯的开关状态都发生改变。我们用如下电路原理图即可实现该功能：

<img src="../pic/lab4/13.png" alt="原理图" style="zoom:50%"  />

该原理图中，`I_a` 和 `I_b` 分别为表示两个开关的输入端口，`O_a` 和 `O_b` 分别用于监控两个输入端口的状态，而 `O_f` 用于表示灯的状态。

在该步骤中，请完成功能和如上电路原理图相同的电路原理图，并在 Logisim 中进行仿真以验证其功能是否正确。

### 2. 利用 Vivado 对楼道灯控制电路进行行为仿真和上板验证

#### （1）Vivado 基本操作

##### （i）创建 Vivado 工程并向其中添加设计源文件

- 启动 Vivado 之后，选择顶部快捷栏中的 `File -> Project -> New`：

<img src="../pic/lab4/14.png" alt="创建工程" style="zoom:50%"  />

- 按照提示添加工程名称及路径：

<img src="../pic/lab4/15.png" alt="创建工程" style="zoom:30%"  />

- 在工程类型下选择图中选项：

<img src="../pic/lab4/16.png" alt="创建工程" style="zoom:30%"  />

- 选择 `xc7k160tffg676-2L` 型号：

<img src="../pic/lab4/17.png" alt="创建工程" style="zoom:30%"  />

- 点击 `Finish` 即可完成工程创建：

<img src="../pic/lab4/18.png" alt="创建工程" style="zoom:30%"  />

- 工程创建完成后，可在页面左侧的 `Project Manager` 中选择 `Add Sources`，即可在工程中添加或创建文件。

<img src="../pic/lab4/19.png" alt="创建工程" style="zoom:60%"  />

- 选择 `Add or Create Design Source`

<img src="../pic/lab4/20.png" alt="创建工程" style="zoom:40%"  />

- 选择 Logisim 工程目录的 verilog 子目录下的 circuit 和 gates 子目录的 Verilog 文件全部拷贝到工程中，随后点击 Finish 完成：

<img src="../pic/lab4/21.png" alt="创建工程" style="zoom:40%"  />
