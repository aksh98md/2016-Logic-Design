// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module LAB8(clk, sw, btnU, btnD, btnR, btnL, seg, dp, an, led);
  input clk;
  input [15:0]sw;
  input btnU;
  input btnD;
  input btnR;
  input btnL;
  output [6:0]seg;
  output dp;
  output [3:0]an;
  output [15:0]led;
endmodule
