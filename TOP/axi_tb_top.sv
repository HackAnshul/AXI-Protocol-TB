`ifndef AXI_TB_TOP
`define AXI_TB_TOP
module axi_tb_top();
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import axi_test_pkg::*;
  bit clk, resetn;

  // Generate clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Take instance of actual interface
  axi_mas_inf mas_inf(clk,resetn);
  axi_slv_inf slv_inf(clk,resetn);

  /*assign mas_inf.wready = 1;
  assign mas_inf.rready = 1;
  assign mas_inf.awready = 1;
  assign mas_inf.arready = 1;
  assign mas_inf.bready = 1;
  assign mas_inf.bvalid = 1;
  assign mas_inf.rvalid = 1;*/

  // Instantiate design under test (DUT)
  // or connect with master and slave back to back
  // write address channel
  assign slv_inf.awid = mas_inf.awid;
  assign slv_inf.awaddr = mas_inf.awaddr;
  assign slv_inf.awlen = mas_inf.awlen;
  assign slv_inf.awsize = mas_inf.awsize;
  assign slv_inf.awburst = mas_inf.awburst;
  assign slv_inf.awvalid = mas_inf.awvalid;
  //assign mas_inf.awready = slv_inf.awready;
  assign mas_inf.awready = 1;
  assign slv_inf.awready = 1;

  // write data channel
  assign slv_inf.wid = mas_inf.wid;
  assign slv_inf.wdata = mas_inf.wdata;
  assign slv_inf.wstrb = mas_inf.wstrb;
  assign slv_inf.wlast = mas_inf.wlast;
  assign slv_inf.wvalid = mas_inf.wvalid;
  //assign mas_inf.wready = slv_inf.wready;
  assign mas_inf.wready = 1;
  assign slv_inf.wready = 1;

  // write response channel
  assign mas_inf.bid = slv_inf.bid;
  assign mas_inf.bresp = slv_inf.bresp;
  assign mas_inf.bvalid = slv_inf.bvalid;
  //assign mas_inf.bvalid = 1;
  //assign slv_inf.bvalid = 1;
  //assign slv_inf.bready = mas_inf.bready;
  assign mas_inf.bready = 1;
  assign slv_inf.bready = 1;

  // read address channel
  assign slv_inf.arid = mas_inf.arid;
  assign slv_inf.araddr = mas_inf.araddr;
  assign slv_inf.arlen = mas_inf.arlen;
  assign slv_inf.arsize = mas_inf.arsize;
  assign slv_inf.arburst = mas_inf.arburst;
  assign slv_inf.arvalid = mas_inf.arvalid;
  //assign mas_inf.arready = slv_inf.arready;
  assign mas_inf.arready = 1;
  assign slv_inf.arready = 1;

  // read data channel
  assign mas_inf.rid = slv_inf.rid;
  assign mas_inf.rdata = slv_inf.rdata;
  assign slv_inf.rresp = mas_inf.rresp;
  assign mas_inf.rlast = slv_inf.rlast;
  assign mas_inf.rvalid = slv_inf.rvalid;
  //assign slv_inf.rready = mas_inf.rready;
  assign slv_inf.rready = 1;
  assign mas_inf.rready = 1;

  initial begin
    fork
      uvm_config_db #(virtual axi_mas_inf)::set(null, "*", "m_vif", mas_inf);
      uvm_config_db #(virtual axi_slv_inf)::set(null, "*", "s_vif", slv_inf);

      reset(2);
      run_test();
    join
  end

  task reset(int delay =2);
    resetn = 0;
    repeat (2) @(posedge clk);
    resetn = 1;
  endtask
endmodule

`endif
