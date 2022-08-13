class reg_model_c extends uvm_reg_block;

    rand config_reg_c config_reg;
    rand mode_reg_c mode_reg;
    data_mem_c data_mem;

    virtual function void build();

        config_reg = config_reg_c::type_id::create("config_reg", get_full_name());
        config_reg.configure(this, null, "config_reg");
        config_reg.build();

        mode_reg = mode_reg_c::type_id::create("mode_reg", get_full_name());
        mode_reg.configure(this, null, "mode_reg");
        mode_reg.build();

        data_mem = data_mem_c::type_id::create("data_mem", get_full_name());
        data_mem.configure(this, null, "data_mem");
        data_mem.build();

        //创建map
        default_map = create_map("default_map", 0, 1, UVM_LITTLE_ENDIAN);

        default_map.add_reg(config_reg, `h001c, "RW");
        default_map.add_reg(mode_reg, `h002D, "RW");
        default_map.add_mem(data_mem, `h1000);

    endfunction 

    `uvm_object_utils(reg_model_c)
    function new(string name = "reg_model_c");
        super.new(name, UVM_NO_COVERAGE);
    endfunction //new()
endclass //reg_model_c extends superClass