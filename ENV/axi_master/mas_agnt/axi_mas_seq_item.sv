//////HEADER

`ifndef AXI_MAS_SEQ_ITEM_SV
`define AXI_MAS_SEQ_ITEM_SV
typedef enum bit [1:0] {IDLE,READ,WRITE,RW} operation_t;

//class  axi_mas_seq_item #(int ADDR_WIDTH = 32, DATA_WIDTH = 32, ID_W_WIDTH = 8, ID_R_WIDTH = 8) extends uvm_sequence_item;
class  axi_mas_seq_item extends uvm_sequence_item;

  //write address channel signals (to be sent)
  rand bit [`ID_X_WIDTH-1:0]awid;
  rand bit [`ADDR_WIDTH-1:0]awaddr;
  rand bit [7:0]awlen;
  rand bit [2:0]awsize;
  rand bit [1:0]awburst;
  //bit awvalid;
  //bit awready;

  //write data channel signals (to be send)
  rand bit [`ID_X_WIDTH-1:0]wid;
  rand bit [`DATA_WIDTH-1:0]wdata[$];
  rand bit [`DATA_WIDTH/8:0]wstrb[$];
  //rand bit wlast;
  //bit wvalid;
  //bit wready;

  //write response channel signals (to be received)
  bit [`ID_X_WIDTH-1:0]bid;
  bit [1:0]bresp;
  //bit bvalid;
  //bit bready;

  //read address channel signals (to be sent)
  rand bit [`ID_X_WIDTH-1:0]arid;
  rand bit [`ADDR_WIDTH-1:0]araddr;
  rand bit [7:0]arlen;
  rand bit [2:0]arsize;
  rand bit [1:0]arburst;
  //bit arvalid;
  //bit arready;

  //read data channel signals (to be received)
  bit [`ID_X_WIDTH-1:0]rid;
  bit [`DATA_WIDTH-1:0]rdata[$];
  bit [1:0]rresp;
  //bit rlast;
  //bit rvalid;
  //bit rready;

  rand operation_t opr;


  `uvm_object_utils_begin(axi_mas_seq_item)
    `uvm_field_int(awid, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(awaddr, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(awlen, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(awsize, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(awburst, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(awvalid, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(awready, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(wid, UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(wdata, UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(wstrb, UVM_ALL_ON | UVM_DEC)
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
    `uvm_field_int(arburst, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(arvalid, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(arready, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(rid, UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(rdata, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(rresp, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(rlast, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(rvalid, UVM_ALL_ON | UVM_DEC)
    //`uvm_field_int(rready, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  function new(string name = "axi_mas_seq_item");
    super.new(name);
  endfunction

  //CONSTRAINTS
  //to select which data to generate according to operation //implemented in driver

  //for burst length according to axburst
  constraint brst_len_cnt {
    awlen inside {[0:5]};

  }

  //for wdata/rdata queue
  constraint queue_data {
    wdata.size == awlen + 1;
    wstrb.size == awlen + 1;
  }

  //for 4k bytes boundary
  constraint addr_in_4k {
    awaddr%4096 + (awlen + (1 << awsize)) <= 4096;
    araddr%4096 + (arlen + (1 << arsize)) <= 4096;
  }

  local bit [`ID_X_WIDTH-1:0] awid_prev;
  local bit [`ID_X_WIDTH-1:0] arid_prev;
  constraint diff_consecutive_id {
    soft awid != awid_prev;
    soft arid != arid_prev;
  }
  //to limit axsize according to data width
  constraint axsize_limit {
    awsize inside {[0:$clog2(`DATA_WIDTH)]};
  }
  //write strobe
  //local rand int offset;
  /*constraint strb{
    solve awaddr before wstrb;
    solve awsize before wstrb;
    solve awlen before wstrb;
    if (`DATA_WIDTH == (1 << awsize)){
      awaddr % (`DATA_WIDTH/8)  == offset;
    } else {

    }
  }*/

  function void post_randomize();
    awid_prev = awid;
    arid_prev = arid;
    /*foreach (wstrb[i]) wstrb[i] == '1;
    wstrb[0] = wstrb[0] << offset;*/
  endfunction
endclass

`endif
