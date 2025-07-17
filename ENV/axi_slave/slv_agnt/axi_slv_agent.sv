/////HEADER

`ifndef AXI_SLV_AGENT_SV
`define AXI_SLV_AGENT_SV

class axi_slv_agent extends uvm_agent;

  //factory registration
  `uvm_component_utils(axi_slv_agent)

  // agent components
  virtual axi_slv_inf vif;
  axi_slv_drv  slv_drv;
  axi_slv_mon  slv_mon;
  axi_slv_seqr slv_seqr;

  axi_slv_config slv_cfg;

  //constructor
  function new(string name = "axi_slv_agent", uvm_component parent);
    super.new(name,parent);
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //if(!uvm_config_db #(axi_env_config)::get(this,"","env_cfg",env_cfg))
    //  `uvm_fatal(get_name(),"env_config_db get failed!")

    if(!uvm_config_db#(virtual axi_slv_inf)::get(this,"","m_vif", vif))
      `uvm_fatal("NO_VIF",{"virtual interface must be set for:",get_full_name()});

    //create agent components
    //if (env_cfg.is_active_wagt == UVM_ACTIVE) begin
    slv_drv = axi_slv_drv::type_id::create("slv_drv",this);
    slv_seqr = axi_slv_seqr::type_id::create("slv_seqr",this);
    //end
    slv_mon = axi_slv_mon::type_id::create("slv_mon",this);
  endfunction

  //connect_phase
  function void connect_phase(uvm_phase phase);
    mas_drv.vif = vif;
    mas_mon.vif = vif;
   // if (env_cfg.is_active_wagt == UVM_ACTIVE) begin
      //slv_drv.seq_item_port.connect(slv_seqr.seq_item_export);
    //end
  endfunction

endclass

`endif

