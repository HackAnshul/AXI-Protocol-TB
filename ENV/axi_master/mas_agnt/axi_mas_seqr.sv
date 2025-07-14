/////HEADER

`ifndef AXI_MAS_SEQR_SV
`define AXI_MAS_SEQR_SV

class axi_mas_seqr extends uvm_sequencer #(axi_mas_seq_item);

  //factory registration
  `uvm_component_utils(axi_mas_seqr)

  //constructor
  function new(string name = "axi_mas_seqr", uvm_component parent);
    super.new(name,parent);
  endfunction

endclass

`endif
