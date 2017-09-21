`timescale 1ns / 1ps
module LAB4(A, B, C, D, Y);
    input A, B, C, D;
    output Y;
    
    wire y1, y2, y3, y4;
     AND2 AND3_1(~C,~D,y1);
     AND2 AND2_2(~A,~D,y2);
     AND2 AND2_3(A,C,y3);
     
     OR3 OR4_1(y1,y2, y3, Y);
endmodule
