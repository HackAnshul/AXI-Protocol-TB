//HEADER
`ifndef AXI_DEFINES_SV
`define AXI_DEFINES_SV

`define ADDR_WIDTH 32
`define DATA_WIDTH 32
`define DRAIN_TIME 900000
`define ID_X_WIDTH 8
typedef enum bit [1:0] {FIXED,INCR,WRAP} burst_t;
typedef enum bit [1:0] {IDLE,READ,WRITE,RW} operation_t;

`endif
