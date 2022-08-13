class data_mem_c extends uvm_mem;


    `uvm_object_utils(data_mem_c)

    function new(string name = "data_mem_c");
        
        super.new(name, 512, 16);

    endfunction

endclass