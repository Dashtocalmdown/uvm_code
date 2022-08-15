interface Utopia;
    parameter int IfWidth=8;

    logic{IfWidth-1:0} data;
    bit clk_in, clk_out;
    bit soc, en, clav, valid, ready, reset, selected;

    ATMCellType ATMCell; //ATM信元结构的联合
    
    modport TopReceive (
    input data, soc, clav,
    output clk_in, reset, ready, clk_out, en, ATMCell, valid
    );
    
    modport TopTransmit (
        input clav,
        inout selected,
        output clk_in, clk_out, ATMCell, data, soc, en, valid, reset, ready
    );

    modport CoreReceive (
    input clk_in, data, soc, clav, ready, reset,
    output clk_out, en, ATMCell, valid
    );

    modport CoreTransmit (
    input clk_in, clav, ATMCell, valid, reset,
    output clk_out, data, soc, en, ready
    );

    clocking cbr @ (negedge clk_out);
        input clk_in, clk_out, ATMCell, valid, reset, en, ready;
        output data, soc, clav;
    endclocking

    modport TB_Rx(clocking cbr);

    clocking cbt @ (negedge clk_out);
        input clk_out, clk_in, ATMCell, soc, en, valid, reset, data, ready;
        output clav;
    endclocking

    modport TB_Tx (clocking cbt);

endinterface

typedef virtual Utopia vUtopia;
typedef virtual Utopia.TB_Rx vUtopiaRx;
typedef virtual Utopia.TB_Tx vUtopiaTx;

