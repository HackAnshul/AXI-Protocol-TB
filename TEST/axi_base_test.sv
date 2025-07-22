////HEADER
`ifndef AXI_BASE_TEST_SV
`define AXI_BASE_TEST_SV

class axi_base_test extends uvm_test;

  //factory registration
  `uvm_component_utils(axi_base_test);

  //declare env components
  axi_env env_h;

  //config class
  axi_env_config env_cfg;
  axi_mas_config mas_cfg;
  axi_slv_config slv_cfg;

  //constructor
  function new(string name = "axi_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    env_cfg = axi_env_config::type_id::create("env_cfg");
    mas_cfg = axi_mas_config::type_id::create("mas_cfg");
    slv_cfg = axi_slv_config::type_id::create("slv_cfg");

    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi_mas_inf)::get(this,"","m_vif", mas_cfg.vif))
      `uvm_fatal("NO_VIF",{"virtual interface must be set for:",get_full_name()});

    if(!uvm_config_db#(virtual axi_slv_inf)::get(this,"","s_vif", slv_cfg.vif))
      `uvm_fatal("NO_VIF",{"virtual interface must be set for:",get_full_name()});

    env_cfg.mas_cfg = mas_cfg;
    env_cfg.slv_cfg = slv_cfg;

    uvm_config_db #(axi_env_config)::set(null,"*","env_cfg",env_cfg);

    env_h = axi_env::type_id::create("env_h",this);

  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

  //run_phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    #100;
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,20ns);
  endtask

  function void report_phase(uvm_phase phase);
    uvm_report_server server_h;
    int err_cnt, fatal_cnt;

    server_h = uvm_report_server::get_server();

    err_cnt = server_h.get_severity_count(UVM_ERROR);
    fatal_cnt = server_h.get_severity_count(UVM_FATAL);


   $display("err_cnt = %0d",err_cnt);
   $display("fatal_cnt = %0d",fatal_cnt);

  // if (err_cnt+fatal_cnt == 0 && pass_count > 0)
    //PASS
   //else
    //FAIL

  endfunction

endclass

`endif
