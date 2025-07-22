/////HEADER

`ifndef AXI_MAS_AGENT_SV
`define AXI_MAS_AGENT_SV

class axi_mas_agent extends uvm_agent;

  //factory registration
  `uvm_component_utils(axi_mas_agent)

  // agent components
  virtual axi_mas_inf vif;
  axi_mas_drv  mas_drv;
  axi_mas_mon  mas_mon;
  axi_mas_seqr mas_seqr;

  // analysis port (to be assigned to monitor's analysis port)
  uvm_analysis_port#( axi_mas_seq_item ) mas_ap;

  // master agent config (set from env, contains vif set from base test)
  axi_mas_config mas_cfg;

  //constructor
  function new(string name = "axi_mas_agent", uvm_component parent);
    super.new(name,parent);
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(axi_mas_config)::get(this,"","mas_cfg",mas_cfg))
      `uvm_fatal(get_name(),"config_db get failed in master agent")

    //create agent components
    if (mas_cfg.is_active == UVM_ACTIVE) begin
      mas_drv = axi_mas_drv::type_id::create("mas_drv",this);
      mas_seqr = axi_mas_seqr::type_id::create("mas_seqr",this);
    end
    mas_mon = axi_mas_mon::type_id::create("mas_mon",this);
  endfunction

  //connect_phase
  function void connect_phase(uvm_phase phase);
    if (mas_cfg.is_active == UVM_ACTIVE) begin
      mas_drv.vif = mas_cfg.vif;
      mas_drv.seq_item_port.connect(mas_seqr.seq_item_export);
    end

    mas_mon.vif = mas_cfg.vif;
    //mas_ap = mas_mon.mas_ap;

  endfunction

endclass

`endif

