proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir {C:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.cache/wt} [current_project]
  set_property parent.project_path {C:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.xpr} [current_project]
  set_property ip_repo_paths {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.cache/ip}} [current_project]
  set_property ip_output_repo {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.cache/ip}} [current_project]
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  add_files -quiet {{C:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.runs/synth_1/LAB7.dcp}}
  add_files -quiet {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp}}
  set_property netlist_only true [get_files {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp}}]
  read_xdc -mode out_of_context -ref clk_wiz_0 -cells inst {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc}}
  set_property processing_order EARLY [get_files {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc}}]
  read_xdc -prop_thru_buffers -ref clk_wiz_0 -cells inst {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc}}
  set_property processing_order EARLY [get_files {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc}}]
  read_xdc -ref clk_wiz_0 -cells inst {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc}}
  set_property processing_order EARLY [get_files {{c:/Users/Albert/Desktop/logic  design/LAB7 link/lab7 vivado/LAB7 vivado.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc}}]
  read_xdc {{C:/Users/Albert/Desktop/logic  design/LAB7 link/共享/FlipLD/課前準備/LAB文件/LAB7/LAB7 link/LAB7 prob/PortDefine_basys3.xdc}}
  link_design -top LAB7 -part xc7a35tcpg236-1
  write_hwdef -file LAB7.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force LAB7_opt.dcp
  report_drc -file LAB7_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force LAB7_placed.dcp
  report_io -file LAB7_io_placed.rpt
  report_utilization -file LAB7_utilization_placed.rpt -pb LAB7_utilization_placed.pb
  report_control_sets -verbose -file LAB7_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force LAB7_routed.dcp
  report_drc -file LAB7_drc_routed.rpt -pb LAB7_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file LAB7_timing_summary_routed.rpt -rpx LAB7_timing_summary_routed.rpx
  report_power -file LAB7_power_routed.rpt -pb LAB7_power_summary_routed.pb -rpx LAB7_power_routed.rpx
  report_route_status -file LAB7_route_status.rpt -pb LAB7_route_status.pb
  report_clock_utilization -file LAB7_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force LAB7.mmi }
  write_bitstream -force LAB7.bit 
  catch { write_sysdef -hwdef LAB7.hwdef -bitfile LAB7.bit -meminfo LAB7.mmi -file LAB7.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

