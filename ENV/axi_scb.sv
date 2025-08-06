////HEADER
`ifndef AXI_SCB_SV
`define AXI_SCB_SV

//analysis port using decl
`uvm_analysis_imp_decl(_mas_w)
`uvm_analysis_imp_decl(_mas_r)
`uvm_analysis_imp_decl(_slv_w)
`uvm_analysis_imp_decl(_slv_r)

class axi_scb extends uvm_component;

  //factory registration
  `uvm_component_utils(axi_scb);

  uvm_analysis_imp_mas_w #(axi_mas_seq_item, axi_scb) item_collected_imp_mas_w;
  uvm_analysis_imp_mas_r #(axi_mas_seq_item, axi_scb) item_collected_imp_mas_r;

  uvm_analysis_imp_slv_w #(axi_slv_seq_item, axi_scb) item_collected_imp_slv_w;
  uvm_analysis_imp_slv_r #(axi_slv_seq_item, axi_scb) item_collected_imp_slv_r;

  function new(string name = "axi_scb",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_imp_mas_w = new("item_collected_imp_mas_w",this);
    item_collected_imp_mas_r = new("item_collected_imp_mas_r",this);
    item_collected_imp_slv_w = new("item_collected_imp_slv_w",this);
    item_collected_imp_slv_r = new("item_collected_imp_slv_r",this);
  endfunction

  //run_phase
  task run_phase(uvm_phase phase);
  endtask

  function void write_mas_w(axi_mas_seq_item item);
  endfunction

  function void write_mas_r(axi_mas_seq_item item);
  endfunction

  function void write_slv_w(axi_slv_seq_item item);
  endfunction

  function void write_slv_r(axi_slv_seq_item item);
  endfunction

endclass

`endif
