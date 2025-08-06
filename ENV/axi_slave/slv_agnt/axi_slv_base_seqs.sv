////HEADER
`ifndef AXI_SLV_BASE_SEQS_SV
`define AXI_SLV_BASE_SEQS_SV

class axi_slv_base_seqs extends uvm_sequence #(axi_slv_seq_item);

  rand int no_of_itr;

  bit [`DATA_WIDTH-1:0] axi_mem [int];
  axi_slv_seq_item item_w,item_r, item_send;

  constraint ITR_CNST {soft no_of_itr == 20;}

  `uvm_object_utils_begin(axi_slv_base_seqs)
    `uvm_field_int(no_of_itr, UVM_ALL_ON | UVM_UNSIGNED)
  `uvm_object_utils_end

  `uvm_declare_p_sequencer(axi_slv_seqr)

  //constructor
  function new(string name = "axi_slv_base_seqs");
    super.new(name);
  endfunction

  /*task pre_body();
    `uvm_create(item_send)
    fork
      begin
        `uvm_create(item_w)
        p_sequencer.mreq_fifo_w.get(item_w);
        item_send.bid = item_w.awid;
        axi_write();
        item_send.bresp = '0;
      end
      begin
        `uvm_create(item_r)
        p_sequencer.mreq_fifo_r.get(item_r);
        item_send.rid = item_w.arid;
        axi_read();
        foreach (item_send.rresp[i]) item_send.rresp[i] = '0;
      end
    join

  endtask*/

  //task to write in axi_mem
  task axi_write();
  endtask
  //task to read in axi_mem
  task axi_read();
  endtask
  //task axi_read(bit [`ADDR_WIDTH-1:0] addr, output bit[`DATA_WIDTH-1:0] data[$]);
endclass

`endif
