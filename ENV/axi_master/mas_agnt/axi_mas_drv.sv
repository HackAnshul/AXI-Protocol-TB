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

  task run_phase(uvm_phase phase);
    //wait for clock and reset
    vif.wait_reset_assert();
    vif.wait_reset_release();
    @(vif.mas_drv_cb);
    fork
      w_addr_phase();
      w_data_phase();
      w_resp_phase();
      r_addr_phase();
      r_data_phase();
    join_none

    forever begin
      seq_item_port.get_next_item(req);
      $display("driver");
      `uvm_info(get_name(),$sformatf("in driver\n%s",req.sprint()), UVM_LOW)
      if (req.opr == READ || req.opr == RW) begin
        r_addr_que.push_back(req);
        r_data_que.push_back(req);
      end
      if (req.opr == WRITE || req.opr == RW) begin
        w_addr_que.push_back(req);
        w_data_que.push_back(req);
        w_resp_que.push_back(req);
      end
#100;
      seq_item_port.item_done();
      //$cast(rsp,req.clone());
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
      vif.awid    <= item.awid;
      vif.awaddr  <= item.awaddr;
      vif.awlen   <= item.awlen;
      vif.awsize  <= item.awsize;
      vif.awburst <= item.awburst;
      while (vif.awready == 1'b0) @(vif.mas_drv_cb);
      if (w_addr_que.size == 0) vif.awvalid <= 1'b0;
    end
  endtask

  task w_data_phase();
    axi_mas_seq_item item;
    forever begin
      wait(w_data_que.size != 0);
      #0;
      item = w_data_que.pop_front();
      for(int i=0; i<=item.awlen; i++) begin
        @(vif.mas_drv_cb);
        vif.wvalid <= 1'b1;
        //vif.mas_drv_cb.wid <= item.wid;
        vif.wdata <= item.wdata[i];
        vif.wstrb <= item.wstrb[i];
        if(i == item.awlen)
          vif.wlast <= 1'b1;
        else
          vif.wlast <= 1'b0;
        while (vif.wready == 1'b0) @(vif.mas_drv_cb);
        if (w_data_que.size == 0) vif.wvalid <= 1'b0;
      end
    end
  endtask

  task w_resp_phase();
    @(vif.mas_drv_cb);
  endtask

  task r_addr_phase();
    axi_mas_seq_item item;
    forever begin
      wait(r_addr_que.size != 0);
      #0;
      item = r_addr_que.pop_front();
      @(vif.mas_drv_cb);
      vif.arvalid <= 1'b1;
      vif.arid    <= item.arid;
      vif.araddr  <= item.araddr;
      vif.arlen   <= item.arlen;
      vif.arsize  <= item.arsize;
      vif.arburst <= item.arburst;
      while (vif.arready == 1'b0) @(vif.mas_drv_cb);
      if (r_addr_que.size == 0) vif.arvalid <= 1'b0;
    end
  endtask

  task r_data_phase();
    @(vif.mas_drv_cb);
  endtask
endclass

`endif

