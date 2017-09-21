`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: Timer, when set=1 the timer will initiate cur_sec to sec; set=0 the cur will countdown
//////////////////////////////////////////////////////////////////////////////////

module Timer(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,     // 25 MHz clock
    input                   rst,     // Asynchronus reset
    input                   set,     // set the starting time countdown timer
    input      [3:0]        new_sec, // new starting time (0-9)
    //====================================================
    //=======           Output                      ======
    //====================================================
    output reg [3:0]        cur_sec  // if set=0, shows current time, if set=1, shows current setting time
    );
    
    reg [30:0] counter, next_counter;
    reg [3:0]  next_cur_sec;
    reg        switch_flag;
    
    always@(*) begin
        switch_flag = (counter == 25000000); // 1 sec for 25 MHz clock
        if(set) begin
            next_counter = 0;
            next_cur_sec     = new_sec;
        end
        else begin
            next_counter = (switch_flag)?0:counter+1;
            next_cur_sec = (switch_flag)? ((cur_sec==0)?0:cur_sec-1) : cur_sec;
        end
    end
    
    always@(posedge clk or posedge rst) begin
        if(rst) begin
            counter <= 0;
            cur_sec <= 4;
        end
        else begin
            counter <= next_counter;
            cur_sec <= next_cur_sec;
        end
    end
endmodule
