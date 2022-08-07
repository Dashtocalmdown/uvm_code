`include "../../rtl/router.v"
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "dut_interface.sv"
`include "my_transaction.sv"
`include "my_sequence.sv"
`include "my_driver.sv"
`include "my_sequencer.sv"
`include "my_monitor.sv"
`include "master_agent.sv"
`include "my_env.sv"
`include "my_test.sv"
`include "my_driver_count.sv"
`include "my_test_type_driver.sv"
`include "my_test_inst_driver.sv"

module top;

    bit sys_clk;
    // 实例化interface
    dut_interface inf(sys_clk);
    // 实例化DUT，并将其端口与interface相连
    router dut(.reset_n(inf.reset_n), .clock(inf.clk), .frame_n(inf.frame_n),
    .valid_n(inf.valid_n), .din(inf.din), .dout(inf.dout), .busy_n(inf.busy_n),
    .valido_n(inf.valido_n), .frameo_n(inf.frameo_n)
    );
    // 产生系统时钟
    initial begin
        sys_clk = 1'b1;
        forever #10 sys_clk = ~sys_clk;
    end
    // 使用uvm_config_db::set将该interface实例配置给driver的virtual 
    initial begin
        uvm_config_db#(virtual dut_interface)::set(null, "*.m_agent.*", "vif", inf);
        // 启动仿真平台
        run_test();
    end
    initial begin
        // dump波形
        $wlfdumpvars();
    end
endmodule