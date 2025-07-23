
`ifndef AXI_SLV_SANITY_SEQS_SV
`define AXI_SLV_SANITY_SEQS_SV

class axi_slv_sanity_seqs extends axi_slv_base_seqs;

  `uvm_object_utils(axi_slv_sanity_seqs)

  //constructor
  function new(string name = "axi_slv_sanity_seqs");
    super.new(name);
  endfunction

  //method to generate stimulus
  task body();
    repeat(no_of_itr) begin
      req = axi_slv_seq_item::type_id::create("req");
      start_item(req);
      if(!req.randomize() with {})
        `uvm_error("SLV_SEQ","FAILED")
      finish_item(req);
    end
  endtask
endclass

`endif
