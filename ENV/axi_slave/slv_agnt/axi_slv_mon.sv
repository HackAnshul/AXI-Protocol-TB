/////HEADER

`ifndef AXI_SLV_MON_SV
`define AXI_SLV_MON_SV

class axi_slv_mon extends uvm_monitor;

  //factory registration
  `uvm_component_utils(axi_slv_mon);

  virtual axi_slv_inf vif;

  uvm_analysis_port #(axi_slv_seq_item) item_collected_port;

  //seq_item handle, used as a place holder for sampling signal
  axi_slv_seq_item trans_collected;

  function new(string name = "axi_slv_mon", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_port = new("item_collected_port",this);
  endfunction

  //run_phase
  task run_phase(uvm_phase phase);
    forever begin
      //sampling logic
      monitor(trans_collected);
      //broadcasting seq_item to scoreboard
      item_collected_port.write(trans_collected);
    end
  endtask


  //description
  task monitor(ref axi_slv_seq_item mon_item);

    mon_item = new();

  endtask
endclass

`endif

