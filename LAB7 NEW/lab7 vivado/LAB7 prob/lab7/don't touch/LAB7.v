//////////////////////////////////////////////////////////////////////////////////
// LAB7 TopModule  
//////////////////////////////////////////////////////////////////////////////////


module LAB7(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 100 MHz clock
    input      [15:0]       sw,         // 16 Switches, sw[15] for asynchronous reset
    //====================================================
    //=======           Output                      ======
    //====================================================
        //-----------7sDisplayer----------
    output     [6:0]        seg,        // Number
    output     [3:0]        an,          // Mux for 4 number
    output     [15:0]       led         // 16 green LEDs
    );
    
    //=======================================================
    //  REG/WIRE declarations
    //=======================================================
    wire rst, set;
    wire clk25; //25 MHz clock


    //=======================================================
    //  Combinational Part
    //======================================================= 
    assign led[1] = 1'b1; // reference bitstream tag
    assign rst = sw[15];
    assign set = sw[14];
   
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));

    wire [3:0] mask = 4'b0000;
    wire [6:0] ssdr_seg0;
    wire [6:0] ssdr_seg1;
    wire [6:0] ssdr_seg2;
    wire [6:0] ssdr_seg3;
    wire dp_on;
    SSDR ssdr1(.clk(clk25), .rst(rst), .set(set), .sw(sw[11:0]), 
               .seg3(ssdr_seg3), .seg2(ssdr_seg2), .seg1(ssdr_seg1), .seg0(ssdr_seg0));
               
    ssDisplayer ssdp1(.clk(clk25), .rst(rst), .mask(mask)
                    , .seg3(ssdr_seg3), .seg2(ssdr_seg2), .seg1(ssdr_seg1), .seg0(ssdr_seg0)
                    , .seg(seg), .dp_on(dp_on), .an(an)); 
endmodule
