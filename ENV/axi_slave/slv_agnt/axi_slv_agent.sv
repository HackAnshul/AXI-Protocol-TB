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

  // analysis port (to be assigned to monitor's analysis port)
  uvm_analysis_port#( axi_slv_seq_item ) mas_ap;

  // master slave config (set from env, contains vif set from base test)
  axi_slv_config slv_cfg;

  //constructor
  function new(string name = "axi_slv_agent", uvm_component parent);
    super.new(name,parent);
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(axi_slv_config)::get(this,"","slv_cfg",slv_cfg))
      `uvm_fatal(get_name(),"config_db get failed in slave agent")

    //create agent components
    if (slv_cfg.is_active == UVM_ACTIVE) begin
      slv_drv = axi_slv_drv::type_id::create("slv_drv",this);
      slv_seqr = axi_slv_seqr::type_id::create("slv_seqr",this);
    end
    slv_mon = axi_slv_mon::type_id::create("slv_mon",this);
  endfunction

  //connect_phase
  function void connect_phase(uvm_phase phase);
    if (slv_cfg.is_active == UVM_ACTIVE) begin
      slv_drv.vif = slv_cfg.vif;
      slv_drv.seq_item_port.connect(slv_seqr.seq_item_export);
    end

    slv_mon.vif = slv_cfg.vif;
    //slv_ap = slv_mon.mas_ap;
  endfunction

endclass

`endif

