TESTNAME=''

vlog:
	vlog +incdir+../ENV +incdir+../TEST +incdir+../ENV/w_agent +incdir+../ENV/r_agent ../RTL/ram_16x8.sv ../TEST/ram_test_pkg.sv ../TOP/ram_tb_top.sv  

vlog_pkg:
	vlog +incdir+../ENV +incdir+../TEST +incdir+../ENV/w_agent +incdir+../ENV/r_agent ../RTL/ram_16x8.sv ../ENV/w_agent/ram_wagent_pkg.sv ../ENV/r_agent/ram_ragent_pkg.sv ../ENV/ram_env_pkg.sv ../TEST/ram_test_pkg.sv ../TOP/ram_tb_top.sv  

sim_cmd:
	vsim -voptargs=+acc ram_tb_top -c -do "run -all;exit" +UVM_TESTNAME=$(TESTNAME)
sim_gui:
	vsim -voptargs=+acc ram_tb_top 
