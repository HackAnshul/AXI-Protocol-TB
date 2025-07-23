
 class axi_virt_seqr extends uvm_sequencer #(uvm_sequence_item);

  //sub sequencer
  axi_mas_seqr mas_seqr_h;
  axi_slv_seqr slv_seqr_h;

    `uvm_component_utils_begin(axi_virt_seqr)
    `uvm_component_utils_end

    function new(string name="axi_virt_seqr",uvm_component parent = null);
      super.new(name,parent);
    endfunction
endclass
