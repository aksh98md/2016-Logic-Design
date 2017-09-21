vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../ipstatic/clk_wiz_v5_3_0" "+incdir+../../../ipstatic/LAB9/LAB9/LAB9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_0" "+incdir+../../../ipstatic/clk_wiz_v5_3_0" "+incdir+../../../ipstatic/LAB9/LAB9/LAB9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_0" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic/clk_wiz_v5_3_0" "+incdir+../../../ipstatic/LAB9/LAB9/LAB9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_0" "+incdir+../../../ipstatic/clk_wiz_v5_3_0" "+incdir+../../../ipstatic/LAB9/LAB9/LAB9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_v5_3_0" \
"../../../../LAB9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v" \
"../../../../LAB9.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.v" \

vlog -work xil_defaultlib "glbl.v"

