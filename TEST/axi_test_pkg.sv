`ifndef AXI_TEST_PKG
`define AXI_TEST_PKG

package axi_test_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "axi_defines.svh"
 // `include "ram_env_pkg.sv"
  import axi_mas_agt_pkg::*;
  import axi_slv_agt_pkg::*;
  import axi_mas_pkg::*;
  import axi_slv_pkg::*;
  import axi_env_pkg::*;
//  `include "axi_env_config.svh"

  `include "axi_base_test.sv"

  //testcases go below

  //sanity test
  `include "axi_mas_sanity_seqs.sv"
  `include "axi_slv_sanity_seqs.sv"
  `include "axi_test_sanity.sv"


endpackage
`endif
