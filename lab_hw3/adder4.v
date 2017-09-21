`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/02 11:16:50
// Design Name: 
// Module Name: adder4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder4(
    sw,
    led
    );
    
   // sw[3:0] is the first number, sw[8:5] is the second number, sw[4] is not used
    input [8:0] sw;
    output [4:0] led;
    
    wire [4:0] wsw;
        
        XOR2(.A(sw[4]),.B(sw[0]),.Y(wsw[0]));
        XOR2(.A(sw[4]),.B(sw[1]),.Y(wsw[1]));
        XOR2(.A(sw[4]),.B(sw[2]),.Y(wsw[2]));
        XOR2(.A(sw[4]),.B(sw[3]),.Y(wsw[3]));
        
    wire [3:0] wi;
    FA(.a(wsw[0]), .b(sw[5]), .c(sw[4]), .sum(led[0]), .carry(wi[0]));
    FA(.a(wsw[1]), .b(sw[6]), .c(wi[0]), .sum(led[1]), .carry(wi[1]));
    FA(.a(wsw[2]), .b(sw[7]), .c(wi[1]), .sum(led[2]), .carry(wi[2]));
    FA(.a(wsw[3]), .b(sw[8]), .c(wi[2]), .sum(led[3]), .carry(led[4]));
    
    
   /*
   please declare the wire you need and connect the FA module the finish a 4-bit adder
   */
    
    
    
endmodule
