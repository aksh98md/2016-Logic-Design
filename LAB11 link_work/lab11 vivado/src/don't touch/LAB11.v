//////////////////////////////////////////////////////////////////////////////////
// LAB11 TopModule
//////////////////////////////////////////////////////////////////////////////////


module LAB11(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 100 MHz clock
    input      [15:0]       sw,         // 16 Switches, sw[15] for asynchronous reset
    input                   btnU,       // Up     Button
    input                   btnL,       // Left   Button
    input                   btnR,       // Right  Button
    input                   btnD,       // Down   Button
    //====================================================
    //=======           Output                      ======
    //====================================================
        //-----------7sDisplayer----------
    output     [6:0]        seg,         // Number
    output     [3:0]        an,          // Mux for 4 number 
    output     [15:0]       led          // 16 green LEDs
    );
    
    //=======================================================
    //  REG/WIRE declarations
    //=======================================================
    wire rst, set;
    wire clk25; //25 MHz clock
    wire de_btnU, de_btnL, de_btnR, de_btnD;
    wire [3:0] cur_sec;
    wire led0;
    wire dp;

    wire       [3:0] seven_mask;
    wire       [3:0] seven_num3;
    wire       [3:0] seven_num2;
    wire       [3:0] seven_num1;
    wire       [3:0] seven_num0;   
   //=======================================================
   //  Combinational Part
   //======================================================= 
    assign led[1] = 1'b1; // reference bitstream tag
    assign rst = sw[15];
    assign set = sw[14];
    assign led[0] = led0; 

    
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));
    
    ButtonFSM       bU(.clk(clk25), .rst(rst), .button(btnU), .debounced(de_btnU));
    ButtonFSM       bL(.clk(clk25), .rst(rst), .button(btnL), .debounced(de_btnL));
    ButtonFSM       bR(.clk(clk25), .rst(rst), .button(btnR), .debounced(de_btnR));
    ButtonFSM       bD(.clk(clk25), .rst(rst), .button(btnD), .debounced(de_btnD));
    
    BP_TimerController tc1(.clk(clk25), .rst(rst), .set(set), 
                       .btnU(de_btnU), .btnD(de_btnD), .btnL(de_btnL), .btnR(de_btnR), 
                       .cur_sec(cur_sec), .led(led0));

    assign seven_mask = 4'b1110;
    assign seven_num3 = 0;
    assign seven_num2 = 0;
    assign seven_num1 = 0;
    assign seven_num0 = cur_sec;


   SevenSegment ss1(.clk(clk25), .rst(rst),
                    .num3(seven_num3), .num2(seven_num2), .num1(seven_num1), .num0(seven_num0), .mask(seven_mask),
                    .seg(seg), .dp_on(dp), .an(an));       
endmodule
