class my_socreboard extends uvm_scoreboard;

    reg_model_c reg_model;
    virtual task run_phase(uvm_phase phase);
        uvm_status_e status;
        uvm_reg_data_t value;

        forever begin
            reg_model.config_reg.write(status, value, UVM_FRONTDOOR);
            reg_model.mode_reg.read(status, value, UVM_FRONTDOOR);
        end
        
    endtask

    function new();
        
    endfunction //new()
endclass //my_socreboard extends superClass