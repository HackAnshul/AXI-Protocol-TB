////HEADER
///////////////////////////////////////////////
////
////Company_Name   : Scaledge
////Author_Name    : Maitri_soni
////File_Name      : ram_env.sv
////File_Path      : 
////
////Class_Name    : ram_env       
////Project_Name   : Dual_port_RAM
////Description    : 

////////////////////////////////////////////////
////Gaurd Statment to avoid multiple compilation of a file
`ifndef RAM_ENV_SV
`define RAM_ENV_SV
//typedef RAM_ENV_SV

class ram_env extends uvm_env;

  //factory registration
  `uvm_component_utils(ram_env)

  //declare agents and scoreboard
  ram_wagent w_agent;
  ram_ragent r_agent;
  ram_scoreboard scb;

  ram_virtual_sequencer vseqr_h;

  //constructor
  function new(string name = "ram_env", uvm_component parent);
    super.new(name,parent);
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    w_agent = ram_wagent::type_id::create("w_agent",this);
    r_agent = ram_ragent::type_id::create("r_agent",this);
    scb = ram_scoreboard::type_id::create("scb",this);
    vseqr_h = ram_virtual_sequencer::type_id::create("vseqr_h",this);
  endfunction

  //connect_phase
  function void connect_phase(uvm_phase phase);
    w_agent.w_monitor.item_collected_port.connect(scb.item_collected_export_w);
    r_agent.r_monitor.item_collected_port.connect(scb.item_collected_export_r);

    vseqr_h.wseqr_h = w_agent.w_sequencer;
    vseqr_h.rseqr_h = r_agent.r_sequencer;
  endfunction

endclass

`endif
