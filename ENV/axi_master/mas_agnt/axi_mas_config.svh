class axi_mas_config extends uvm_object;

  `uvm_object_utils_begin(axi_mas_config)
  `uvm_object_utils_end

  function new(string name="axi_mas_config");
    super.new(name);
  endfunction

  uvm_active_passive_enum is_active = UVM_ACTIVE;
  bit has_fc_sub = 1;

  virtual axi_mas_inf vif;

endclass
