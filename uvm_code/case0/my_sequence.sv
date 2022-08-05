class my_sequence extends uvm_sequence #(my_transaction);
    `uvm_objectutils(my_sequence)

    function new(string name = "my_sequence");
        super.new(name);
    endfunction

    //控制和产生transaction序列
    virtual task body();
        if(starting_phase != null)
            starting_phase.raise_objection(this);
        //产生10个事务对象transaction
        repeat(10) begin
            `uvm_do(req)
        end
        #1000;
        if(starting_phase != null)
            starting_phase.drop_objection(this);
    endtask

endclass