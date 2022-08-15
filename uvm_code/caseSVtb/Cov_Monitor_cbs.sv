class Cov_Monitor_cbs extends Monitor_cbs;
    function new(input Coverage cov);
        this.cov = cov;
    endfunction //new()

    // 收到的信元发送到覆盖率类
    virtual task post_rx(input Monitor mon, input NNI_cell cell);
        CellCfgType CellCfg = top.squat.lut.read(cell.VPI);
        cov.sample(mon.PortID, CellCfg.FWD);        
    endtask 

endclass //Cov_Monitor_cbs extends superClass