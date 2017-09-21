`timescale 1ns / 1ps
module LAB5(A, B, C, D, Y);
    input A, B, C,D;
    output Y;
    
    wire y1, y2, y3;
	
    NAND2(~C, ~D, y1);
    NAND2(~A, ~B, y2);
    NAND2(A, C, y3);
    NAND3(y1, y2, y3, Y);
endmodule
