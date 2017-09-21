`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: SevenSegment
//////////////////////////////////////////////////////////////////////////////////


module SevenSegment(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,         // 25 MHz clock
    input                   rst,         // Asynchronus reset
    input      [3:0]        num3,        // decimal number on leftmost 7-segment (0-9)
    input      [3:0]        num2,        // decimal number on  7-segment (0-9)
    input      [3:0]        num1,        // decimal number on  7-segment (0-9)
    input      [3:0]        num0,        // decimal number on rightmost 7-segment (0-9)
    input      [3:0]        mask,        // position of displayed num (3 for leftmost, 0 for rightmost)
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------7 segment display-----
    output reg [6:0]       seg,         // Number
    output                 dp,          // Dot point
    output reg [3:0]       an           // Mux for 4 number
    );

    assign dp = 1'b1;
    reg [6:0] seg3; // The seven segment representation for num3
    reg [6:0] seg2; // The seven segment representation for num2
    reg [6:0] seg1; // The seven segment representation for num1
    reg [6:0] seg0; // The seven segment representation for num0

//======Do NOT modify the previous part===============================
//======Modifiy your code only in the following block=================
always@(*) begin
    case(num3) 
    4'd0: seg3 = 7'b1000000;
    4'd1: seg3 = 7'b1111001;
    4'd2: seg3 = 7'b0100100;
    4'd3: seg3 = 7'b0110000;
    4'd4: seg3 = 7'b0011001;
    4'd5: seg3 = 7'b0010010;
    4'd6: seg3 = 7'b0000010;
    4'd7: seg3 = 7'b1111000;
    4'd8: seg3 = 7'b0000000;
    4'd9: seg3 = 7'b0010000;
    default: seg3 = 7'b1111111;
    endcase
    
    case(num2) 
    4'd0: seg2 = 7'b1000000;
    4'd1: seg2 = 7'b1111001;
    4'd2: seg2 = 7'b0100100;
    4'd3: seg2 = 7'b0110000;
    4'd4: seg2 = 7'b0011001;
    4'd5: seg2 = 7'b0010010;
    4'd6: seg2 = 7'b0000010;
    4'd7: seg2 = 7'b1111000;
    4'd8: seg2 = 7'b0000000;
    4'd9: seg2 = 7'b0010000;
    default: seg2 = 7'b1111111;
    endcase   

    case(num1) 
    4'd0: seg1 = 7'b1000000;
    4'd1: seg1 = 7'b1111001;
    4'd2: seg1 = 7'b0100100;
    4'd3: seg1 = 7'b0110000;
    4'd4: seg1 = 7'b0011001;
    4'd5: seg1 = 7'b0010010;
    4'd6: seg1 = 7'b0000010;
    4'd7: seg1 = 7'b1111000;
    4'd8: seg1 = 7'b0000000;
    4'd9: seg1 = 7'b0010000;
    default: seg1 = 7'b1111111;
    endcase  
    
    case(num0) 
    4'd0: seg0 = 7'b1000000;
    4'd1: seg0 = 7'b1111001;
    4'd2: seg0 = 7'b0100100;
    4'd3: seg0 = 7'b0110000;
    4'd4: seg0 = 7'b0011001;
    4'd5: seg0 = 7'b0010010;
    4'd6: seg0 = 7'b0000010;
    4'd7: seg0 = 7'b1111000;
    4'd8: seg0 = 7'b0000000;
    4'd9: seg0 = 7'b0010000;
    default: seg0 = 7'b1111111;
    endcase        
end
    
//======Modifiy your code only in the previous block==================  
//======Do NOT modify the following part==============================
reg  [16:0] cnt_time, next_cnt_time;
reg  [6:0]  next_seg;
reg  [3:0]  next_an;

always@(*) begin
    next_cnt_time = cnt_time+1;
    case(cnt_time[16:15])
        2'b00: begin
               next_seg = (mask[3])?seg3:7'b1111111;
               next_an  = 4'b0111;
               end
        2'b01: begin
               next_seg = (mask[2])?seg2:7'b1111111;
               next_an  = 4'b1011;        
               end
        2'b10: begin
               next_seg = (mask[1])?seg1:7'b1111111;
               next_an  = 4'b1101;        
               end
        2'b11: begin
               next_seg = (mask[0])?seg0:7'b1111111;
               next_an  = 4'b1110;        
               end
    endcase
end

always@(posedge clk or posedge rst) begin
    if(rst) begin
        cnt_time <= 17'd0;
        seg      <= 7'b1111111;
        an       <= 4'b1111;
    end
    else begin
        cnt_time <= next_cnt_time;
        seg      <= next_seg;
        an       <= next_an;
    end
end
endmodule
