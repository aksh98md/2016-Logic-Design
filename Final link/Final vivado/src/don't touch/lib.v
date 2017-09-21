
////////////////////////////////////////////// INV
module INV(in1, out1);
      output reg out1;
       input in1;
always@(*)
begin 
out1 = ~in1;
end

endmodule

////////////////////////////////////////////// AND2
module AND2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=A&B;
end

endmodule

////////////////////////////////////////////// AND3
module AND3(A,B,C,Y);
      output reg Y;
       input A,B,C;
     
always@(*)
begin 
Y=A&B&C;
end

endmodule

////////////////////////////////////////////// AND4
module AND4(A,B,C,D,Y);
      output reg Y;
       input A,B,C,D;
     
always@(*)
begin 
Y=A&B&C&D;
end

endmodule


////////////////////////////////////////////// OR2
module OR2(A,B,Y);
      output reg Y;
       input A,B;

always@(*)
begin 
Y=A|B;
end

endmodule

////////////////////////////////////////////// OR3
module OR3(A,B,C,Y);
      output reg Y;
       input A,B,C;

always@(*)
begin 
Y=A|B|C;
end

endmodule

////////////////////////////////////////////// OR4
module OR4(A,B,C,D,Y);
      output reg Y;
       input A,B,C,D;

always@(*)
begin 
Y=A|B|C|D;
end

endmodule

////////////////////////////////////////////// NAND2
module NAND2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=~(A&B);
end

endmodule

////////////////////////////////////////////// NAND3
module NAND3(A,B,C,Y);
      output reg Y;
       input A,B,C;
     
always@(*)
begin 
Y=~(A&B&C);
end

endmodule

////////////////////////////////////////////// NAND4
module NAND4(A,B,C,D,Y);
      output reg Y;
       input A,B,C,D;
     
always@(*)
begin 
Y=~(A&B&C&D);
end

endmodule

////////////////////////////////////////////// NOR2

module NOR2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=~(A|B);
end

endmodule

////////////////////////////////////////////// NOR3

module NOR3(A,B,C,Y);
      output reg Y;
       input A,B,C;
     
always@(*)
begin 
Y=~(A|B|C);
end

endmodule

////////////////////////////////////////////// NOR4

module NOR4(A,B,C,D,Y);
      output reg Y;
       input A,B,C,D;
     
always@(*)
begin 
Y=~(A|B|C|D);
end

endmodule

////////////////////////////////////////////// XOR2
module XOR2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=(~A&B) | (A&~B);
end

endmodule

//////////////////////////////////////////////XNOR2
module XNOR2(A,B,Y);
      output reg Y;
       input A,B;
     
always@(*)
begin 
Y=(A&B) | (~A&~B);
end

endmodule

//////////////////////////////////////////////DFF, positive edge D flip flop, asynchronous positive reset, when reset, reset to H or L according to HL

module DFF(Q,D,CLK,RESET,HL);

output reg Q;
input D,CLK,RESET,HL;

always@(posedge CLK or posedge RESET) 
begin
    if(RESET) Q<=HL;
    else Q<=D;
end

endmodule

//////////////////////////////////////////////MUX21
module MUX21(SEL,A,B,Y); //if SEL==1 Y=A, else Y=B
output reg Y;
input SEL,A,B;

always@(*) 
begin
    Y = (SEL)?A:B;
end
   
endmodule

//////////////////////////////////////////////MUX41
module MUX41(SEL,A,B,C,D,Y); //if SEL==00 Y=A, SEL==01 Y=B, SEL==10 Y=C, SEL==11 Y=D
output reg Y;
input [1:0] SEL;
input A,B,C,D;

always@(*) 
begin
    case(SEL)
    2'b00: Y=A;
    2'b01: Y=B;
    2'b10: Y=C;
    2'b11: Y=D;
    endcase
end
   
endmodule

