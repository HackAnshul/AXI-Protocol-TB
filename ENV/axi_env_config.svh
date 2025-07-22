class axi_env_config extends uvm_object;

  //uvm_active_passive_enum no_of_mas_agt;

  axi_mas_config mas_cfg;
  axi_slv_config slv_cfg;

  int has_mas_agt=1;
  int has_slv_agt=1;
  int has_scb=1;

  `uvm_object_utils_begin(axi_env_config)
  `uvm_object_utils_end

  function new(string name="axi_env_config");
    super.new(name);
  endfunction

endclass
