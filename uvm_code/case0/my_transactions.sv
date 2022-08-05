class my_transaction extends uvm_sequence_item;
    rand bit [3:0] sa; //源地址
    rand bit [3:0] da; //目标地址
    rand reg [7:0] payload[$]; //出书的数据
    
    //将定义的事务类注册到uvm中
    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(sa, UVM_ALL_ON);
        `uvm_field_int(da, UVM_ALL_ON);
        `uvm_field_queue(payload, UVM_ALL_ON);
    `uvm_object_utils_end

    //约束项，限制成员的随机范围
    constranint Limit {
        sa inside {[0:15]};
        da inside {[0:15]};
        payload.size() inside {[2:4]}
    }

    function new(string name = "my_transaction");
        super.new(name);
    endfunction

endclass