`timescale 1ns/1ns
`define TxPorts 4 //发送端口的个数
`define RxPorts 4 //接收端口的个数

module top;
    parameter int NumRx=`RxPorts;
    parameter int NumTx=`RxPorts;
    logic rst, clk;
    // 系统时钟和复位
    initial begin
        rst=0;
        clk=0;
        # 5ns rst=1;
        # 5ns clk=1;
        # 5ns rst=0;clk=0;
        forever begin
            # 5ns clk=~clk;
        end
    end

    Utopia Rx[0:NumRx-1] (); // NumRx个Level 1 Utopian Rx接口
    Utopia Tx[0:NumTx-1] (); // NumTx个Level 1 Utopia Tx接口
    cpu_ifc mif(); //Utopia management interface
    squat # (NumRx, NumTx) squat(Rx, Tx, mif, rst, clk); // DUT
    test # (NumRx, NumTx) t1(Rx, Tx, mif, rst, clk); //Test

endmodule