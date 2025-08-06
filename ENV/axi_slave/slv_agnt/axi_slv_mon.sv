/////HEADER

`ifndef AXI_SLV_MON_SV
`define AXI_SLV_MON_SV

class axi_slv_mon extends uvm_monitor;

  //factory registration
  `uvm_component_utils(axi_slv_mon);

  //to receive
  axi_slv_seq_item w_addr_que[$];
  axi_slv_seq_item w_data_que[$];
  axi_slv_seq_item r_addr_que[$];
  axi_slv_seq_item r_data_que[$];
  axi_slv_seq_item w_resp_que[$];
  axi_slv_seq_item w_resp_arr[int];

  int awid_que[$];
  int arid_que[$];

  //virtual interface
  virtual axi_slv_inf vif;


  axi_slv_seq_item mon_item[int][$];

  //constructor
  function new(string name = "axi_slv_mon", uvm_component parent);
    super.new(name,parent);
  endfunction

  //analysis port (TODO connected to agent for scoreboard & sub)
  uvm_analysis_port #(axi_slv_seq_item) w_item_collected_port;
  uvm_analysis_port #(axi_slv_seq_item) r_item_collected_port;

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
    axi_slv_seq_item item;
    forever begin
      @(vif.slv_mon_cb iff vif.slv_mon_cb.awvalid && vif.slv_mon_cb.awready);
      item = new();
      item.awid    = vif.slv_mon_cb.awid;
      item.awaddr  = vif.slv_mon_cb.awaddr;
      item.awlen   = vif.slv_mon_cb.awlen;
      item.awsize  = vif.slv_mon_cb.awsize;
      item.awburst = burst_t'(vif.slv_mon_cb.awburst);
      //
      awid_que.push_back(vif.slv_mon_cb.awid);
      //if (!mon_item.exists(vif.slv_mon_cb.awild))
      //mon_item[vif.slv_mon_cb.awild].push_back(item);
      w_addr_que.push_back(item);
      end
    //end
  endtask

  task w_data_phase();
    axi_slv_seq_item item;
    int wid;
    bit [`DATA_WIDTH-1:0] temp_data;
    forever begin
      item=new();
      do begin
        @(vif.slv_mon_cb iff vif.slv_mon_cb.wvalid && vif.slv_mon_cb.wready);
        temp_data = '0;
        for (int i=0; i < (`DATA_WIDTH/8); i++) begin
          if (vif.slv_mon_cb.wstrb[i])   // only sampling bytes indicated by strobes
            temp_data[(i*8)+:8]  = vif.slv_mon_cb.wdata[(i*8)+:8];
        end
        item.wstrb.push_back(vif.slv_mon_cb.wstrb);
        item.wdata.push_back(temp_data);
      end while (vif.slv_mon_cb.wlast == 1'b0);
      //
      if (vif.slv_mon_cb.wlast == 1'b1)
        w_data_que.push_back(item);
      //wait(awid_que.size != 0);
      //wid = awid_que.pop_front();
    end
  endtask

  task w_resp_phase();
    axi_slv_seq_item item;
    forever begin
      @(vif.slv_mon_cb iff vif.slv_mon_cb.bvalid && vif.slv_mon_cb.bready);
      item = new();
      item.bid    = vif.slv_mon_cb.bid;
      item.bresp  = vif.slv_mon_cb.bresp;
      //
      w_resp_arr[vif.slv_mon_cb.bid] = item;
      w_resp_que.push_back(item);
    end
  endtask

  task r_addr_phase();
    axi_slv_seq_item item;
    forever begin
      @(vif.slv_mon_cb iff vif.slv_mon_cb.arvalid && vif.slv_mon_cb.arready);
      item=new();
      item.arid    = vif.slv_mon_cb.arid;
      item.araddr  = vif.slv_mon_cb.araddr;
      item.arlen   = vif.slv_mon_cb.arlen;
      item.arsize  = vif.slv_mon_cb.arsize;
      item.arburst = burst_t'(vif.slv_mon_cb.arburst);
      //
      arid_que.push_back(vif.slv_mon_cb.arid);
      r_addr_que.push_back(item);
    end
  endtask

  task r_data_phase();
    axi_slv_seq_item item;
    forever begin
      item=new();
      do begin
        @(vif.slv_mon_cb);
        if (vif.slv_mon_cb.rvalid == 1 && vif.slv_mon_cb.rready == 1) begin
          item.rresp.push_back(vif.slv_mon_cb.rresp);
          item.rdata.push_back(vif.slv_mon_cb.rdata);
          item.rid = vif.slv_mon_cb.rid;
        end
      end while (vif.slv_mon_cb.rlast == 1'b0);
      //
      if (vif.slv_mon_cb.rlast == 1'b1)
        r_data_que.push_back(item);
    end
  endtask


  task monitor();
    axi_slv_seq_item item_w, temp_w, send_w;
    axi_slv_seq_item item_r, temp_r, send_r;
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
        temp_w = w_resp_que.pop_front();
        item_w.bid   = temp_w.bid;
        item_w.bresp = temp_w.bresp;
        wait (w_resp_arr.exists(item_w.awid));
        temp_w = w_resp_arr[item_w.awid];*/
        $cast(send_w,item_w.clone());
        `uvm_info(get_name(),$sformatf("slv write monitor\n%s",send_w.sprint()), UVM_LOW)

        w_item_collected_port.write(send_w);
      end
      forever begin
        wait (r_addr_que.size != 0);
        item_r = r_addr_que.pop_front();
        /*wait (r_data_que.size != 0);
        temp_r = r_data_que.pop_front();
        item_r.rdata = temp_r.rdata;
        item_w.rid   = temp_r.rid;
        item_r.rresp = temp_r.rresp;*/
        $cast(send_r,item_r.clone());
        `uvm_info(get_name(),$sformatf("slv read monitor\n%s",send_r.sprint()), UVM_LOW)
        r_item_collected_port.write(send_r);
      end
    join
  endtask
endclass

`endif

