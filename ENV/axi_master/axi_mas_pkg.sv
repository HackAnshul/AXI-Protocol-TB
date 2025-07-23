`ifndef AXI_MAS_PKG_SV
`define AXI_MAS_PKG_SV

`include "axi_defines.svh"
  `include "axi_mas_inf.sv"
package axi_mas_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

`include "axi_mas_defines.sv"
  //`include "axi_mas_config.svh"

  import axi_mas_agt_pkg::*;
endpackage
`endif
