/////HEADER

`ifndef AXI_MAS_MON_SV
`define AXI_MAS_MON_SV

class axi_mas_mon extends uvm_monitor;

  //factory registration
  `uvm_component_utils(axi_mas_mon);

  //to receive
  axi_mas_seq_item w_addr_que [$];
  axi_mas_seq_item w_data_que [$];
  axi_mas_seq_item r_addr_que [$];
  axi_mas_seq_item r_data_que [$]; // not using
  axi_mas_seq_item w_resp_que [$]; // not using
  axi_mas_seq_item w_resp_arr [int];
  axi_mas_seq_item r_data_arr [int];

  //virtual interface
  virtual axi_mas_inf vif;

  //constructor
  function new(string name = "axi_mas_mon", uvm_component parent);
    super.new(name,parent);
  endfunction

  //analysis port (TODO connected to agent for scoreboard & sub)
  uvm_analysis_port #(axi_mas_seq_item) w_item_collected_port;
  uvm_analysis_port #(axi_mas_seq_item) r_item_collected_port;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    w_item_collected_port = new("w_item_collected_port",this);
    r_item_collected_port = new("r_item_collected_port",this);
  endfunction

  //run_phase
  task run_phase(uvm_phase phase);
    //primary task which calls other tasks and
    //combines the channels for write and read analysis ports
    monitor();
  endtask

  task w_addr_phase();
    axi_mas_seq_item item;
    forever begin
      @(vif.mas_mon_cb);
      if (vif.mas_mon_cb.awvalid == 1 && vif.mas_mon_cb.awready == 1) begin
        item=new();
        item.awid    = vif.mas_mon_cb.awid;
        item.awaddr  = vif.mas_mon_cb.awaddr;
        item.awlen   = vif.mas_mon_cb.awlen;
        item.awsize  = vif.mas_mon_cb.awsize;
        item.awburst = burst_t'(vif.mas_mon_cb.awburst);
        //
        w_addr_que.push_back(item);
      end
    end
  endtask

  task w_data_phase();
    axi_mas_seq_item item;
    bit [`DATA_WIDTH-1:0] temp_data;
    forever begin
      item=new();
      do begin
        @(vif.mas_mon_cb);
        if (vif.mas_mon_cb.wvalid == 1 && vif.mas_mon_cb.wready == 1) begin
          temp_data = '0;
          for (int i=0; i < (`DATA_WIDTH/8); i++) begin
            if (vif.mas_mon_cb.wstrb[i])   // only sampling bytes indicated by strobes
              temp_data[(i*8)+:8]  = vif.mas_mon_cb.wdata[(i*8)+:8];
          end
          item.wstrb.push_back(vif.mas_mon_cb.wstrb);
          item.wdata.push_back(temp_data);
        end
      end while (vif.mas_mon_cb.wlast == 1'b0);
      //
      if (vif.mas_mon_cb.wlast == 1'b1)
        w_data_que.push_back(item);
    end
  endtask

  task r_addr_phase();
    axi_mas_seq_item item;
    forever begin
      @(vif.mas_mon_cb);
      if (vif.mas_mon_cb.arvalid == 1 && vif.mas_mon_cb.arready == 1) begin
        item=new();
        item.arid    = vif.mas_mon_cb.arid;
        item.araddr  = vif.mas_mon_cb.araddr;
        item.arlen   = vif.mas_mon_cb.arlen;
        item.arsize  = vif.mas_mon_cb.arsize;
        item.arburst = burst_t'(vif.mas_mon_cb.arburst);
        //
        r_addr_que.push_back(item);
      end
    end
  endtask

  task r_data_phase();
    axi_mas_seq_item item;
    forever begin
      item=new();
      do begin
        @(vif.mas_mon_cb iff vif.mas_mon_cb.rvalid && vif.mas_mon_cb.rready);
        item.rresp.push_back(vif.mas_mon_cb.rresp);
        item.rdata.push_back(vif.mas_mon_cb.rdata);
        item.rid = vif.mas_mon_cb.rid;
      end while (vif.mas_mon_cb.rlast == 1'b0);
      //
      if (vif.mas_mon_cb.rlast == 1'b1)
        //r_data_que.push_back(item);
        r_data_arr[vif.mas_mon_cb.rid] = item;
    end
  endtask

  task w_resp_phase();
    axi_mas_seq_item item;
    forever begin
      @(vif.mas_mon_cb iff vif.mas_mon_cb.bvalid && vif.mas_mon_cb.bready);
      item = new();
      item.bid    = vif.mas_mon_cb.bid;
      item.bresp  = vif.mas_mon_cb.bresp;
      //
      w_resp_arr[vif.mas_mon_cb.bid] = item;
      w_resp_que.push_back(item);
    end
  endtask

  //monitor task
  task monitor();
    axi_mas_seq_item item_w, temp_w, send_w;
    axi_mas_seq_item item_r, temp_r, send_r;
    fork
      w_addr_phase();
      w_data_phase();
      w_resp_phase();
      r_addr_phase();
      r_data_phase();
    join_none

    fork
      forever begin
        wait (w_addr_que.size != 0);
        item_w = w_addr_que.pop_front();
        wait (w_data_que.size != 0);
        temp_w = w_data_que.pop_front();
        item_w.wstrb = temp_w.wstrb;
        item_w.wdata = temp_w.wdata;
        /*wait (w_resp_que.size != 0);
        temp_w = w_resp_que.pop_front();*/
        wait (w_resp_arr.exists(item_w.awid));
        temp_w = w_resp_arr[item_w.awid];
        w_resp_arr.delete(item_w.awid);
        item_w.bid   = temp_w.bid;
        item_w.bresp = temp_w.bresp;
        $cast(send_w,item_w.clone());
        `uvm_info(get_name(),$sformatf("mas write monitor\n%s",send_w.sprint()), UVM_LOW)
        w_item_collected_port.write(send_w);
      end
      forever begin
        wait (r_addr_que.size != 0);
        item_r = r_addr_que.pop_front();
        /*wait (r_data_que.size != 0);
        temp_r = r_data_que.pop_front();*/
        wait (r_data_arr.exists(item_r.arid));
        temp_r = r_data_arr[item_r.arid];
        r_data_arr.delete(item_r.arid);
        item_r.rdata = temp_r.rdata;
        item_w.rid   = temp_r.rid;
        item_r.rresp = temp_r.rresp;
        $cast(send_r,item_r.clone());
        `uvm_info(get_name(),$sformatf("mas read monitor\n%s",send_r.sprint()), UVM_LOW)
        r_item_collected_port.write(send_r);
      end
    join
  endtask
endclass

`endif

