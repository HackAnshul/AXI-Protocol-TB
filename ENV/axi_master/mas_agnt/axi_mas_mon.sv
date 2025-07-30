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
  axi_mas_seq_item r_data_que [$];
  axi_mas_seq_item w_resp_que [$];

  //virtual interface
  virtual axi_mas_inf vif;

  //constructor
  function new(string name = "axi_mas_mon", uvm_component parent);
    super.new(name,parent);
  endfunction

  //analysis port (TODO connected to agent for scoreboard & sub)
  uvm_analysis_port #(axi_mas_seq_item) w_item_collected_port;
  uvm_analysis_port #(axi_mas_seq_item) r_item_collected_port;

  //seq_item handle, used as a place holder for sampling signal


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_port = new("item_collected_port",this);
  endfunction

  //run_phase
  task run_phase(uvm_phase phase);

    //sampling logic
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
        item.awburst = vif.mas_mon_cb.awburst;
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
          item.wstrb.push_back(vif.mas.mon_cb.wstrb);
          item.wdata.push_back(temp_data);
        end
      end while (vif.mas_mon_cb.wlast == 1'b0);
      //
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
        item.arburst = vif.mas_mon_cb.arburst;
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
        @(vif.mas_mon_cb);
        if (vif.mas_mon_cb.rvalid == 1 && vif.mas_mon_cb.rready == 1) begin
          item.rresp.push_back(vif.mas_mon_cb.rresp);
          item.rdata.push_back(vif.mas_mon_cb.rdata);
          item.rid = vif.mas_mon_cb.rid;
        end
      end while (vif.mas_mon_cb.rlast == 1'b0);
      //
      w_data_que.push_back(item);
    end
  endtask

  task w_resp_phase();
    axi_mas_seq_item item;
    forever begin
      @(vif.mas_mon_cb);
      if (vif.mas_mon_cb.bvalid == 1 && vif.mas_mon_cb.bready == 1) begin
        item=new();
        item.bid    = vif.mas_mon_cb.bid;
        item.bresp  = vif.mas_mon_cb.bresp;
        //
        w_resp_que.push_back(item);
      end
    end
  endtask

  //monitor task
  task monitor(ref axi_mas_seq_item mon_item);
    fork
      w_addr_phase();
      w_data_phase();
      w_resp_phase();
      r_addr_phase();
      r_data_phase();
    join_none
    axi_mas_seq_item item_w, temp_w, send_w;
    axi_mas_seq_item item_r, temp_r, send_r;

    fork
      forever begin
        wait (w_addr_que.size != 0);
        item_w = w_addr_que.pop_front();
        wait (w_data_que.size != 0);
        temp_w = w_data_que.pop_front();
        item_w.wstrb = temp_w.wstrb;
        item_w.wdata = temp_w.wdata;
        wait (w_resp_que.size != 0);
        temp_w = w_resp_que.pop_front();
        item_w.bid   = temp_w.bid;
        item_w.bresp = temp_w.bresp;
        $cast(send_w,item_w.clone());
        w_item_collected_port.write(send_w);
      end
      forever begin
        wait (r_addr_que.size != 0);
        item_r = r_addr_que.pop_front();
        wait (r_data_que.size != 0);
        temp_r = r_data_que.pop_front();
        item_r.rdata = temp_w.rdata;
        item_w.rid   = temp_w.rid;
        item_r.rresp = temp_w.rresp;
        $cast(send_r,item_r.clone());
        r_item_collected_port.write(send_r);
      end
    join
  endtask
endclass

`endif

