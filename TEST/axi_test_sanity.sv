`ifndef AXI_TEST_SANITY_SV
`define AXI_TEST_SANITY_SV
class axi_test_sanity extends axi_base_test;
  `uvm_component_utils(axi_test_sanity)

  axi_mas_sanity_seqs mas_seq;
  axi_slv_sanity_seqs slv_seq;

  function new(string name = "axi_test_sanity", uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this,"TEST_SEQUENCE_STARTED");
    fork
      begin
        mas_seq = axi_mas_sanity_seqs::type_id::create("mas_seq");
        void'(mas_seq.randomize() with {no_of_itr == 10;});
        mas_seq.start(env_h.mas_agent.mas_seqr);
      end
      begin
        slv_seq = axi_slv_sanity_seqs::type_id::create("slv_seq");
        void'(slv_seq.randomize() with {no_of_itr == 10;});
        slv_seq.start(env_h.slv_agent.slv_seqr);
      end
    join
    phase.drop_objection(this,"TEST_SEQUENCE_ENDED");
  endtask
endclass
`endif
