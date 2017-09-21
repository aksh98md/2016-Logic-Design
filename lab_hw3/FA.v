`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/02 17:04:41
// Design Name: 
// Module Name: FA
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


    module FA(a, b, c, sum, carry);
    input a, b, c;
    output sum, carry;
    
    wire [1:0] w;
    XOR2(.A(a),.B(b),.Y(w[0]));
    XOR2(.A(w[0]),.B(c),.Y(sum));
    
    wire [4:0] w1;
    AND2(.A(a),.B(b),.Y(w1[0]));
    AND2(.A(b),.B(c),.Y(w1[1]));
    AND2(.A(c),.B(a),.Y(w1[2]));
    OR2(.A(w1[0]),.B(w1[1]),.Y(w1[3]));
    OR2(.A(w1[2]),.B(w1[3]),.Y(carry));
   
    
    
    /*
	please finish your circuit here
	*/
endmodule
