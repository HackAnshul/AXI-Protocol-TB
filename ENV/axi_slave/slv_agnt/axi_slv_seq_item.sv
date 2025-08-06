////HEADER

`ifndef AXI_SLV_SEQ_ITEM_SV
`define AXI_SLV_SEQ_ITEM_SV

//class  axi_slv_seq_item #(int ADDR_WIDTH = 32, DATA_WIDTH = 32, ID_W_WIDTH = 8, ID_R_WIDTH = 8) extends uvm_sequence_item;
class  axi_slv_seq_item extends uvm_sequence_item;

  //write address channel signals (to be received)
  bit [`ID_X_WIDTH-1:0]awid;
  bit [`ADDR_WIDTH-1:0]awaddr;
  bit [7:0]awlen;
  bit [2:0]awsize;
  burst_t awburst;
  //bit awvalid;
  //bit awready;

  //write data channel signals (to be received)
  bit [`ID_X_WIDTH-1:0]wid;
  bit [`DATA_WIDTH-1:0]wdata[$];
  bit [`DATA_WIDTH/8:0]wstrb[$];
  //rand bit wlast;
  //bit wvalid;
  //bit wready;

  //write response channel signals (to be sent)
  bit [`ID_X_WIDTH-1:0]bid;
  bit [1:0]bresp;
  //bit bvalid;
  //bit bready;

  //read address channel signals (to be received)
  bit [`ID_X_WIDTH-1:0]arid;
  bit [`ADDR_WIDTH-1:0]araddr;
  bit [7:0]arlen;
  bit [2:0]arsize;
  burst_t arburst;
  //bit arvalid;
  //bit arready;

  //read data channel signals (to be sent)
  bit [`ID_X_WIDTH-1:0]rid;
  bit [`DATA_WIDTH-1:0]rdata[$];
  bit [1:0]rresp[$];
  //bit rlast;
  //bit rvalid;
  //bit rready;

  operation_t opr;

  `uvm_object_utils_begin(axi_slv_seq_item)
    `uvm_field_int(awid, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(awaddr, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(awlen, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(awsize, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum(burst_t, awburst, UVM_ALL_ON)
    //`uvm_field_int(awvalid, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(awready, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(wid, UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(wdata, UVM_ALL_ON | UVM_HEX)
    `uvm_field_queue_int(wstrb, UVM_ALL_ON | UVM_BIN)
    //`uvm_field_int(wlast, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(wvalid, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(wready, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(bid, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(bresp, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(bvalid, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(bready, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(arid, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(araddr, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(arlen, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(arsize, UVM_ALL_ON | UVM_DEC)
    `uvm_field_enum(burst_t, arburst, UVM_ALL_ON)
    //`uvm_field_int(arvalid, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(arready, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(rid, UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(rdata, UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(rresp, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(rlast, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(rvalid, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(rready, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  function new(string name = "axi_slv_seq_item");
    super.new(name);
  endfunction

endclass

`endif
