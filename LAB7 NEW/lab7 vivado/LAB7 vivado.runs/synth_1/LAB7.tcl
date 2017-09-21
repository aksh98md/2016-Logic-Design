# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 vivado.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 vivado.xpr} [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files -quiet {{c:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp}}]
read_verilog -library xil_defaultlib {
  {C:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 prob/lib.v}
  {C:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 prob/lab7/SSDR.v}
  {C:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 prob/lab7/don't touch/ssDisplayer.v}
  {C:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 prob/lab7/don't touch/LAB7.v}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 prob/PortDefine_basys3.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Albert/Desktop/logic  design/LAB7 NEW/lab7 vivado/LAB7 prob/PortDefine_basys3.xdc}}]


synth_design -top LAB7 -part xc7a35tcpg236-1


write_checkpoint -force -noxdef LAB7.dcp

catch { report_utilization -file LAB7_utilization_synth.rpt -pb LAB7_utilization_synth.pb }
