vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../ipstatic/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_1" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_1" \
"../../../../LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.v" \


vlog -work xil_defaultlib "glbl.v"

