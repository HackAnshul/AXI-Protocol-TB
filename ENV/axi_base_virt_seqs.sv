class axi_base_virt_seqs extends uvm_sequence #(uvm_sequence_item);

  //`uvm_declare_p_sequencer(axi_virt_seqr)
  //ram_virtual_sequencer p_sequencer;

  //sub sequencer
  //axi_mas_seqr wseqr_h;
  //axi_slv_seqr rseqr_h;

  `uvm_object_utils_begin(axi_virt_seqr)
  `uvm_object_utils_end

  function new(string name="axi_base_virt_seqs");
    super.new(name);
  endfunction

  /*task pre_start();
  task pre_body();
  task body();
    if(!$cast(p_sequencer,m_sequencer))
    if(!$cast(vseqr_h,m_sequencer))
      `uvm_fatal(get_full_name(),"virtual sequencer cast failed!")

    wseqr_h = p_sequencer.wseqr_h;
    rseqr_h = p_sequencer.rseqr_h;
  endtask*/

endclass
