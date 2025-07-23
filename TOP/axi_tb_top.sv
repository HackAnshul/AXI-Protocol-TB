`ifndef AXI_TB_TOP
`define AXI_TB_TOP
module axi_tb_top();
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import axi_test_pkg::*;
  bit clk,resetn;

  // Generate clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Take instance of actual interface
  axi_mas_inf mas_inf(clk,resetn);
  axi_slv_inf slv_inf(clk,resetn);

  // Instantiate design under test (DUT)
  // or connect with master and slave back to back

  initial begin

    uvm_config_db #(virtual axi_mas_inf)::set(null, "*", "m_vif", mas_inf);
    uvm_config_db #(virtual axi_slv_inf)::set(null, "*", "s_vif", slv_inf);

    run_test();
  end
endmodule
`endif
