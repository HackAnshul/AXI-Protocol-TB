
 class ram_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

    
    //sub sequencer
    ram_wseqr wseqr_h;
    ram_rseqr rseqr_h;

    `uvm_component_utils_begin(ram_virtual_sequencer)
    `uvm_component_utils_end

     function new(string name,uvm_component parent = null);
       super.new(name,parent);
     endfunction
endclass 



