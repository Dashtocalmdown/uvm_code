interface cpu_if;

    logic BusMode, Sel, Rd_Ds, Wr_RW, Rdy_Dtack;
    logic[11:0] Addr;
    CellCfgType DataIn, DataOut;

    modport Peripheral (
    input BusMode, Addr, Sel, DataIn, Rd_Ds, Wr_RW,
    output DataOut, Rdy_Dtack
    );

    modport Test (
    input DataOut, Rdy_Dtack,
    output BusMode, Addr, Sel, DataIn, Rd_Ds, Wr_RW
    );

endinterface

typedef virtual cpu_ifc.Test vCPU_T;