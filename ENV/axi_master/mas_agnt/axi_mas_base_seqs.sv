////HEADER
`ifndef AXI_MAS_BASE_SEQS_SV
`define AXI_MAS_BASE_SEQS_SV

class axi_mas_base_seqs extends uvm_sequence #(axi_mas_seq_item);

  rand int no_of_itr;

  constraint ITR_CNST {soft no_of_itr == 20;}

  `uvm_object_utils_begin(axi_mas_base_seqs)
    `uvm_field_int(no_of_itr, UVM_ALL_ON | UVM_UNSIGNED)
  `uvm_object_utils_end

  //constructor
  function new(string name = "axi_mas_base_seqs");
    super.new(name);
  endfunction

  //method to generate stimulus
  /*task body();
    repeat(10) begin
      req = ram_seq_item_w::type_id::create("req");
      start_item(req);
      if(!req.randomize() with {kind_e == WRITE; wr_data inside {[1:50]};})
        `uvm_error("WSEQ","FAILED")
      finish_item(req);
    end
  endtask*/
endclass

`endif
