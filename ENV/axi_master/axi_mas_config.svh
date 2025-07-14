class axi_mas_config extends uvm_object;

     uvm_active_passive_enum is_active_wagt;
     uvm_active_passive_enum is_active_ragt;

    `uvm_object_utils_begin(axi_mas_config)
    `uvm_object_utils_end

    function new(string name="");
      super.new(name);
    endfunction

endclass
