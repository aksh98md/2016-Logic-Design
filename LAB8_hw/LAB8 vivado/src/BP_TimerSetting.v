`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: BP_TimerSetting for LAB8
//////////////////////////////////////////////////////////////////////////////////

module BP_TimerSetting(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,            // 25 MHz clock
    input                   rst,            // Asynchronous reset
    input                   debounced_U,    // Debounced Up     Button
    input                   debounced_D,    // Debounced Down   Button
    input                   debounced_R,    // Debounced Right  Button
    input                   debounced_L,    // Debounced Left   Button
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------7 segment display-----
	output     [3:0]        cur_sec,	
	output     led
    );
    
    //===================================================
    //=======       TODO                            =====
   
        wire A,B,C,D;
        wire a,b,c,d;
        wire [3:0] w0;
        wire [3:0] w1;
        wire judge;
        wire w2;
        wire ww;
        wire [7:0] wi;
        
        
        //左邊的dff 
        DFF(A,wi[0],clk,rst);
        DFF(B,wi[1],clk,rst);
        DFF(C,wi[2],clk,rst);
        DFF(D,wi[3],clk,rst);
        
        //右邊的dff 
        DFF(a,wi[4],clk,rst);
        DFF(b,wi[5],clk,rst);
        DFF(c,wi[6],clk,rst);
        DFF(d,wi[7],clk,rst); 
        
        
        //a,b,c,d,A,B,C,D上面的MUX
        MUX21(judge,A,a,cur_sec[0]);
        MUX21(judge,B,b,cur_sec[1]);
        MUX21(judge,C,c,cur_sec[2]);
        MUX21(judge,D,d,cur_sec[3]);
             
                
        //DFF  input 前的mux
        wire [7:0] wm;
        MUX21(judge,w0[0],A,wi[0]);
        MUX21(judge,w0[1],B,wi[1]);
        MUX21(judge,w0[2],C,wi[2]);
        MUX21(judge,w0[3],D,wi[3]);
        MUX21(judge,a,w1[0],wi[4]);
        MUX21(judge,b,w1[1],wi[5]);
        MUX21(judge,c,w1[2],wi[6]);
        MUX21(judge,d,w1[3],wi[7]);
        assign led = judge;
        
        //debounced_U , debounced_D判斷  (2個MUX)
        //RIGHT
        MUX21(debounced_U, D|~A, wm[0], w0[0]);
        MUX21(debounced_D, ~A&(B|C|D), A, wm[0]);
                 
        MUX21(debounced_U, (~A&B)|(A&~B&~D), wm[1], w0[1]);
        MUX21(debounced_D, (A&B)|(~A&D)|(~A&~B&C), B, wm[1]); 
        
        MUX21(debounced_U, (~B&C)|(~A&C)|(A&B&~C), wm[2], w0[2]);
        MUX21(debounced_D, (A&C)|(B&C)|(~A&D), C, wm[2]);
                
        MUX21(debounced_U, (D)|(A&B&C), wm[3], w0[3]);
        MUX21(debounced_D, D&A, D, wm[3]);
        
        //LEFT
        
        MUX21(debounced_U, d|~a, wm[4], w1[0]);
        MUX21(debounced_D, ~a&(b|c|d), a, wm[4]);
                         
        MUX21(debounced_U, (~a&b)|(a&~b&~d), wm[5], w1[1]);
        MUX21(debounced_D, (a&b)|(~a&d)|(~a&~b&c), b, wm[5]); 
                
        MUX21(debounced_U, (~b&c)|(~a&c)|(a&b&~c), wm[6], w1[2]);
        MUX21(debounced_D, (a&c)|(b&c)|(~a&d), c, wm[6]);
                        
        MUX21(debounced_U, (d)|(a&b&c), wm[7], w1[3]);
        MUX21(debounced_D, d&a, d, wm[7]);    
        
        //判斷
        MUX21(debounced_R,1'b1,judge,ww);
        MUX21(debounced_L,1'b0,ww,w2);
        DFF(judge,w2,clk,rst);
        
        
    
    //===================================================
endmodule
