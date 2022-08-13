class my_env extends uvm_env;

    `uvm_component_utils(my_env)
    master_agent m_agent;

    //寄存器模型
    reg_model_c reg_model;
    my_adapter reg_adapter;
    my_socreboard scoreboard;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        m_agent = master_agent::type_id::create("m_agent", this);
        
        //寄存器模型
        reg_model = reg_model_c::type_id::create("reg_model", this);
        reg_model.configure(null, "tb_dut");
        reg_model.build();
        reg_model.lock();
        reg_model.reset();

        reg_adapter = reg_adapter::type_id::create("reg_adapter", this);
        
    endfunction

    virtual function void conncet_phase(uvm_phase phase);

        reg_model.default_map.set_sequence(agent.sequencer, reg.adapter);
        reg_model.default_map.set_auto_predict(1);

        scoreboard.reg_model = reg_model();
        

    endfunction

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_top.print_topology(uvm_default_tree_printer);
    endfunction

endclass