class axi_base_virt_seqs extends uvm_sequence #(uvm_sequence_item);

  `uvm_declare_p_sequencer(axi_virt_seqr)

  //sub sequencer
  axi_mas_seqr mas_seqr_h;
  axi_slv_seqr slv_seqr_h;

  `uvm_object_utils_begin(axi_base_virt_seqs)
  `uvm_object_utils_end

  function new(string name="axi_base_virt_seqs");
    super.new(name);
  endfunction

  task pre_start();
    mas_seqr_h = p_sequencer.mas_seqr_h;
    slv_seqr_h = p_sequencer.slv_seqr_h;
  endtask

endclass
