
 class axi_virt_seqr extends uvm_sequencer #(uvm_sequence_item);

    //sub sequencer

    `uvm_component_utils_begin(axi_virt_seqr)
    `uvm_component_utils_end

    function new(string name,uvm_component parent = null);
      super.new(name,parent);
    endfunction
endclass
