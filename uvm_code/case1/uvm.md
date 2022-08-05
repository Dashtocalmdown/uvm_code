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
