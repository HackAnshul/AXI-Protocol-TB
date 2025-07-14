//////////////////////////////////
////HEADER
//Company_name - Scaledge
//File_name - ram_defines.sv
//Author name - Maitri Soni 
//Intreface name - ram_defines
//Description - Define_all_the_signal's_width 
//version, date, time

/////////////////////////////////////

//Gaurd Statment to avoid multiple compilation of a file
`ifndef RAM_DEFINES_SV
`define RAM_DEFINES_SV
//typedef RAM_DEFINES_SV

`define ADDR_WIDTH 8
`define DATA_WIDTH 8
`define WAIT 2
`define DRAIN_TIME 900000
typedef enum bit [1:0] {IDLE, READ, WRITE, SIM_RW} trans_kind;

`endif

