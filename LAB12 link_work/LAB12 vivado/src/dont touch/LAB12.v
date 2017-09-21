`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: LAB12
// Submodule: VGADisplayer, VGAController
//////////////////////////////////////////////////////////////////////////////////

module LAB12(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 100 MHz clock
    input      [15:0]       sw,         // 16 Switches, sw[15] for asynchronous reset
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [3:0]  vgaRed,
    output     [3:0]  vgaBlue,
    output     [3:0]  vgaGreen,
    output     Hsync,
    output     Vsync,
    output     [15:0] led
    );
    
    //=======================================================
    //  REG/WIRE declarations
    //=======================================================
    wire       rst;
    wire       clk25; //25 MHz clock
    wire [3:0] man_state;
    reg  [15:0] led;
    
    //=======================================================
    //  Combinational Part
    //======================================================= 
    assign rst = sw[15];
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));
    DisplayController    vd2(.clk(clk25), .rst(rst),.man_state(man_state));
    VGADisplayer   vc1(.clk(clk25), .rst(rst), .man_state(man_state), .vgaRed(vgaRed),
                        .vgaBlue(vgaBlue), .vgaGreen(vgaGreen), .Hsync(Hsync), .Vsync(Vsync));

    always@(*) begin
        case(man_state)
            4'd1: led = 16'b1000_0000_0000_0000;
            4'd2: led = 16'b0100_0000_0000_0000;
            4'd3: led = 16'b0010_0000_0000_0000;
            4'd4: led = 16'b0001_0000_0000_0000;
            4'd5: led = 16'b0000_1000_0000_0000;
            4'd6: led = 16'b0000_0100_0000_0000;
            4'd7: led = 16'b0000_0010_0000_0000;
            4'd8: led = 16'b0000_0001_0000_0000;
            default: led = 16'b0000_0000_0000_0000;
        endcase
    end
endmodule
