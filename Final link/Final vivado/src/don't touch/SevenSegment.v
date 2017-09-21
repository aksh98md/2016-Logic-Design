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
    //-----------from ssDisplayer-----
    output     [6:0]       seg,         // Number
    output                 dp_on,       // Dot point
    output     [3:0]       an           // Mux for 4 number
    );

    wire [6:0] seg0;
    wire [6:0] seg1;
    wire [6:0] seg2;
    wire [6:0] seg3;


    ssDecoder ssde1(.clk(clk), .rst(rst)
                  , .num3(num3), .num2(num2), .num1(num1), .num0(num0)
                  , .seg3(seg3), .seg2(seg2), .seg1(seg1), .seg0(seg0)
                    );

    ssDisplayer ssdp1(.clk(clk), .rst(rst), .mask(mask)
                    , .seg3(seg3), .seg2(seg2), .seg1(seg1), .seg0(seg0)
                    , .seg(seg), .dp_on(dp_on), .an(an)
                    );

endmodule
