////HEADER
`ifndef AXI_SCB_SV
`define AXI_SCB_SV

//analysis port using decl

class axi_scb extends uvm_component;

  //factory registration
  `uvm_component_utils(axi_scb);

  function new(string name = "axi_scb",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  //run_phase
  task run_phase(uvm_phase phase);
  endtask

endclass

`endif
