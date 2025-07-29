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
  uvm_analysis_port #(axi_mas_seq_item) item_collected_port;

  //seq_item handle, used as a place holder for sampling signal
  axi_mas_seq_item trans_collected;


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_port = new("item_collected_port",this);
  endfunction

  //run_phase
  task run_phase(uvm_phase phase);
    fork
      w_addr_phase();
      w_data_phase();
      w_resp_phase();
      r_addr_phase();
      r_data_phase();
    join_none

    forever begin
      @(vif.mas_mon_cb);
      //sampling logic
      monitor(trans_collected);
      //broadcasting seq_item to scoreboard
      item_collected_port.write(trans_collected);
    end
  endtask


  //description
  task monitor(ref axi_mas_seq_item mon_item);

    mon_item = new();

  endtask
endclass

`endif

