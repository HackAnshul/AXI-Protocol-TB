
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
    forever begin
      `uvm_create(item_send)
      p_sequencer.mreq_fifo_w.get(item_w);
      p_sequencer.mreq_fifo_r.get(item_r);
      item_send.bid = item_w.awid;
      item_send.rid = item_r.arid;
      axi_write();
      axi_read();
      item_send.bresp = '0;
      foreach (item_send.rresp[i]) item_send.rresp[i] = '0;
      //repeat(no_of_itr) begin
      //req = axi_slv_seq_item::type_id::create("req");
      $cast(req,item_send.clone());
      `uvm_send(req)
    end
  endtask
endclass

`endif
