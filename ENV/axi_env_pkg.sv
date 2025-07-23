`ifndef AXI_ENVPKG_SV
`define AXI_ENVPKG_SV
package axi_env_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import axi_mas_agt_pkg::*;
  import axi_slv_agt_pkg::*;
  import axi_mas_pkg::*;
  import axi_slv_pkg::*;


  `include "axi_defines.svh"
  `include "axi_virt_seqr.sv"
  `include "axi_base_virt_seqs.sv"

  `include "axi_env_config.svh"
  `include "axi_scb.sv"
  `include "axi_env.sv"

endpackage
`endif

