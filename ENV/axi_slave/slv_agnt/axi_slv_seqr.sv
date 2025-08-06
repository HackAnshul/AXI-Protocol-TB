/////HEADER

`ifndef AXI_SLV_SEQR_SV
`define AXI_SLV_SEQR_SV

class axi_slv_seqr extends uvm_sequencer #(axi_slv_seq_item);

  //factory registration
  `uvm_component_utils(axi_slv_seqr)

  uvm_analysis_export   #(axi_slv_seq_item) item_collected_export_w;
  uvm_tlm_analysis_fifo #(axi_slv_seq_item) mreq_fifo_w;
  uvm_analysis_export   #(axi_slv_seq_item) item_collected_export_r;
  uvm_tlm_analysis_fifo #(axi_slv_seq_item) mreq_fifo_r;

  //constructor
  function new(string name = "axi_slv_seqr", uvm_component parent);
    super.new(name,parent);
    item_collected_export_w = new("item_collected_export_w",this);
    item_collected_export_r = new("item_collected_export_r",this);
    mreq_fifo_w = new("mreq_fifo_w",this);
    mreq_fifo_r = new("mreq_fifo_r",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Connect sub-components if needed
    item_collected_export_w.connect(mreq_fifo_w.analysis_export);
    item_collected_export_r.connect(mreq_fifo_r.analysis_export);
  endfunction
endclass

`endif
