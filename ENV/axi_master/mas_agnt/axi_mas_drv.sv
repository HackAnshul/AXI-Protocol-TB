/////HEADER

`ifndef AXI_MAS_DRV_SV
`define AXI_MAS_DRV_SV

class axi_mas_drv extends uvm_driver #(axi_mas_seq_item);

  //factory registration
  `uvm_component_utils(axi_mas_drv)

  //to send
  axi_mas_seq_item w_addr_que [$];
  axi_mas_seq_item w_data_que [$];
  axi_mas_seq_item r_addr_que [$];

  //to receive
  axi_mas_seq_item r_data_que [$];
  axi_mas_seq_item w_resp_que [$];

  //virtual interface
  virtual axi_mas_inf vif;

  //constructor
  function new(string name = "axi_mas_drv", uvm_component parent);
    super.new(name,parent);
  endfunction

  // function void build_phase(uvm_phase phase);
  //   super.build_phase(phase);
  // endfunction

  task run_phase(uvm_phase phase);
    fork
      w_addr_phase();
      w_data_phase();
      w_resp_phase();
      r_addr_phase();
      r_data_phase();
    join_none

    forever begin
      seq_item_port.get(req);
      if (req.opr == READ || req.opr == RW) begin
        r_addr_que.push_back(req);
        r_data_que.push_back(req);
      end
      if (req.opr == WRITE || req.opr == RW) begin
        w_addr_que.push_back(req);
        w_data_que.push_back(req);
        w_resp_que.push_back(req);
      end
      $cast(rsp,req.clone());
      //rsp.set_id_info(req);
    end
  endtask

  task w_addr_phase(); // write address channel
    axi_mas_seq_item item;
    forever begin
      wait(w_addr_que.size != 0);
      #0;
      item = w_addr_que.pop_front();
      @(vif.mas_drv_cb);
      vif.awvalid <= 1'b1;
      while ( vif.awready == 1'b0 ) begin
        vif.awid    <= item.awid;
        vif.awaddr  <= item.awaddr;
        vif.awlen   <= item.awlen;
        vif.awsize  <= item.awsize;
        vif.awburst <= item.awburst;
      end
    end
  endtask

  task w_data_phase();
    @(vif.mas_drv_cb);
  endtask

  task w_resp_phase();
    @(vif.mas_drv_cb);
  endtask

  task r_addr_phase();
    @(vif.mas_drv_cb);
  endtask

  task r_data_phase();
    @(vif.mas_drv_cb);
  endtask
endclass

`endif

