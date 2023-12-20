# 外设使用

本课程大程设计可使用多种外设来完成交互，如用来输入的键盘/鼠标、开关、按钮，用来输出的七段数码管、LED、VGA、蜂鸣器等。其中开关、LED、七段数码管的使用在小实验中已较为熟练，在此不进行详细说明，仅提供部分资源或链接。

## LED

Arduino 板上共有 8 个 LED，可直接使用 8 个信号控制亮灭，在 [Lab5](../lab5/decoder.md) 中第一次使用。

SWORD 板上有 16 个 LED，接收串行数据，由串行通信信号 `LED_sclk, LED_sclrn, LED_sout, LED_EN` 控制亮灭，其原理见 [LabD](../labD/shift_register.md/#onboard-LED-7seg)，这里提供 `LEDP2S` 的[网表文件](../lab9/attachment/LEDP2S.ngc)与[接口文件](../lab9/attachment/LEDP2S_io.v)，其约束请见任何小实验提供的约束中 `#16led` 注释部分。

## 七段数码管

Arduino 板上共有 4 个七段数码管，可使用使能信号 `AN` 进行扫描并用 `SEGMENT` 传入 8 位信号控制打印内容，在 [Lab7](../lab7/multiplexer.md) 中编写并使用。

SWORD 板上有 8 个七段数码管，接受串行数据，由串行通信信号 `seg_sclk, seg_sclrn, seg_sout, seg_EN` 控制，其原理见 [LabD](../labD/shift_register.md/#onboard-LED-7seg)，在 [Lab8](../lab8/ALU.md) 中第一次使用。

## 