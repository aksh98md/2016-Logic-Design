//`timescale 1ns/1ps
////////////////////////////////////////////// INV
module INV(in, out);
	output out;
    input in;
	
	assign out = ~ in;
endmodule

////////////////////////////////////////////// AND2
module AND2(A,B,Y);
    output Y;
    input A, B;
     
	assign Y = A & B;
endmodule

////////////////////////////////////////////// OR2
module OR2(A,B,Y);
    output Y;
    input A, B;
	
	assign Y = A | B;
endmodule

////////////////////////////////////////////// NAND2
module NAND2(A,B,Y);
    output Y;
    input A, B;
     
	assign Y = ~(A & B);
endmodule

////////////////////////////////////////////// NOR2

module NOR2(A,B,Y);
    output Y;
    input A,B;
     
	assign Y = ~(A | B);
endmodule

////////////////////////////////////////////// XOR2
module XOR2(A,B,Y);
    output Y;
    input A, B;
    
	assign Y = A ^ B;
endmodule

//////////////////////////////////////////////XNOR2
module XNOR2(A,B,Y);
    output Y;
    input A,B;
    
	assign Y = ~(A ^ B);
endmodule
////////////////////////////////////////////// AND3
module AND3(A,B,C,Y);
    output Y;
    input A, B, C;
     
	assign Y = A & B & C;
endmodule
////////////////////////////////////////////// AND4
module AND4(A,B,C,D,Y);
    output Y;
    input A, B, C, D;
     
	assign Y = A & B & C & D;
endmodule

////////////////////////////////////////////// OR3
module OR3(A,B,C,Y);
    output Y;
    input A, B, C;
	
	assign Y = A | B | C;
endmodule

////////////////////////////////////////////// OR4
module OR4(A,B,C,D,Y);
    output Y;
    input A, B, C, D;
	
	assign Y = A | B | C | D;
endmodule