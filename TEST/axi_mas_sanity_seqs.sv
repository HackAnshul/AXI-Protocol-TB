
`ifndef AXI_MAS_SANITY_SEQS_SV
`define AXI_MAS_SANITY_SEQS_SV

class axi_mas_sanity_seqs extends axi_mas_base_seqs;

  `uvm_object_utils(axi_mas_sanity_seqs)

  //constructor
  function new(string name = "axi_mas_sanity_seqs");
    super.new(name);
  endfunction

  //method to generate stimulus
  task body();
    repeat(no_of_itr) begin
      req = axi_mas_seq_item::type_id::create("req");
      start_item(req);
      if(!req.randomize() with {opr == RW; })
        `uvm_error("MAS_SEQ","FAILED")
      finish_item(req);
    end
  endtask
endclass

`endif
