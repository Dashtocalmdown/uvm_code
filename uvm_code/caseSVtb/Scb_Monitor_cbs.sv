class Scb_Monitor_cbs extends Monitor_cbs'
    Scoreboard scb;
    function new(input Scoreboard scb);
        this.scb = scb;
    endfunction
    // 把收到的信元发送到计分板
    virtual task post_rx(input Monitor mon, input NNI_cell cell);
        scb.check_actual(cell, mon.PortID);
    endtask

endclass