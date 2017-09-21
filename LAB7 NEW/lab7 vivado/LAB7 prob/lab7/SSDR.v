//////////////////////////////////////////////////////////////////////////////////
// LAB7 Module: SSDR
// submodule: ssDecoder 
//////////////////////////////////////////////////////////////////////////////////

module ssDecoder(
    //====================================================
    //=======               Input                   ======
    //====================================================
    input      [2:0]        num3,        // decimal number on leftmost 7-segment (0-7)
    input      [2:0]        num2,        // decimal number on  7-segment (0-7)
    input      [2:0]        num1,        // decimal number on  7-segment (0-7)
    input      [2:0]        num0,        // decimal number on rightmost 7-segment (0-7)
    //====================================================
    //=======              Output                   ======
    //====================================================
    //-----------to ssDisplayer-----
    output     [6:0]       seg3,         // The seven segment representation for num3
    output     [6:0]       seg2,         // The seven segment representation for num2
    output     [6:0]       seg1,         // The seven segment representation for num1
    output     [6:0]       seg0          // The seven segment representation for num0
    );
    
//=======================================
//=======          TODO            ======
wire A0,B0,C0,A1,B1,C1,A2,B2,C2,A3,B3,C3;
assign C0=num0[0];
assign B0=num0[1];
assign A0=num0[2];

assign C1=num1[0];
assign B1=num1[1];
assign A1=num1[2];

assign C2=num2[0];
assign B2=num2[1];
assign A2=num2[2];

assign C3=num3[0];
assign B3=num3[1];
assign A3=num3[2];

assign seg0[0]=(A0&~B0&~C0)|(~A0&~B0&C0);
assign seg0[1]=(A0&~B0&C0)|(A0&B0&~C0);
assign seg0[2]=(~A0&B0&~C0);
assign seg0[3]=(A0&~B0&~C0)|(~A0&~B0&C0)|(A0&B0&C0);
assign seg0[4]=(C0)|(A0&~B0);
assign seg0[5]=(~A0&B0)|(~A0&C0)|(B0&C0);
assign seg0[6]=(~A0&~B0)|(A0&B0&C0);

assign seg1[0]=(A1&~B1&~C1)|(~A1&~B1&C1);
assign seg1[1]=(A1&~B1&C1)|(A1&B1&~C1);
assign seg1[2]=(~A1&B1&~C1);
assign seg1[3]=(A1&~B1&~C1)|(~A1&~B1&C1)|(A1&B1&C1);
assign seg1[4]=(C1)|(A1&~B1);
assign seg1[5]=(~A1&B1)|(~A1&C1)|(B1&C1);
assign seg1[6]=(~A1&~B1)|(A1&B1&C1);

assign seg2[0]=(A2&~B2&~C2)|(~A2&~B2&C2);
assign seg2[1]=(A2&~B2&C2)|(A2&B2&~C2);
assign seg2[2]=(~A2&B2&~C2);
assign seg2[3]=(A2&~B2&~C2)|(~A2&~B2&C2)|(A2&B2&C2);
assign seg2[4]=(C2)|(A2&~B2);
assign seg2[5]=(~A2&B2)|(~A2&C2)|(B2&C2);
assign seg2[6]=(~A2&~B2)|(A2&B2&C2);

assign seg3[0]=(A3&~B3&~C3)|(~A3&~B3&C3);
assign seg3[1]=(A3&~B3&C3)|(A3&B3&~C3);
assign seg3[2]=(~A3&B3&~C3);
assign seg3[3]=(A3&~B3&~C3)|(~A3&~B3&C3)|(A3&B3&C3);
assign seg3[4]=(C3)|(A3&~B3);
assign seg3[5]=(~A3&B3)|(~A3&C3)|(B3&C3);
assign seg3[6]=(~A3&~B3)|(A3&B3&C3);


//=======================================
  
endmodule

module SSDR(
 	//====================================================
    //=======           Input                       ======
    //====================================================
    input                  clk,         // 25 MHz clock
    input                  rst,         // Asynchronus reset
    input                  set,         // mode; 1:set 0:display
    input      [11:0]      sw,          // 12 Switches, 
									     // num3 = sw[11:9], 
									     // num2 = sw[8:6], 
									     // num1 = sw[5:3], 
									     // num0 = sw[2:0]
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------to ssDisplayer-----
    output     [6:0]       seg3,         // The seven segment representation for num3
    output     [6:0]       seg2,         // The seven segment representation for num2
    output     [6:0]       seg1,         // The seven segment representation for num1
    output     [6:0]       seg0          // The seven segment representation for num0
    );

//=======================================
//=======          TODO            ======
wire [11:0] Q;
wire [11:0] muxo;
MUX21(~set,Q[0],sw[0],muxo[0]);
DFF(Q[0],muxo[0],clk,reset);


MUX21(~set,Q[1],sw[1],muxo[1]);
DFF(Q[1],muxo[1],clk,reset);

MUX21(~set,Q[2],sw[2],muxo[2]);
DFF(Q[2],muxo[2],clk,reset);

MUX21(~set,Q[3],sw[3],muxo[3]);
DFF(Q[3],muxo[3],clk,reset);

MUX21(~set,Q[4],sw[4],muxo[4]);
DFF(Q[4],muxo[4],clk,reset);

MUX21(~set,Q[5],sw[5],muxo[5]);
DFF(Q[5],muxo[5],clk,reset);

MUX21(~set,Q[6],sw[6],muxo[6]);
DFF(Q[6],muxo[6],clk,reset);

MUX21(~set,Q[7],sw[7],muxo[7]);
DFF(Q[7],muxo[7],clk,reset);

MUX21(~set,Q[8],sw[8],muxo[8]);
DFF(Q[8],muxo[8],clk,reset);

MUX21(~set,Q[9],sw[9],muxo[9]);
DFF(Q[9],muxo[9],clk,reset);

MUX21(~set,Q[10],sw[10],muxo[10]);
DFF(Q[10],muxo[10],clk,reset);

MUX21(~set,Q[11],sw[11],muxo[11]);
DFF(Q[11],muxo[11],clk,reset);

ssDecoder(Q[11:9],Q[8:6],Q[5:3],Q[2:0],seg3,seg2,seg1,seg0);
//=======     Reuse ssDecoder      ======
//=======================================
	
endmodule