`timescale 1ns / 1ps

 module LAB6(
    input clk,

 input [15:0] sw, 
   
     output [15:0] led,
     output  [6:0] seg,  //gfedcba, 1=disable, 0=enable;
     output reg [3:0] an,   //1=disable, 0=able
     output wire dp
    
 );
reg [6:0] outB;
wire [6:0] outA;
wire [3:0] inB;
//untouch
wire rst;
reg [19:0] clkdiv;
assign rst = sw[15];
wire s;
assign s=clkdiv[19];
wire [3:0] aen;
assign aen = 4'b1111; // all turned off initially

always@ (posedge clk or posedge rst)  
begin
if (rst)
begin
clkdiv<=1'b0;
end
else begin
clkdiv<=clkdiv+1;
end
end
always@(*)
begin
an[3:0]=4'b1111;
if(aen[s]==1)
an[s]=0;
end

assign seg[6:0]= (s)? outA:outB;
assign dp=1'b1;

always@(*)
begin
case (inB)
4'd0: outB= 7'b1000000;
4'd1: outB= 7'b1111001;
4'd2: outB= 7'b0100100;
4'd3: outB= 7'b0110000;
4'd4: outB= 7'b0011001;
4'd5: outB= 7'b0010010;
4'd6: outB= 7'b0000010;
4'd7: outB= 7'b1111000;
4'd8: outB= 7'b0000000;
4'd9: outB= 7'b0010000;
default: outB= 7'b1111111;
endcase
end

//untouch


wire A,B,C,D;

assign A=sw[3];
assign B=sw[2];
assign C=sw[1];
assign D=sw[0];


//please design your Comparator, Circuit A  & B. optimize your design via K MAP
//Just complete OutA and inB 
wire compOut;
assign compOut=(A&B)|(A&C);

wire [6:0] x,y;
assign x=7'b1111001;
assign y=7'b1000000;
assign outA=((A&B)|(A&C))?x:y;



wire e,f,g,h;
assign e=1'b0;
assign f=(A&B&C);
assign g=~C;
assign h=D;

assign inB[3]=(compOut&e)|(~compOut&sw[3]);
assign inB[2]=(compOut&f)|(~compOut&sw[2]);
assign inB[1]=(compOut&g)|(~compOut&sw[1]);
assign inB[0]=(compOut&h)|(~compOut&sw[0]);


endmodule