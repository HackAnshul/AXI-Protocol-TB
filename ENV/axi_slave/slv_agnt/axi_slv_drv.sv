/////HEADER

`ifndef AXI_SLV_DRV_SV
`define AXI_SLV_DRV_SV

class axi_slv_drv extends uvm_driver #(axi_slv_seq_item);

  //factory registration
  `uvm_component_utils(axi_slv_drv)

  axi_slv_seq_item addr_que [$];
  axi_slv_seq_item data_que [$];

  //virtual interface
  virtual axi_slv_inf vif;

  //constructor
  function new(string name = "axi_slv_drv", uvm_component parent);
    super.new(name,parent);
  endfunction

  // function void build_phase(uvm_phase phase);
  //   super.build_phase(phase);
  // endfunction

  task run_phase(uvm_phase phase);
    fork
      forever begin
        seq_item_port.get(req); //req-dafault handle of seq_item
        req.print();
        //
        addr_que.push_back(req);
        data_que.push_back(req);
        //
        $cast(rsp,req.clone());
        rsp.set_id_info(req);
      end
    join_none
    drive();
  endtask

  task drive();
    fork
      addr_phase();
      data_phase();
    join
  endtask

  task addr_phase();
  endtask

  task data_phase();
  endtask
endclass

`endif

