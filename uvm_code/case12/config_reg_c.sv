class config_reg_c extends uvm_reg;

    rand uvm_reg_field f1;
    rand uvm_reg_field f2;
    rand uvm_reg_field f3;
    rand uvm_reg_field f4;

    virtual function void build();

        f1 = uvm_reg_field::type_id::create("f1");
        f2 = uvm_reg_field::type_id::create("f2");
        f3 = uvm_reg_field::type_id::create("f3");
        f4 = uvm_reg_field::type_id::create("f4");
        //参数 1. field所在的寄存器， 2. field的位宽， 3. field的最低位在寄存器中的位置
        //4. 访问模式， 5.  6. 复位后的默认值， 7. field是否可以复位，1为可以，0为不可以
        //8. field是否可以随机化， 9. field是否可以单独存取 
        f1.configure(this, 1, 0, "RW", 0, `h0, 1, 1, 1);
        f2.configure(this, 1, 1, "RO", 0, `h0, 1, 1, 1);
        f3.configure(this, 5, 2, "RW", 0, `h0, 1, 1, 1);
        f4.configure(this, 1, 7, "RW", 0, `h0, 1, 1, 1);
    endfunction
    `uvm_object_utils(config_reg_c)

    function new(string name = "config_reg_c");
        
        super.new(name, 8, UVM_NO_COVERAGE);

    endfunction

endclass //config_reg_c extends superClass