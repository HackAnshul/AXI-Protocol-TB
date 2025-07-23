`ifndef AXI_BASE_VIRT_SEQS
`define AXI_BASE_VIRT_SEQS
class axi_base_virt_seqs extends uvm_sequence #(uvm_sequence_item);

  `uvm_declare_p_sequencer(axi_virt_seqr)

  //sub sequencer
  axi_mas_seqr mas_seqr;
  axi_slv_seqr slv_seqr;

  `uvm_object_utils_begin(axi_base_virt_seqs)
  `uvm_object_utils_end

  function new(string name="axi_base_virt_seqs");
    super.new(name);
  endfunction

  task pre_start();
    mas_seqr = p_sequencer.mas_seqr;
    slv_seqr = p_sequencer.slv_seqr;
  endtask

endclass
`endif
