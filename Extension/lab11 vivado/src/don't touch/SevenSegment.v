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
    wire [15:0] cur_sec;
    assign cur_sec[3:0] = num0;
    assign cur_sec[7:4] = num1;
    assign cur_sec[11:8] = num2;
    assign cur_sec[15:12] = num3;

       reg [3: 0]      thousands;
          reg [3: 0]      hundreds;
          reg [3: 0]      tens;
          reg [3: 0]      ones;
    //=====binary to BCD======/
    integer i;
    always @(posedge clk) 
    begin
        thousands = 4'd0;
        hundreds = 4'd0;
        tens = 4'd0;
        ones = 4'd0;
    
        for(i=15;i>=0;i=i-1)
        begin
            if (thousands>=5) begin
                thousands = thousands+3;
            end
            if (hundreds>=5) begin
                hundreds = hundreds+3;
            end
            if (tens>=5) begin
                tens = tens+3;
            end
            if (ones>=5) begin
                ones = ones+3;
            end
    
            thousands = thousands<<1;
            thousands[0] = hundreds[3];
            hundreds = hundreds<<1;
            hundreds[0] = tens[3];
            tens = tens<<1;
            tens[0] = ones[3];
            ones = ones<<1;
            ones[0] = cur_sec[i];
        end
     
   end
   

    ssDecoder ssde1(.clk(clk), .rst(rst)
                  , .num3(thousands), .num2(hundreds), .num1(tens), .num0(ones)
                  , .seg3(seg3), .seg2(seg2), .seg1(seg1), .seg0(seg0)
                    );

    ssDisplayer ssdp1(.clk(clk), .rst(rst), .mask(mask)
                    , .seg3(seg3), .seg2(seg2), .seg1(seg1), .seg0(seg0)
                    , .seg(seg), .dp_on(dp_on), .an(an));

endmodule
