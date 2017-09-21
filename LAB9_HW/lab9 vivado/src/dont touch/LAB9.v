`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: FinalProject : Traffic Light Controller System with VGA
// Submodule: Timer, Button FSM, Counter, 7-seg display, VGA
//////////////////////////////////////////////////////////////////////////////////


module LAB9(
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
    output     [15:0]       led,        // 16 green LEDs
    //-----------7 segment display-----
    output     [6:0]        seg,         // Number
    output                  dp,          // Dot point
    output     [3:0]        an         // Mux for 4 number
    //-----------VGA Controller--------
    );
    
    //=======================================================
    //  REG/WIRE declarations
    //=======================================================
    wire rst;
    wire clk25; //25 MHz clock
    wire de_btnU, de_btnD;
	wire [3:0] timer_cur_sec;
    reg  [3:0] seven_num3;
    reg  [3:0] seven_num2;
    reg  [3:0] seven_num1;
    reg  [3:0] seven_num0;
    reg  [3:0] seven_mask;
	reg  [3:0] new_sec;
	reg  [3:0] next_new_sec;

    //=======================================================
    //  Combinational Part
    //======================================================= 
    assign rst = sw[15];
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));
    
    ButtonFSM       bU(.clk(clk25), .rst(rst), .button(btnU), .debounced(de_btnU));
    ButtonFSM       bD(.clk(clk25), .rst(rst), .button(btnD), .debounced(de_btnD));
	
	Timer t1(.clk(clk25), .rst(rst), .set(sw[14]), .new_sec(new_sec), .cur_sec(timer_cur_sec));
    
    SevenSegment    s1(.clk(clk25), .rst(rst), .num3(seven_num3), .num2(seven_num2), 
                       .num1(seven_num1), .num0(seven_num0), .mask(seven_mask), 
                       .seg(seg), .dp(dp), .an(an));
	always@(*) begin
		if(sw[14] == 1)begin
			if(de_btnU) next_new_sec = (new_sec==9)?9:new_sec+1;
			else if(de_btnD) next_new_sec = (new_sec==0)?0:new_sec-1;
			else next_new_sec = new_sec;
			seven_mask = 4'b0001;
			seven_num0 = new_sec;
			seven_num1 = 0;
			seven_num2 = 0;
			seven_num3 = 0;
		end else begin
		
			next_new_sec = new_sec;
			seven_mask = 4'b0001;
			seven_num0 = timer_cur_sec;
			seven_num1 = 0;
			seven_num2 = 0;
			seven_num3 = 0;
		end
    end
	
	always@(posedge clk25 or posedge rst) begin
        if(rst) begin
            new_sec <= 0;
        end
        else begin
            new_sec <= next_new_sec;
        end
    end
                       
endmodule
