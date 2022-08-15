class Environment;
    UNI_generator gen[];
    mailbox gen2drv[];
    event drv2gen[];
    Driver drv[];
    Monitor mon[];
    Config cfg;
    Scoreboard scb;
    Coverage cov;
    virtual Utopia.TB_Rx Rx[];
    virtual Utopia.TB_Tx Tx[];
    int numRx, numTx;
    vCPU_T cpu;
    CPU_driver cpu;

    extern function new(input vUtopiaRx Rx[],
    input vUtopiaTx Tx[],
    input int numRx, numTx,
    input vCPU_T mif);

    extern virtual function void gen_cfg();
    extern virtual function void build();
    extern virtual task run();
    extern virtual function voidwrap_up();
    
    // 构造Environment实例
    function Environment::new(input vUtopiaRx Rx[],
    input vUtopiaTx Tx[],
    input int numRx, numTx, 
    input vCPU_T mif);
        this.RX = new[Rx.size()];
        foreach (Tx[i]) this.Tx[i] = Tx[i];
        this.numRx = numRx;
        this.numTx = numTx;
        this.mif = mif;
        cfg  = new(numRx, numTx);

        if ($test$plusargs("ntb_random_seed")) begin
            int seed;
            $value$pluargs("ntb_random_seed=%d", seed);
            $display("Simulation run with random seed=%d", seed);
        end
        else
            $display("Simulation run with default random seed");
    endfunction

    // 随机化配置描述符
    function void Environment::gen_cfg();
        assert(cfg.randomize());
        cfg.display();
    endfunction

    function void Environment::buid();
        cpu = new(mif, cfg);
        gen = new[numRx];
        drv = new[numRx];
        gen2drv = new[numRx];
        drv2gen = new[numRx];
        scb = new(cfg);
        cov = new();

        // 建立发生器
        foreach (gen[i]) begin
            gen2drv[i] = new();
            gen[i] = new( gen2drv[i], drv2gen[i],
            cfg.cells_per_chan[i], i);
            drv[i] = new(gen2drv[i], drv2gen[i], i);
        end

        // 建立监视器
        mon = new[numTx];
        foreach (mon[i]) mon[i] = new(Tx[i], i);

        // 通过回调函数连接覆盖率程序到监视器
        begin
            Cov_MOnitor_cbs = new(cov);
            foreach (mon[i])
                mon[i].cbsq.push_back(smc);
        end
        
    endfunction

    // 启动事务：发生器、驱动器、监视器
    task Environment::run();
        int num_gen_running;

        // CPU接口必须最先初始化
        cpu.run();

        num_gen_running = numRx;

        // 为每个RX接收通道开启发生器和驱动器
        foreach (gen[i]) begin
            int j = i;
            fork
                begin
                    if(cfg.in_use_Rx[j])
                        gen[j].run();  // 等待发生器结束
                    num_gen_running--;  // 减少驱动器的个数
                end
                if (cfg.in_use_Rx[j]) drv[j].run();
            join_none
        end

        // 为每个Tx输出通道启动监视器
        foreach (mon[i]) begin
            int j = i;
            fork
                mon[j].run();
            join_none
        end 

        // 等待所有的发生器结束或者超时
        fork: timeout_block
        await (num_gen_running ==0);
        begin
            repeat(1_000_000) @ (Rx[0].cbr);
            $display("@%0t:%m ERROR:Generator timeout", $time);
            cfg.nErrors++;
        end
        join_any
        disable timeout_block;

        // 等待数据送到监视器和计分板
        repeat (1_000) @ (Rx[0].cbr);
    endtask

    // 运行结束后清除/报告工作
    function void Environment::wrap_up();
        $display("@%0t: End of sim, %0d errors, %0d warnnings", $time, cfg.nErrors, cfg.nwarnnings);
        scb.wrap_up;
    endfunction

endclass
