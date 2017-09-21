//////////////////////////////////////////////////////////////////////////////////
// Module Name: TrafficLight : Traffic Light Controller System with VGA
// Submodule: ButtonFSM, MP_Timer_Controller(Timer), Display_Controller(7sDecoder/7sDisplayer), VGADisplayer
//////////////////////////////////////////////////////////////////////////////////


module TrafficLight(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 100 MHz clock
    input      [15:0]       sw,         // 16 Switches, sw[15] for asynchronous reset
    input                   btnU,       // Up     Button
    input                   btnD,       // Down   Button
    input                   btnL,       // Left   Button
    input                   btnR,       // Right  Button
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------Display_Controller-----
        //-----------VGADisplayer--------
    output     [3:0]        vgaRed, 
    output     [3:0]        vgaBlue,
    output     [3:0]        vgaGreen,
    output                  Hsync,
    output                  Vsync,
        //-----------SsDisplayer----------
    output     [6:0]        seg,         // Number
    output     [3:0]        an,          // Mux for 4 number 
    output                  dp,          // Dot point
    output     [15:0]       led          // 16 green LEDs
    );
    
    wire clk25; //25 MHz clock
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));
    
//=======================================
//=======          TODO            ======

     //=======CALL ButtonFSM=======//
     wire debounced_U;
     wire debounced_D;
     wire debounced_L;
     wire debounced_R;
     ButtonFSM(.clk(clk25), .rst(sw[15]), .button(btnU), .debounced(debounced_U));
     ButtonFSM(.clk(clk25), .rst(sw[15]), .button(btnD), .debounced(debounced_D));
     ButtonFSM(.clk(clk25), .rst(sw[15]), .button(btnL), .debounced(debounced_L));
     ButtonFSM(.clk(clk25), .rst(sw[15]), .button(btnR), .debounced(debounced_R));
     
    // assign led[9] = btnU;
    // assign led[10] = btnD;
    // assign led[11] = btnL;
    // assign led[12] = btnR;
     //============================//
     
     //========CALL MP_TimerController========//
     wire [2:0] cur_phase;
     wire [3:0] seven_num;
     MP_TimerController(.clk(clk25), .rst(sw[15]), .set(sw[14]), .buttonU(debounced_U), .buttonD(debounced_D), .buttonL(debounced_L), .buttonR(debounced_R), .cur_phase(cur_phase), .seven_num(seven_num));
     //=====================================//
     
     //=======CALL Display_Controller========//
     wire [2:0] car_state;
     wire [3:0] man_state;
     DisplayController(.clk(clk25), .rst(sw[15]), .cur_phase(cur_phase), .seven_num(seven_num), .car_state(car_state), .man_state(man_state), .seg(seg), .an(an), .dp(dp), .led(led));
     //===================================//
     
     //==========VGADisplayer==============//
     VGADisplayer(.clk(clk25), .rst(sw[15]), .car_state(car_state), .man_state(man_state), .vgaRed(vgaRed), .vgaBlue(vgaBlue), .vgaGreen(vgaGreen), .Hsync(Hsync), .Vsync(Vsync));
     //===================================//
//=======================================

    
endmodule
