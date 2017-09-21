`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: ButtonFSM : The finite state machine for button debouncing
//////////////////////////////////////////////////////////////////////////////////


module ButtonFSM(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,            // 25 MHz clock
    input                   rst,            // Asynchronous reset
    input                   button,         // Physical button pressed (level sensitive)
    //====================================================
    //=======           Output                      ======
    //====================================================
    output                  debounced       // debouncing (edge sensitive)
    );
    

    //=======================================
    //=======          TODO            ======
    //=======================================
    wire w1[2:0];
    wire P;
    wire Q;
    wire R;
    
    
    assign w1[0] = (button&~P&~R) | (~button&P&~R);
    assign w1[1] = (~button&P&~Q&R) | (button&~P&~Q&R) | (~button&P&Q&~R) | (button&~P&Q&~R);
    assign w1[2] = (P&~Q) | (P&~R) | (~P&Q&R);
    
    DFF(P,w1[2],clk,rst);
    DFF(Q,w1[1],clk,rst);
    DFF(R,w1[0],clk,rst);
    
    assign debounced = (P&Q&R);
    
endmodule
