/////HEADER

`ifndef AXI_MAS_AGENT_SV
`define AXI_MAS_AGENT_SV

class axi_mas_agent extends uvm_agent;

  //factory registration
  `uvm_component_utils(axi_mas_agent)

  // agent components
  axi_mas_drv  mas_drv;
  axi_mas_mon  mas_mon;
  axi_mas_seqr mas_seqr;

  axi_env_config env_cfg;

  //constructor
  function new(string name = "axi_mas_agent", uvm_component parent);
    super.new(name,parent);
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //if(!uvm_config_db #(axi_env_config)::get(this,"","env_cfg",env_cfg))
    //  `uvm_fatal(get_name(),"env_config_db get failed!")

    //create agent components
    //if (env_cfg.is_active_wagt == UVM_ACTIVE) begin
    mas_drv = axi_mas_drv::type_id::create("mas_drv",this);
    mas_seqr = axi_mas_seqr::type_id::create("mas_seqr",this);
   // end
    mas_mon = axi_mas_mon::type_id::create("mas_mon",this);
  endfunction

  //connect_phase
  function void connect_phase(uvm_phase phase);
   // if (env_cfg.is_active_wagt == UVM_ACTIVE) begin
      w_driver.seq_item_port.connect(w_sequencer.seq_item_export);
    //end
  endfunction

endclass

`endif

