//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: ssDecoder
//////////////////////////////////////////////////////////////////////////////////

module ssDecoder(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,         // 25 MHz clock
    input                   rst,         // Asynchronus reset
    input      [3:0]        num3,        // decimal number on leftmost 7-segment (0-9)
    input      [3:0]        num2,        // decimal number on  7-segment (0-9)
    input      [3:0]        num1,        // decimal number on  7-segment (0-9)
    input      [3:0]        num0,        // decimal number on rightmost 7-segment (0-9)
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------to ssDisplayer-----
    output reg [6:0]       seg3,         // The seven segment representation for num3
    output reg [6:0]       seg2,         // The seven segment representation for num2
    output reg [6:0]       seg1,         // The seven segment representation for num1
    output reg [6:0]       seg0          // The seven segment representation for num0
    );

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
endmodule