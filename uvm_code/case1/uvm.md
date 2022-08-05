# UVM的库

-在类库中使用继承和封装

## 基本要素的三个层次

1. TLM是组件之间通讯的标准
2. Structural Elements是不同方法学的通用类：组件、信息系统、仿真阶段等等
3. Methodology是用户实现平台重用的重要接口

## UVM库的文件目录结构

uvm/
    UVM_Reference.html UVM参考文档
    uvm_release-notes  UVM发布信息
uvm/bin/
        ovm2uvm.pl     OVM到UVM的转换脚本
uvm/doc/               用户手册和参考
uvm/src/               UVM的源文件
        base/          UVM底层库文件
        comps/         方法学层次组件（agent, env）
        dpi, reg/      寄存器包和DPI
        macros/        宏定义
        seq/           与sequence相关的代码
        tlm1, tlm2/    TLM层级文件
        uvm_pkg.sv     包含UVM所需的文件
        uvm_macros.svh 宏包含文件

## UVM package包含的三个主要的类

1. uvm_component是用来构建UVM testbench层次结构最基本的类
2. uvm_object是UVM的一种数据结构，可作为配置对象来配置测试平台
3. uvm_transaction是用来产生激励和收集响应

## UVM结构树

UVM树的结构称之为逻辑层次结构。

UVM构建这种逻辑的原因：

1. 为config机制提供搜索路径
2. 为override机制提供搜索路径
3. 是phase自动执行的需要

## UVM的phase

UVM中为平台组件定义了一套phase流程来控制仿真平台的执行过程。
phase是uvm_component的属性。

phase的特性：

1. phase是按照图中的顺寻执行的
2. 不同phase和component中的相应的任务或者函数相对应
3. 同一phase的自顶向下和自下向上执行

phase的分类：

1. Task phase：消耗仿真时间
2. Function phase：不消耗仿真时间

主要phase：

1. build_phase          构建顶层测试平台的拓扑结构
2. connect_phase        连接测试平台的各个组件
3. end_of_elaboration_phase 打印一些平台相关信息（比如打印平台结构） 不常用
4. start_of_simulation_phase配置验证组件 不常用
5. run_phase            仿真整个过程在此运行
6. extract_phase        收集DUT详细的最终状态
7. check_phase          检查仿真结果
8. report_phase         对仿真结果的分析和报告

## UVM objection

UVM phase的objection属性有两个作用：

1. 控制task phase的运行与终止
2. 同步各个conponent同名的task phase