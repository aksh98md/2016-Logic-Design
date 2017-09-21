`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: ButtonFSM : The finite state machine for button debouncing
//////////////////////////////////////////////////////////////////////////////////


module ButtonFSM(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,            // 25 MHz clock
    input                   rst,            // Asynchronous reset
    input                   button,         // Physical button pressed (level sensitive)
    //====================================================
    //=======           Output                      ======
    //====================================================
    output                  debounced       // debouncing (edge sensitive)
    );
    
    //=======================================================
    //  PARAMETER declarations
    //=======================================================
    parameter S_0               = 3'b000;
    parameter S_1               = 3'b001;
    parameter S_2               = 3'b010;
    parameter S_3               = 3'b011;
    parameter S_4               = 3'b100;
    parameter S_5               = 3'b101;
    parameter S_6               = 3'b110;
    parameter S_7               = 3'b111;
    
    //=======================================================
    //  REG/WIRE declarations
    //=======================================================
    reg [2:0] state, next_state;
    
    //=======================================================
    //  Combinational Part
    //=======================================================    
    always@(*) begin
    case(state)
        S_0: next_state = (button==1)?S_1:S_0;
        S_1: next_state = (button==1)?S_2:S_0; 
        S_2: next_state = (button==1)?S_3:S_0;
        S_3: next_state = S_4;
        S_4: next_state = (button==0)?S_5:S_4;
        S_5: next_state = (button==0)?S_6:S_4;
        S_6: next_state = (button==0)?S_7:S_4;
        S_7: next_state = S_0;
        default: next_state = state;
    endcase
    end
    
    assign debounced = (state==S_3);
    
    //=======================================================
    //  Sequential Part
    //=======================================================
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            state <= S_0;
        end
        else begin
            state <= next_state;
        end
    end
endmodule
