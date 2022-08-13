class my_sequence extends uvm_sequence #(my_transaction);
    
    `uvm_object_utils(my_sequence)
    
    int item_num = 10;
    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    function void pre_randomize();
        uvm_config_db#(int)::get(m_sequencer, "", "item_num", item_num);
    endfunction

    //控制和产生transaction序列
    virtual task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);
        //产生item_num个事务对象transaction
        repeat(item_num) begin
            `uvm_do(req)
            //实现uvm_do宏的等效方法
            // my transaction tr;
            // tr = my transaction::type_id::create("tr");
            // start_item(tr);
            // tr.pre_randomize();
            // finish_item(tr);  
        end
        #100;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask

endclass