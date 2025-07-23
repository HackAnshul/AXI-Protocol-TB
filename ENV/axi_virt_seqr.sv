`ifndef AXI_VIRT_SEQR
`define AXI_VIRT_SEQR
 class axi_virt_seqr extends uvm_sequencer #(uvm_sequence_item);

  //sub sequencer
  axi_mas_seqr mas_seqr;
  axi_slv_seqr slv_seqr;

    `uvm_component_utils_begin(axi_virt_seqr)
    `uvm_component_utils_end

    function new(string name="axi_virt_seqr",uvm_component parent = null);
      super.new(name,parent);
    endfunction
endclass
`endif
