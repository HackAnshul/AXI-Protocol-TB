////HEADER
`ifndef RAM_ENV_SV
`define RAM_ENV_SV

class axi_env extends uvm_env;

  //factory registration
  `uvm_component_utils(axi_env)

  //declare agents and scoreboard
  axi_mas_agent mas_agent;
  axi_slv_agent slv_agent;
  axi_scb scb;

  axi_virt_seqr vseqr_h;

  //constructor
  function new(string name = "ram_env", uvm_component parent);
    super.new(name,parent);
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mas_agent = axi_mas_agent::type_id::create("mas_agent",this);
    slv_agent = axi_slv_agent::type_id::create("slv_agent",this);
    scb = axi_scb::type_id::create("scb",this);
    vseqr_h = axi_virt_seqr::type_id::create("vseqr_h",this);
  endfunction

  //connect_phase
  function void connect_phase(uvm_phase phase);
    //w_agent.w_monitor.item_collected_port.connect(scb.item_collected_export_w);
    //r_agent.r_monitor.item_collected_port.connect(scb.item_collected_export_r);

    //vseqr_h.wseqr_h = w_agent.w_sequencer;
    //vseqr_h.rseqr_h = r_agent.r_sequencer;
  endfunction

endclass

`endif
