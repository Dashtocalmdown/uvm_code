class mode_reg_c extends uvm_reg;

    rand uvm_reg_field data;


    virtual function void build();

        data = uvm_reg_field::type_id::create("data");
  
        //参数 1. field所在的寄存器， 2. field的位宽， 3. field的最低位在寄存器中的位置
        //4. 访问模式， 5.  6. 复位后的默认值， 7. field是否可以复位，1为可以，0为不可以
        //8. field是否可以随机化， 9. field是否可以单独存取 
        data.configure(this, 8, 0, "RW", 0, `h0, 1, 1, 1);

    endfunction
    `uvm_object_utils(mode_reg_c)

    function new(string name = "mode_reg_c");
        
        super.new(name, 8, UVM_NO_COVERAGE);

    endfunction

endclass //config_reg_c extends superClass