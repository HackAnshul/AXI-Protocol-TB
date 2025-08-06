/////HEADER

`ifndef AXI_SLV_DRV_SV
`define AXI_SLV_DRV_SV

class axi_slv_drv extends uvm_driver #(axi_slv_seq_item);

  //factory registration
  `uvm_component_utils(axi_slv_drv)

  //to receive
  axi_slv_seq_item w_addr_que [$];
  axi_slv_seq_item w_data_que [$];
  axi_slv_seq_item r_addr_que [$];

  //to send
  axi_slv_seq_item r_data_que [$];
  axi_slv_seq_item w_resp_que [$];

  //virtual interface
  virtual axi_slv_inf vif;

  //constructor
  function new(string name = "axi_slv_drv", uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    //wait for clock and reset
    vif.wait_reset_assert();
    vif.wait_reset_release();
    @(vif.slv_drv_cb);
    fork
      //w_addr_phase();
      //w_data_phase();
      w_resp_phase(phase);
      //r_addr_phase();
      r_data_phase(phase);
    join_none

    forever begin
      phase.raise_objection(this);
      seq_item_port.get(req);
      `uvm_info(get_name(),$sformatf("in slave drv\n%s",req.sprint()), UVM_LOW)
      //if (req.opr == WRITE || req.opr == RW)
        w_resp_que.push_back(req);
      //if (req.opr == READ || req.opr == RW)
        r_data_que.push_back(req);
      phase.drop_objection(this);
    end
  endtask

  task r_data_phase(uvm_phase phase);
    axi_slv_seq_item item;
    forever begin
      wait(r_data_que.size != 0);
      item = r_data_que.pop_front();
      for(int i=0; i<=item.arlen; i++) begin
        @(vif.slv_drv_cb);
        vif.slv_drv_cb.rvalid <= 1'b1;
        vif.slv_drv_cb.rid    <= item.rid;
        vif.slv_drv_cb.rdata  <= item.rdata[i];
        vif.slv_drv_cb.rresp  <= item.rresp[i];
        if(i == item.arlen)
          vif.slv_drv_cb.rlast <= 1'b1;
        else
          vif.slv_drv_cb.rlast <= 1'b1;
        while (vif.slv_drv_cb.rready == 1'b0) @(vif.slv_drv_cb);
        if (r_data_que.size == 0) begin
          @(vif.slv_drv_cb) vif.slv_drv_cb.rvalid <= 1'b0;
        end
      end
    end
  endtask

  task w_resp_phase(uvm_phase phase);
    axi_slv_seq_item item;
    forever begin
      wait(w_resp_que.size != 0);
      item = w_resp_que.pop_front();
      @(vif.slv_drv_cb);
      vif.slv_drv_cb.bvalid <= 1'b1;
      vif.slv_drv_cb.bid    <= item.bid;
      vif.slv_drv_cb.bresp  <= item.bresp;
      while (vif.slv_drv_cb.bready == 1'b0) @(vif.slv_drv_cb);
      if (w_resp_que.size == 0)
        @(vif.slv_drv_cb) vif.slv_drv_cb.bvalid <= 1'b0;
    end
  endtask

  task w_addr_phase();
  endtask

  task w_data_phase();
  endtask

  task r_addr_phase();
  endtask

endclass

`endif

