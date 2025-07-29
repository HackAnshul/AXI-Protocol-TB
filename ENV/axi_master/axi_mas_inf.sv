`ifndef AXI_MAS_INF_SV
`define AXI_MAS_INF_SV

//interface axi_mas_inf #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32, ID_W_WIDTH = 8, ID_R_WIDTH = 8) (input aclk, aresetn);
interface axi_mas_inf (input aclk, aresetn);

  //write address channel signals
  logic [`ID_X_WIDTH-1:0]awid;   //write address id
  logic [`ADDR_WIDTH-1:0]awaddr; //write address
  logic [7:0]awlen;              //write burst length
  logic [2:0]awsize;             //write burst size
  logic [1:0]awburst;            //write burst type
  logic awvalid;                 //write address valid
  logic awready;                 //write address ready

  //write data channel signals
  logic [`ID_X_WIDTH-1:0]wid;    //write data id
  logic [`DATA_WIDTH-1:0]wdata;  //write data
  logic [`DATA_WIDTH/8:0]wstrb;  //write strobes
  logic wlast;                   //write last
  logic wvalid;                  //write data valid
  logic wready;                  //write data ready

  //write response channel signals
  logic [`ID_X_WIDTH-1:0]bid;    //write response id
  logic [1:0]bresp;              //write response
  logic bvalid;                  //write response valid
  logic bready;                  //write response ready

  //read address channel signals
  logic [`ID_X_WIDTH-1:0]arid;   //read address id
  logic [`ADDR_WIDTH-1:0]araddr; //read address
  logic [7:0]arlen;              //read burst length
  logic [2:0]arsize;             //read burst size
  logic [1:0]arburst;            //read burst type
  logic arvalid;                 //read address valid
  logic arready;                 //read address ready

  //read data channel signals
  logic [`ID_X_WIDTH-1:0]rid;    //read data id
  logic [`DATA_WIDTH-1:0]rdata;  //read data
  logic [1:0]rresp;              //read response
  logic rlast;                   //read last
  logic rvalid;                  //read valid
  logic rready;                  //read ready

  //clocking block for slave driver
  clocking mas_drv_cb @(posedge aclk or negedge aresetn);
    default input #1 output #1;
    output awid, awaddr, awlen, awsize, awburst, awvalid;
    output wid, wdata, wstrb, wlast, wvalid;
    output arid, araddr, arlen, arsize, arburst, arvalid;
    output bready, rready;
    input awready, wready, bid, bresp, bvalid, arready;
    input rid, rdata, rresp, rlast, rvalid;
  endclocking

  //clocking block for slave monitor
  clocking mas_mon_cb @(posedge aclk or negedge aresetn);
    default input #1 output #1;
    input awid, awaddr, awlen, awsize, awburst, awvalid;
    input wid, wdata, wstrb, wlast, wvalid;
    input bready, rready;
    input arid, araddr, arlen, arsize, arburst, arvalid;
    input awready, wready, bid, bresp, bvalid, arready;
    input rid, rdata, rresp, rlast, rvalid;
  endclocking

  modport MAS_DRV_MP (clocking mas_drv_cb, input aclk, input aresetn);
  modport MAS_MON_MP (clocking mas_mon_cb, input aclk, input aresetn);

  task wait_reset_assert();
    wait (aresetn == 0);
  endtask
  task wait_reset_release();
    wait (aresetn == 1);
  endtask
  task aw_valid_task(int no_of_cycles);
    awvalid <= 1'b0;
    repeat(no_of_cycles) @(posedge aclk);
  endtask

endinterface

`endif
