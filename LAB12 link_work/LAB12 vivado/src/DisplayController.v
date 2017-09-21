`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: VGADisplayer
//////////////////////////////////////////////////////////////////////////////////

module DisplayController(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input            clk,        // 25 MHz clock
    input            rst,        // Asynchronus reset
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [3:0] man_state
    );

    //====================================================
    //=========          TODO                     ========
    //====================================================    
    //(3125000)10 = (10 1111 1010 1111 0000 1000)2

    wire [24:0] counter;
    wire [24:0] counter_n;
    wire [3:0] man_state_n;
    wire switch;

    DFF dff0  (counter[0 ], counter_n[0 ], clk, rst);
    DFF dff1  (counter[1 ], counter_n[1 ], clk, rst);
    DFF dff2  (counter[2 ], counter_n[2 ], clk, rst);
    DFF dff3  (counter[3 ], counter_n[3 ], clk, rst);
    DFF dff4  (counter[4 ], counter_n[4 ], clk, rst);
    DFF dff5  (counter[5 ], counter_n[5 ], clk, rst);
    DFF dff6  (counter[6 ], counter_n[6 ], clk, rst);
    DFF dff7  (counter[7 ], counter_n[7 ], clk, rst);
    DFF dff8  (counter[8 ], counter_n[8 ], clk, rst);
    DFF dff9  (counter[9 ], counter_n[9 ], clk, rst);
    DFF dff10 (counter[10], counter_n[10], clk, rst);
    DFF dff11 (counter[11], counter_n[11], clk, rst);
    DFF dff12 (counter[12], counter_n[12], clk, rst);
    DFF dff13 (counter[13], counter_n[13], clk, rst);
    DFF dff14 (counter[14], counter_n[14], clk, rst);
    DFF dff15 (counter[15], counter_n[15], clk, rst);
    DFF dff16 (counter[16], counter_n[16], clk, rst);
    DFF dff17 (counter[17], counter_n[17], clk, rst);
    DFF dff18 (counter[18], counter_n[18], clk, rst);
    DFF dff19 (counter[19], counter_n[19], clk, rst);
    DFF dff20 (counter[20], counter_n[20], clk, rst);
    DFF dff21 (counter[21], counter_n[21], clk, rst);

    DFF dff22 (man_state[0], man_state_n[0], clk, rst);
    DFF dff23 (man_state[1], man_state_n[1], clk, rst);
    DFF dff24 (man_state[2], man_state_n[2], clk, rst);
    DFF dff25 (man_state[3], man_state_n[3], clk, rst);


    assign switch = counter[21]& ~counter[20]& counter[19]& counter[18]& counter[17]& counter[16]& counter[15]& ~counter[14]& counter[13]& ~counter[12]& counter[11]& counter[10]& & counter[9]& counter[8]& ~counter[7]& ~counter[6]& ~counter[5]& ~counter[4]& counter[3]& ~counter[2]& ~counter[1]& ~counter[0];
    
    
    
    assign man_state_n[3] = switch?(man_state[0]&man_state[1]&man_state[2]) :man_state[3] ;
    assign man_state_n[2] = switch? ((man_state[2]&~man_state[1])|(man_state[2]&~man_state[0])|(~man_state[2]&man_state[1]&man_state[0])):man_state[2];
    assign man_state_n[1] = switch? ((~man_state[1]& man_state[0])|(man_state[1]&~man_state[0])) :man_state[1];
    assign man_state_n[0] = switch ? (~man_state[0]):man_state[0];    
    
    assign counter_n[0] = (switch)? 0: ~counter[0];
    assign counter_n[1] = (switch)?0:( counter[0])? ~counter[1]:counter[1];
    assign counter_n[2] = (switch)?0:( counter[0]& counter[1])? ~counter[2]:counter[2];
    assign counter_n[3] = (switch)?0:( counter[0]& counter[1]& counter[2])? ~counter[3]:counter[3];
    assign counter_n[4] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3])? ~counter[4]:counter[4];
    assign counter_n[5] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4])? ~counter[5]:counter[5];
    assign counter_n[6] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5])? ~counter[6]:counter[6];
    assign counter_n[7] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6])? ~counter[7]:counter[7];
    assign counter_n[8] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7])? ~counter[8]:counter[8];
    assign counter_n[9] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8])? ~counter[9]:counter[9];
    assign counter_n[10] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9])? ~counter[10]:counter[10];
    assign counter_n[11] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10])? ~counter[11]:counter[11];
    assign counter_n[12] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        )? ~counter[12]:counter[12];
    assign counter_n[13] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12])? ~counter[13]:counter[13];
    assign counter_n[14] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12]& counter[13])? ~counter[14]:counter[14];
    assign counter_n[15] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12]& counter[13]& counter[14])? ~counter[15]:counter[15];
    assign counter_n[16] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12]& counter[13]& counter[14]& counter[15])? ~counter[16]:counter[16];
    assign counter_n[17] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12]& counter[13]& counter[14]& counter[15]& counter[16])? ~counter[17]:counter[17];
    assign counter_n[18] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17])? ~counter[18]:counter[18];
    assign counter_n[19] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18])? ~counter[19]:counter[19];
    assign counter_n[20] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19])? ~counter[20]:counter[20];
    assign counter_n[21] = (switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
        & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20])? ~counter[21]:counter[21];
    
endmodule


