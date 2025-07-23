`ifndef AXI_SLV_AGENT_PKG_SV
`define AXI_SLV_AGENT_PKG_SV
package axi_slv_agt_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "axi_defines.svh"
  `include "axi_slv_config.svh"
  `include "axi_slv_seq_item.sv"
  `include "axi_slv_seqr.sv"
  `include "axi_slv_drv.sv"
  `include "axi_slv_mon.sv"
  `include "axi_slv_agent.sv"

  `include "axi_slv_base_seqs.sv"
endpackage
`endif
