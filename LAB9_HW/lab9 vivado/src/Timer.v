`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: Timer, when set=1 the timer will initiate cur_sec to sec; set=0 the cur will countdown
//////////////////////////////////////////////////////////////////////////////////
 module FA(a, b, c, sum, carry);
   input a, b, c;
   output sum, carry;
       
   wire [5:0] internalW;
   assign internalW[0] = a^b;
   assign sum = internalW[0]^c;
   assign internalW[1] = a&b;
   assign internalW[2] = b&c;
   assign internalW[3] = c&a;
   assign internalW[4] = internalW[1]|internalW[2];
   
   assign carry = internalW[3]|internalW[4];

   endmodule
   
module Timer(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,     // 25 MHz clock
    input                   rst,     // Asynchronus reset
    input                   set,     // set the starting time countdown timer
    input      [3:0]        new_sec, // new starting time (0-9)
    //====================================================
    //=======           Output                      ======
    //====================================================
    output  [3:0]        cur_sec  // if set=0, shows current time, if set=1, shows current setting time
    );
    //====================================================
    //======        TODO                        ==========
    wire [3:0] w1;
    wire [3:0] w2;
    wire [3:0] w3;
    wire [3:0] w4;
    wire [3:0] w5;
    wire [1:0] test;
   wire [1:0] test1;
    wire [3:0] s1;
    wire [3:0] cursec;
    DFF(cursec[0],w1[0],clk,reset);
    DFF(cursec[1],w1[1],clk,reset);
    DFF(cursec[2],w1[2],clk,reset);
    DFF(cursec[3],w1[3],clk,reset);
    assign cur_sec = cursec;
    MUX21(set,new_sec[0],w2[0],w1[0]);
    MUX21(set,new_sec[1],w2[1],w1[1]);
    MUX21(set,new_sec[2],w2[2],w1[2]);    
    MUX21(set,new_sec[3],w2[3],w1[3]);
    
    MUX21(test[0],w3[0],new_sec[0],w2[0]);
    MUX21(test[0],w3[1],new_sec[1],w2[1]);
    MUX21(test[0],w3[2],new_sec[2],w2[2]);
    MUX21(test[0],w3[3],new_sec[3],w2[3]);
    
    //FA
    FA(w4[0], 1'b0, 1'b1, w3[0], s1[0]);
    FA(w4[1], 1'b1, s1[0], w3[1], s1[1]);
    FA(w4[2], 1'b1, s1[1], w3[2], s1[2]);
    FA(w4[3], 1'b1, s1[2], w3[3], s1[3]);
    
    
    MUX21(test[0],w5[0],1'b1,w4[0]);
    MUX21(test[0],w5[1],1'b0,w4[1]);
    MUX21(test[0],w5[2],1'b0,w4[2]);
    MUX21(test[0],w5[3],1'b0,w4[3]);
    
    
    MUX21(cur_sec[0]|cur_sec[1]|cur_sec[2]|cur_sec[3],cursec[0],1'b1,w5[0]);
    MUX21(cur_sec[0]|cur_sec[1]|cur_sec[2]|cur_sec[3],cursec[1],1'b0,w5[1]);
    MUX21(cur_sec[0]|cur_sec[1]|cur_sec[2]|cur_sec[3],cursec[2],1'b0,w5[2]);
    MUX21(cur_sec[0]|cur_sec[1]|cur_sec[2]|cur_sec[3],cursec[3],1'b0,w5[3]);
    
    wire [24:0] x;
    wire [24:0] w6;
    wire [24:0] sum;
    wire [24:0] ci;
    wire [24:0] w7;
   
    assign x=25'b0000000000000000000000001;
    //test
    FA(x[0], w6[0], 1'b0, sum[0], ci[0]);
    assign w7[0] = (test[0])? 1'b0 : sum[0]; 
    DFF(w6[0], w7[0], clk, rst);
    
    FA(x[1], w6[1], ci[0], sum[1], ci[1]);
    assign w7[1] =(test[0])? 1'b0 : sum[1];  
    DFF(w6[1], w7[1], clk, rst); 
    
    FA(x[2], w6[2], ci[1], sum[2], ci[2]);
    assign w7[2] = (test[0])? 1'b0 : sum[2];    
    DFF(w6[2], w7[2], clk, rst); 
        
    FA(x[3], w6[3], ci[2], sum[3], ci[3]);
    assign w7[3] = (test[0])? 1'b0 : sum[3];
    DFF(w6[3], w7[3], clk, rst);
    
    FA(x[4], w6[4], ci[3], sum[4], ci[4]);
        assign w7[4] = (test[0])? 1'b0 : sum[4]; 
        DFF(w6[4], w7[4], clk, rst); 
    
        FA(x[5], w6[5], ci[4], sum[5], ci[5]);
        assign w7[5] = (test[0])? 1'b0 : sum[5]; 
        DFF(w6[5], w7[5], clk, rst);
    
        FA(x[6], w6[6], ci[5], sum[6], ci[6]);
        assign w7[6] = (test[0])? 1'b0 :sum[6]; 
        DFF(w6[6], w7[6], clk, rst);
    
        FA(x[7], w6[7], ci[6], sum[7], ci[7]);
        assign w7[7] = (test[0])? 1'b0 : sum[7]; 
        DFF(w6[7], w7[7], clk, rst);
    
        FA(x[8], w6[8], ci[7], sum[8], ci[8]);
        assign w7[8] = (test[0])? 1'b0 : sum[8]; 
        DFF(w6[8], w7[8], clk, rst);
    
        FA(x[9], w6[9], ci[8], sum[9], ci[9]);
        assign w7[9] = (test[0])? 1'b0 : sum[9]; 
        DFF(w6[9], w7[9], clk, rst);
    
        FA(x[10], w6[10], ci[9], sum[10], ci[10]);
        assign w7[10] = (test[0])? 1'b0 : sum[10]; 
        DFF(w6[10], w7[10], clk, rst);
    
        
        FA(x[11], w6[11], ci[10], sum[11], ci[11]);
        assign w7[11] = (test[0])? 1'b0 : sum[11];  
        DFF(w6[11], w7[11], clk, rst); 
        
        FA(x[12], w6[12], ci[11], sum[12], ci[12]);
        assign w7[12] = (test[0])? 1'b0 : sum[12];  
        DFF(w6[12], w7[12], clk, rst);   
        
        FA(x[13], w6[13], ci[12], sum[13], ci[13]);
        assign w7[13] = (test[0])? 1'b0 : sum[13];
        DFF(w6[13], w7[13], clk, rst);   
    
        FA(x[14], w6[14], ci[13], sum[14], ci[14]);
        assign w7[14] = (test[0])? 1'b0 : sum[14];
        DFF(w6[14], w7[14], clk, rst);  
    
        FA(x[15], w6[15], ci[14], sum[15], ci[15]);
        assign w7[15] = (test[0])? 1'b0 : sum[15]; 
        DFF(w6[15], w7[15], clk, rst);
    
        FA(x[16], w6[16], ci[15], sum[16], ci[16]);
        assign w7[16] = (test[0])? 1'b0 : sum[16]; 
        DFF(w6[16], w7[16], clk, rst);
    
        FA(x[17], w6[17], ci[16], sum[17], ci[17]);
        assign w7[17] = (test[0])? 1'b0 : sum[17]; 
        DFF(w6[17], w7[17], clk, rst);
    
        FA(x[18], w6[18], ci[17], sum[18], ci[18]);
        assign w7[18] = (test[0])? 1'b0 : sum[18]; 
        DFF(w6[18], w7[18], clk, rst);
    
        FA(x[19], w6[19], ci[18], sum[19], ci[19]);
        assign w7[19] = (test[0])? 1'b0 : sum[19]; 
        DFF(w6[19], w7[19], clk, rst);
        
        FA(x[20], w6[20], ci[19], sum[20], ci[20]);
        assign w7[20] = (test[0])? 1'b0 : sum[20]; 
        DFF(w6[20], w7[20], clk, rst);
    
        FA(x[21], w6[21], ci[20], sum[21], ci[21]);
        assign w7[21] = (test[0])? 1'b0 : sum[21];  
        DFF(w6[21], w7[21], clk, rst); 
        
        FA(x[22], w6[22], ci[21], sum[22], ci[22]);
        assign w7[22] = (test[0])? 1'b0 : sum[22];  
        DFF(w6[22], w7[22], clk, rst);   
        
        FA(x[23], w6[23], ci[22], sum[23], ci[23]);
        assign w7[23] = (test[0])? 1'b0 : sum[23];
        DFF(w6[23], w7[23], clk, rst);
        
        FA(x[24], w6[24], ci[23], sum[24], ci[24]);
        assign w7[24] = (test[0])? 1'b0 : sum[24];
        DFF(w6[24], w7[24], clk, rst);
        
        wire tt;
        wire dffout;
        wire m_out;
        assign tt = ~sum[0] & ~sum[1] & ~sum[2] & ~sum[3] & ~sum[4] & ~sum[5] & sum[6] & ~sum[7] & ~sum[8] & ~sum[9] & ~sum[10] & sum[11] & sum[12] & sum[13] & sum[14] & ~sum[15] & sum[16] & ~sum[17] & sum[18] & sum[19] & sum[20] & sum[21] & sum[22] & ~sum[23] & sum[24];
        DFF(dffout, tt, clk, rst);
        assign test[0] = dffout;
        
        
       
//DFF(test[0],test1[0],clk, rst);
// assign test =  sum[24]&~sum[23]&sum[
	//====================================================
	
endmodule
