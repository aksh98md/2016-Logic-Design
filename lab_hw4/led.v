`timescale 1ns / 1ps


module LED( 
        sw,led
    );
    input [3:0] sw;
    output [1:0] led;
    wire A, B, C, D, Y;
    LAB4 LAB4(A, B, C, D, Y);
    assign sw = {D, C, B, A};
    assign led[0] = Y;
    assign led[1] = 0;
endmodule

