class Scb_Driver_cbs extends Driver_cbs;
    Scoreboard scb;
    function new(input Scoreboard scb);
        this.scb = scb;
    endfunction //new()

    // 把收到的信元发送到计分板
    virtual task post_tx(input Driver drv, input UNI_cell cell);
        scb.save_expected(cell);
    endtask
endclass //Scb_Driver_cbs extends Driver_cbs