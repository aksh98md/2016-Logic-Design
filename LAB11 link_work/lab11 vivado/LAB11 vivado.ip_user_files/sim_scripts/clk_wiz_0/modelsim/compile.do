vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../ipstatic/LAB11 link_work/lab11 vivado/LAB11 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/LAB11 link_work/lab11 vivado/LAB11 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_1" \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic/LAB11 link_work/lab11 vivado/LAB11 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_1" "+incdir+../../../ipstatic/LAB11 link_work/lab11 vivado/LAB11 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_1" \
"../../../../LAB11 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_sim_netlist.v" \


vlog -work xil_defaultlib "glbl.v"

