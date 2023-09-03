# 实验四 EDA工具的使用

## 实验目的

1. 熟悉利用Logisim Evolution进行电路原理图绘制、电路仿真的方法
2. 熟悉利用VIVADO进行FPGA工程管理的方法。

## 实验环境

- EDA工具：Logisim Evolution（依赖于Java 16）, VIVADO
- 操作系统：Windows
- SWORD开发板

## 实验依赖

1. 预先配置好Java 16或以上，可由[此链接]([Java Downloads | Oracle](https://www.oracle.com/java/technologies/downloads/))下载。下载并安装后，需将JDK和JRE的安装目录中的`./bin`子目录添加到`Path`环境变量中。
2. 预先下载Logisim Evolution。本套实验指导使用的是3.8.0版本。可由[此链接](https://github.com/logisim-evolution/logisim-evolution/releases/download/v3.8.0/logisim-evolution-3.8.0-all.jar)下载。Logisim Evolution依赖Java 16。
3. 预先安装VIVADO。建议使用2017.4版本，可由[此链接](https://china.xilinx.com/support/download/index.html/content/xilinx/zh/downloadNav/vivado-design-tools/archive.html)下载。

## 实验背景知识

- **LogiSim**是一种数字逻辑电路仿真工具，用于模拟数字电路的行为和性能。 它可以用于设计和验证各种数字电路，例如计算机处理器、逻辑门电路、寄存器、时序电路等。 LogiSim通常提供了直观的用户界面，其中包含各种数字逻辑元件的图标，例如AND门、OR门、XOR门、触发器、计数器等。 用户可以使用这些图标来构建数字逻辑电路，然后使用仿真功能来验证电路的功能和性能。 由于支持通过鼠标拖动来直观地绘制电路，因此被广泛应用于电子工程、计算机科学、通信系统等领域相关课程教学。（摘自《计算机系统I》实验指导书）
- **FPGA**，即现场课编程逻辑门阵列，属于专用集成电路中的一种半定制电路，是可编程的逻辑列阵，能够有效的解决原有的器件门电路数较少的问题。 FPGA 的基本结构包括可编程输入输出单元，可配置逻辑块，数字时钟管理模块，嵌入式块RAM，布线资源，内嵌专用硬核，底层内嵌功能单元（摘自《计算机系统I》实验指导书）
- **Verilog**是一种用于描述、设计电子系统（特别是数字电路）的硬件描述语言。Verilog能够在多种抽象级别对数字逻辑系统进行描述：既可以在晶体管、逻辑门进行描述，也可以在寄存器传输级对电路信号在寄存器之间的传输情况进行描述。除了对电路的逻辑功能进行描述，Verilog代码还能够被用于逻辑仿真、逻辑综合，其中后者可以把寄存器传输级的Verilog代码转换为逻辑门级的网表，从而方便在FPGA上实现硬件电路。（摘自中文维基百科）
- **Vivado**是Xilinx开发的一款用于硬件描述语言设计的合成和分析的软件套件，具有用于片上系统开发和高级综合的附加功能。（摘自中文维基百科）

## 实验任务

1. 使用Logisim实现楼道灯控制对应电路并进行仿真
2. 利用VIVADO对楼道灯控制电路进行行为仿真
3. 利用VIVADO对楼道灯控制电路进行上板验证

## 实验步骤

### 1. 使用Logisim实现楼道灯控制对应电路并进行仿真

#### （1）Logisim的基本操作

##### （i）电路原理图的绘制

按Ctrl+5或鼠标点击对应按钮，可添加输入端口入电路原理图中：

<img src="../img/lab4/1.png" alt="添加输入端口" style="zoom:34%" align="left" />

按Ctrl+7、 8 、9、0或用鼠标点击对应按钮，可以分别向电路原理图中添加非门、与门、或门、异或门：

<img src="../img/lab4/2.png" alt="添加门" style="zoom:34%" align="left" />

按Ctrl+6或用鼠标点击对应按钮，可以向电路原理图中添加输出端口：

<img src="../img/lab4/3.png" alt="添加输出" style="zoom:34%" align="left" />

按Ctrl+3或用鼠标点击对应按钮，可以在电路原理图中画线：

<img src="../img/lab4/4.png" alt="添加线路" style="zoom:34%" align="left" />

画好电路原理图之后，按Ctrl+1，即可通过点击输入端口来改变输入端口的输入值，从而可以通过遍历所有输入值来检查电路功能是否正常。其中，深绿色表示低电平，亮绿色表示高电平。

<img src="../img/lab4/5.png" alt="logisim 仿真" style="zoom:34%" align="left" />

按Ctrl+2或鼠标点击对应图标后，双击输入输出端口，即可为其命名。只有将输入、输出端口命名，方可将其正常地转为Verilog。

<img src="../img/lab4/10.png" alt="命名" style="zoom:34%" align="left" />

##### （ii）将电路图导出为Verilog

VIVADO无法读取Logisim的工程文件或原理图文件，需要通过将Logisim电路图转化为Verilog之后，方可在VIVADO中进行电路实现。通过Logisim电路原理图导出Verilog的方法如下：

- 首先，将选择上方状态栏的FPGA > Synthesize & Download

<img src="../img/lab4/6.png" alt="导出1" style="zoom:34%" align="left" />

- 在弹出的窗口中，选择目标板为`FPGA4U`

<img src="../img/lab4/7.png" alt="导出2" style="zoom:34%" align="left" />

- 点击`Settings`按钮，并且将弹出窗口中`FPGA Commander Settings `选项下的`Hardware discription language used for FPGA commander `选项更改为`Verilog`，随后可关闭弹出窗口。

<img src="../img/lab4/8.png" alt="导出3" style="zoom:34%" align="left" />

<img src="../img/lab4/9.png" alt="导出4" style="zoom:34%" align="left" />

- 点击`Execute`，随后点击弹出窗口中的`Done`即可完成

<img src="../img/lab4/11.png" alt="导出5" style="zoom:34%" align="left" />

<img src="../img/lab4/12.png" alt="导出6" style="zoom:34%" align="left" />

- 此时即可在工作目录下`./verilog`子目录中看到生成的Verilog文件。

#### （2）楼道灯控制的电路设计及仿真

楼道灯控制电路的功能需求为：由两个开关控制一盏灯，两个开关中任意一个的开关状态发生改变时，灯的开关状态都发生改变。我们用如下电路原理图即可实现该功能：

<img src="../img/lab4/13.png" alt="原理图" style="zoom:50%" align="left" />

该原理图中，`I_a`和`I_b`分别为表示两个开关的输入端口，`O_a`和`O_b`分别用于监控两个输入端口的状态，而`O_f`用于表示灯的状态。

在该步骤中，请完成功能和如上电路原理图相同的电路原理图，并在Logisim中进行仿真以验证其功能是否正确。

### 2. 利用VIVADO对楼道灯控制电路进行行为仿真和上板验证

#### （1）VIVADO基本操作

##### （i）创建VIVADO工程并向其中添加设计源文件

- 启动VIVADO之后，选择顶部快捷栏中的`File -> Project -> New`：

<img src="../img/lab4/14.png" alt="创建工程" style="zoom:50%" align="left" />

- 按照提示添加工程名称及路径：

<img src="../img/lab4/15.png" alt="创建工程" style="zoom:30%" align="left" />

- 在工程类型下选择图中选项：

<img src="../img/lab4/16.png" alt="创建工程" style="zoom:30%" align="left" />

- 选择`xc7k160tffg676-2L`开发板：

<img src="../img/lab4/17.png" alt="创建工程" style="zoom:30%" align="left" />

- 点击`Finish`即可完成工程创建：

<img src="../img/lab4/18.png" alt="创建工程" style="zoom:30%" align="left" />

- 工程创建完成后，可在页面左侧的`Project Manager`中选择`Add Sources`，即可在工程中添加或创建文件。

<img src="../img/lab4/19.png" alt="创建工程" style="zoom:60%" align="left" />

- 选择"Add or Create Design Source"

<img src="../img/lab4/20.png" alt="创建工程" style="zoom:40%" align="left" />

- 选择Logisim工程目录的verilog子目录下的circuit和gates子目录的Verilog文件全部拷贝到工程中，随后点击Finish完成：

<img src="../img/lab4/21.png" alt="创建工程" style="zoom:40%" align="left" />
