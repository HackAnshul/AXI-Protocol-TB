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

  //constructor
  function new(string name = "axi_base_test", uvm_component parent);
    super.new(name,parent);
    env_cfg = axi_env_config::type_id::create("env_cfg");
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    uvm_config_db #(axi_env_config)::set(this,"*","env_cfg",env_cfg);
    env_h = axi_env::type_id::create("env_h",this);
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
