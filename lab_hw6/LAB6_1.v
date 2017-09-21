`timescale 1ns / 1ps

 module LAB6_1(
    input clk,
 input [15:0] sw, 
   // LED Outputs
     output [15:0] led,
// Seven Segment Display Outputs
     output  [6:0] seg,   // Contents of output
     output [3:0] an,    //  Output Position, 1=Off. 0= On.
     output dp          // Dot point.
    
 );
//Untouch
wire [3:0] an;
wire [6:0] seg;
wire dp;

assign dp=1'b1;
assign an=4'b1110;
//Untouch

//please design 7-segment decoder here

wire A,B,C,D;
assign A=sw[3];
assign B=sw[2];
assign C=sw[1];
assign D=sw[0];


assign seg[0]=(A&C)|(A&B)|(B&~C&~D)|(~A&~B&~C&D);
assign seg[1]=(B&~C&D)|(A&B)|(A&C)|(B&C&~D);
assign seg[2]=(A&B)|(A&C)|(~B&C&~D);
assign seg[3]=(A&B)|(A&C)|(B&C&D)|(B&~C&~D)|(~A&~B&~C&D);
assign seg[4]=(B&~C)|(A&C)|(D);
assign seg[5]=(~A&~B&D)|(A&B)|(C&D)|(~B&C);
assign seg[6]=(A&B)|(A&C)|(~A&~B&~C)|(B&C&D);




endmodule