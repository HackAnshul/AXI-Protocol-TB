# Load your design - skip if already loaded outside
# vsim work.axi_tb_top_name

# Clear the waveform window
#delete wave *
# Add Master interface signals to group
#add wave -group "Master Interface" -radix hex \
#    sim:/axi_tb_top/mas_inf/*
# Add Slave interface signals to group
#add wave -group "Slave Interface" -radix hex \
#    sim:/axi_tb_top/slv_inf/*

# Clear previous waveform
delete wave *
add wave -group "Global Signals"  \
    sim:/axi_tb_top/clk \
    sim:/axi_tb_top/resetn

# === MASTER INTERFACE ===

# Group: Master Interface
# ------------------------

# AW Channel
add wave -group "Master Interface" -group "AW Channel" -radix hex \
    sim:/axi_tb_top/mas_inf/awvalid \
    sim:/axi_tb_top/mas_inf/awready \
    sim:/axi_tb_top/mas_inf/awaddr \
    sim:/axi_tb_top/mas_inf/awid \
    sim:/axi_tb_top/mas_inf/awlen \
    sim:/axi_tb_top/mas_inf/awsize \
    sim:/axi_tb_top/mas_inf/awburst
#    sim:/axi_tb_top/mas_inf/awprot \
#    sim:/axi_tb_top/mas_inf/awlock \
#    sim:/axi_tb_top/mas_inf/awcache \
#    sim:/axi_tb_top/mas_inf/awqos

# W Channel
add wave -group "Master Interface" -group "W Channel" -radix hex \
    sim:/axi_tb_top/mas_inf/wvalid \
    sim:/axi_tb_top/mas_inf/wready \
    sim:/axi_tb_top/mas_inf/wdata \
    sim:/axi_tb_top/mas_inf/wstrb \
    sim:/axi_tb_top/mas_inf/wlast
#    sim:/axi_tb_top/mas_inf/wid

# B Channel
add wave -group "Master Interface" -group "B Channel" -radix hex \
    sim:/axi_tb_top/mas_inf/bvalid \
    sim:/axi_tb_top/mas_inf/bready \
    sim:/axi_tb_top/mas_inf/bresp \
    sim:/axi_tb_top/mas_inf/bid

# AR Channel
add wave -group "Master Interface" -group "AR Channel" -radix hex \
    sim:/axi_tb_top/mas_inf/arvalid \
    sim:/axi_tb_top/mas_inf/arready \
    sim:/axi_tb_top/mas_inf/araddr \
    sim:/axi_tb_top/mas_inf/arid \
    sim:/axi_tb_top/mas_inf/arlen \
    sim:/axi_tb_top/mas_inf/arsize \
    sim:/axi_tb_top/mas_inf/arburst
#    sim:/axi_tb_top/mas_inf/arprot \
#    sim:/axi_tb_top/mas_inf/arlock \
#    sim:/axi_tb_top/mas_inf/arcache \
#    sim:/axi_tb_top/mas_inf/arqos

# R Channel
add wave -group "Master Interface" -group "R Channel" -radix hex \
    sim:/axi_tb_top/mas_inf/rvalid \
    sim:/axi_tb_top/mas_inf/rready \
    sim:/axi_tb_top/mas_inf/rdata \
    sim:/axi_tb_top/mas_inf/rresp \
    sim:/axi_tb_top/mas_inf/rlast \
    sim:/axi_tb_top/mas_inf/rid

# === SLAVE INTERFACE ===

# Group: Slave Interface
# ------------------------

# AW Channel
add wave -group "Slave Interface" -group "AW Channel" -radix hex \
    sim:/axi_tb_top/slv_inf/awvalid \
    sim:/axi_tb_top/slv_inf/awready \
    sim:/axi_tb_top/slv_inf/awaddr \
    sim:/axi_tb_top/slv_inf/awid \
    sim:/axi_tb_top/slv_inf/awlen \
    sim:/axi_tb_top/slv_inf/awsize \
    sim:/axi_tb_top/slv_inf/awburst
#    sim:/axi_tb_top/slv_inf/awlock \
#    sim:/axi_tb_top/slv_inf/awprot \
#    sim:/axi_tb_top/slv_inf/awcache \
#    sim:/axi_tb_top/slv_inf/awqos


# W Channel
add wave -group "Slave Interface" -group "W Channel" -radix hex \
    sim:/axi_tb_top/slv_inf/wvalid \
    sim:/axi_tb_top/slv_inf/wready \
    sim:/axi_tb_top/slv_inf/wdata \
    sim:/axi_tb_top/slv_inf/wstrb \
    sim:/axi_tb_top/slv_inf/wlast
#    sim:/axi_tb_top/slv_inf/wid

# B Channel
add wave -group "Slave Interface" -group "B Channel" -radix hex \
    sim:/axi_tb_top/slv_inf/bvalid \
    sim:/axi_tb_top/slv_inf/bready \
    sim:/axi_tb_top/slv_inf/bresp \
    sim:/axi_tb_top/slv_inf/bid

# AR Channel
add wave -group "Slave Interface" -group "AR Channel" -radix hex \
    sim:/axi_tb_top/slv_inf/arvalid \
    sim:/axi_tb_top/slv_inf/arready \
    sim:/axi_tb_top/slv_inf/araddr \
    sim:/axi_tb_top/slv_inf/arid \
    sim:/axi_tb_top/slv_inf/arlen \
    sim:/axi_tb_top/slv_inf/arsize \
    sim:/axi_tb_top/slv_inf/arburst
#    sim:/axi_tb_top/slv_inf/arprot \
#    sim:/axi_tb_top/slv_inf/arlock \
#    sim:/axi_tb_top/slv_inf/arcache \
#    sim:/axi_tb_top/slv_inf/arqos

# R Channel
add wave -group "Slave Interface" -group "R Channel" -radix hex \
    sim:/axi_tb_top/slv_inf/rvalid \
    sim:/axi_tb_top/slv_inf/rready \
    sim:/axi_tb_top/slv_inf/rdata \
    sim:/axi_tb_top/slv_inf/rresp \
    sim:/axi_tb_top/slv_inf/rlast \
    sim:/axi_tb_top/slv_inf/rid

# Optional: Run simulation
# run 1us

