`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: LAB8
// Submodule: ButtonFSM, BP_TimerSetting, SevenSegment
//////////////////////////////////////////////////////////////////////////////////

module LAB8(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 100 MHz clock
    input      [15:0]       sw,         // 16 Switches, sw[15] for asynchronous reset
    input                   btnU,       // Up     Button
    input                   btnD,       // Down   Button
	input                   btnR,       // Right  Button
    input                   btnL,       // Left   Button
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------7 segment display-----
    output     [6:0]        seg,         // Number
    output                  dp,          // Dot point
    output     [3:0]        an,          // Mux for 4 number
	output     [15:0]       led          // 16 green LEDs
    );
    
    //=======================================================
    //  REG/WIRE declarations
    //=======================================================
    wire rst;
    wire clk25; //25 MHz clock
    wire de_btnU, de_btnD,de_btnR, de_btnL;
	wire [3:0] seven_num3;
	wire [3:0] seven_num2;
	wire [3:0] seven_num1;
	wire [3:0] seven_num0;
	wire [3:0] seven_mask;
	wire led0;

    //=======================================================
    //  Combinational Part
    //======================================================= 
    assign rst = sw[15];
	assign led[0] = led0; assign led[15:1] = 0;
	assign seven_num3 = 4'b0000;
	assign seven_num2 = 4'b0000;
	assign seven_num1 = 4'b0000;
	assign seven_mask = 4'b0001;
    
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));
    ButtonFSM       bU(.clk(clk25), .rst(rst), .button(btnU), .debounced(de_btnU));
    ButtonFSM       bD(.clk(clk25), .rst(rst), .button(btnD), .debounced(de_btnD));
	ButtonFSM       bL(.clk(clk25), .rst(rst), .button(btnL), .debounced(de_btnL));
    ButtonFSM       bR(.clk(clk25), .rst(rst), .button(btnR), .debounced(de_btnR));
    BP_TimerSetting     h1(.clk(clk25), .rst(rst), .debounced_U(de_btnU), .debounced_D(de_btnD), .debounced_R(de_btnR), .debounced_L(de_btnL),.cur_sec(seven_num0),.led(led0)); 
    SevenSegment    s1(.clk(clk), .rst(rst), .num3(seven_num3), .num2(seven_num2), 
                       .num1(seven_num1), .num0(seven_num0), .mask(seven_mask), 
                       .seg(seg), .dp(dp), .an(an));

endmodule
