`ifndef AXI_SLV_CONFIG_SV
`define AXI_SLV_CONFIG_SV
class axi_slv_config extends uvm_object;

  `uvm_object_utils_begin(axi_slv_config)
  `uvm_object_utils_end

  function new(string name="axi_slv_config");
    super.new(name);
  endfunction

  uvm_active_passive_enum is_active = UVM_ACTIVE;
  bit has_fc_sub = 1;

  virtual axi_slv_inf vif;
endclass
`endif
