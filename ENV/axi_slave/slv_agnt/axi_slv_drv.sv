/////HEADER

`ifndef AXI_SLV_DRV_SV
`define AXI_SLV_DRV_SV

class axi_slv_drv extends uvm_driver #(axi_slv_seq_item);

  //factory registration
  `uvm_component_utils(axi_slv_drv)

  //to receive
  axi_slv_seq_item w_addr_que [$];
  axi_slv_seq_item w_data_que [$];
  axi_slv_seq_item r_addr_que [$];

  //to send
  axi_slv_seq_item r_data_que [$];
  axi_slv_seq_item w_resp_que [$];

  //virtual interface
  virtual axi_slv_inf vif;

  //constructor
  function new(string name = "axi_slv_drv", uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    //fork
      forever begin
        @(vif.slv_drv_cb);
        seq_item_port.get(req);
        //req.print();
        //
        //w_resp_que.push_back(req);
        //r_data_que.push_back(req);
        //
        //$cast(rsp,req.clone());
        //rsp.set_id_info(req);
        //seq_item_port.put(rsp); // return the response to sequencer
      end
    //join_none
    //drive();
  endtask

  task drive();
    fork
      w_addr_phase();
      w_data_phase();
      r_addr_phase();
      r_data_phase();
      w_resp_phase();
    join
  endtask

  task w_addr_phase();
  endtask

  task w_data_phase();
  endtask

  task r_addr_phase();
  endtask

  task r_data_phase();
  endtask

  task w_resp_phase();
  endtask
endclass

`endif

