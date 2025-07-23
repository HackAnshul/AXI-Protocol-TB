TESTNAME='axi_test_sanity'
INCDIR=+incdir+../ENV/axi_slave +incdir+../ENV/axi_master +incdir+../ENV/axi_slave/slv_agnt +incdir+../ENV/axi_master/mas_agnt  +incdir+../ENV +incdir+../TEST
PKG=../ENV/axi_slave/slv_agnt/axi_slv_agt_pkg.sv ../ENV/axi_master/mas_agnt/axi_mas_agt_pkg.sv ../ENV/axi_slave/axi_slv_pkg.sv ../ENV/axi_master/axi_mas_pkg.sv ../ENV/axi_env_pkg.sv ../TEST/axi_test_pkg.sv
TOP_MOD=axi_tb_top
TOP=../TOP/axi_tb_top.sv

vlog:
	vlog $(RTL) $(PKG) $(TOP) $(INCDIR)

sim_cmd:
	vsim -voptargs=+acc $(TOP_MOD) -c -do "run -all;exit" +UVM_TESTNAME=$(TESTNAME)
sim_gui:
	vsim -voptargs=+acc $(TOP_MOD)
