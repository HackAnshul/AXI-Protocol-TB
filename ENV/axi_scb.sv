////HEADER
///////////////////////////////////////////////
////
////Company_Name   : Scaledge
////Author_Name    : Maitri_soni
////File_Name      : ram_scoreboard.sv
////File_Path      : 
////
////Class_Name    : ram_scoreboard      
////Project_Name   : Dual_port_RAM
////Description    : 

////////////////////////////////////////////////
////Gaurd Statment to avoid multiple compilation of a file
`ifndef RAM_SCOREBARD_SV
`define RAM_SCOREBOARD_SV
//typedef RAM_SCOREBOARD_SV

//analysis port using decl
`uvm_analysis_imp_decl(_wmonitor)
`uvm_analysis_imp_decl(_rmonitor)

class ram_scoreboard extends uvm_component;

  //factory registration
  `uvm_component_utils(ram_scoreboard);

  //declare analysis ports
  uvm_analysis_imp_wmonitor #(ram_seq_item_w, ram_scoreboard) item_collected_export_w;
  uvm_analysis_imp_rmonitor #(ram_seq_item_r, ram_scoreboard) item_collected_export_r;

  //constructor
  function new(string name = "ram_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction

  //build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export_w = new("item_collected_export_w",this);
    item_collected_export_r = new("item_collected_export_r",this);
  endfunction

  //write method
  function void write_wmonitor(ref ram_seq_item_w req);
    `uvm_info("SCB","Write packet received!",UVM_NONE)
   // `uvm_info("SCBW",$sformatf("req = %p", req),UVM_MEDIUM)
    //req.print();
  endfunction

  //write method
  function void write_rmonitor(ref ram_seq_item_r req);
    `uvm_info("SCB","Read packet received!",UVM_NONE)
   // `uvm_info("SCBR",$sformatf("req = %p", req),UVM_MEDIUM)
   // req.print();
  endfunction

  //run_phase
  task run_phase(uvm_phase phase);
    //comparison logic
  endtask

endclass

`endif


  
