/////HEADER

`ifndef AXI_SLV_SEQR_SV
`define AXI_SLV_SEQR_SV

class axi_slv_seqr extends uvm_sequencer #(axi_slv_seq_item);

  //factory registration
  `uvm_component_utils(axi_slv_seqr)

  //constructor
  function new(string name = "axi_slv_seqr", uvm_component parent);
    super.new(name,parent);
  endfunction

endclass

`endif
