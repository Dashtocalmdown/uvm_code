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

## UVM factory机制

可以使用户在不更改代码的情况下时下实现不同对象的更换

factory机制的运作步骤：

1. 将用户自定义的类向factory的注册表进行注册
2. 要使用“class_name::type_id::create()”来代替new来实例化对象
3. 根据具体要求向替换表添加替换条目
4. 在运行仿真时，UVM会根据这两张表自动的实现factory机制

## UVM信息服务机制

UVM会提供更为完善的信息打印机制：

./src/uvm_info.jpg

信息安全等级：

1. UVM_FATAL：仿真时不能容忍的错误，安全等级最严重，`uvm_fatal("ID", "Message")
2. UVM_ERROR：仿真时出现错误，不是平台本身的错误，`uvm_error("ID", "Message")
3. UVM_WARNING：仿真时给出的警告信息，可能会影响仿真，`uvm_warning("ID", "Message")
4. UVM_INFO：仿真时一般报告信息，安全等级最低，`uvm_info("ID", "Message", verbosity)

其中uvm_fatal, uvm_error, uvm_warning的打印信息总是会显示出来，
uvm_info的打印信息会根据其等级的不同而显示或不显示。
verbosity分为五种：UVM_LOW，UVM_MEDIUM，UVM_HIGH，UVM_FULL，UVM_DEBUG，默认为UVM_MEDIUM，高于其的三个等级信息都不会打印。

## UVM configuration机制

是一种属性配置工具，可以传递值，传递对象，传递interface。

特点：

1. 半个全局变量，避免全局变量带来的风险
2. 高层次组件可以通过configuration机制实现不改变代码的情况下，更改它所包含子组件的变量
3. 在各个层次上都可以使用此机制
4. 支持通配符和正则表达式对多个变量进行配置
5. 支持用户自定义的数据类型
6. 可以在仿真运行的过程中进行配置

使用原理：

1. 设置配置资源
2. 获取配置资源

./src/uvm_configration.jpg

如何使用：
./src/uvm_configration_set.jpg
./src/uvm_configration_get.jpg
