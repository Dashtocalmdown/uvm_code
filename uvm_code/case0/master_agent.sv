class master_agent extends uvm_agnt;

        `uvm_component_utils(master_agent)
        //分配存储空间
        my_sequencer m_seqr;
        my_driver m_driv;
        my_monitor m_moni;

        virtual function void build_phase(uvm_phase phase);
                super.build_phase(phase);
                //创建并初始化所用到的类
                if(is_active == UVM_ACTIVE) begin
                        m_seqr = my_sequencer::type_id::create("m_seqr", this);
                        m_driv = my_driver::type_id::create("m_driv", this);
                end
                m_moni = my_monitor::type_id::create("m_moni", this);
        endfunction

        virtual function void connect_phase(uvm_phase phase);
                if(is_active == UVM_ACTIVE)
                        m_driv.seq_item_port.connect(m_sqr.seq_item_export);         
        endfunction

endclass