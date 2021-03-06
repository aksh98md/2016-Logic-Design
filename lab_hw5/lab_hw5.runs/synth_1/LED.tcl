# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Albert/Desktop/logic  design/lab_hw5/lab_hw5.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Albert/Desktop/logic  design/lab_hw5/lab_hw5.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {
  {C:/Users/Albert/Desktop/logic  design/lab_hw5/lib.v}
  {C:/Users/Albert/Desktop/logic  design/lab_hw5/lab5.v}
  {C:/Users/Albert/Desktop/logic  design/lab_hw5/led.v}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Albert/Desktop/logic  design/lab_hw5/Basys3_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Albert/Desktop/logic  design/lab_hw5/Basys3_Master.xdc}}]


synth_design -top LED -part xc7a35tcpg236-1


write_checkpoint -force -noxdef LED.dcp

catch { report_utilization -file LED_utilization_synth.rpt -pb LED_utilization_synth.pb }
