module axi_tb_top();
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import axi_test_pkg::*;
  bit clk;

  // Generate clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Take instance of actual interface
  axi_mas_inf mas_inf(clk);
  axi_slv_inf slv_inf(clk);

  // Instantiate design under test (DUT)
  // or connect with master and slave back to back

  initial begin

    uvm_config_db #(virtual axi_mas_inf)::set(null, "*", "mas_vif", mas_inf);
    uvm_config_db #(virtual axi_slv_inf)::set(null, "*", "slv_vif", slv_inf);

    run_test();
  end
endmodule
