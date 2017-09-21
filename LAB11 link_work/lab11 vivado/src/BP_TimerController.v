
//////////////////////////////////////////////////////////////////////////////////
// LAB11 Module: BP_TimerController
// Submodule: Timer
//////////////////////////////////////////////////////////////////////////////////
parameter GREEN = 1'b0;
parameter RED   = 1'b1;

module BP_TimerController(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 25 MHz clock
    input                   rst,        // asynchronous reset
    input                   set,        // mode up:set, down:count
    input                   btnU,       // Up     Button
    input                   btnD,       // Down   Button
    input                   btnL,       // Left   Button
    input                   btnR,       // Right  Button
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------7 segment display-----
    output      [3:0]       cur_sec,     // Number
    output                  led          // led0
    );
    
//=======================================
//=======          TODO            ======
//=======       Reuse Timer        ======
 /////LAB 8
   wire [3:0] num1;
   wire [3:0] num0;
   wire [3:0] num1_n;
   wire [3:0] num0_n;
   
   wire phase;
   wire phase_n;
   
   wire U0;
   wire D0;
   wire U1;
   wire D1;

   //=======================================================
   //  Combinational Part
   //=======================================================                      
   wire [3:0] new_sec;
   assign new_sec = (phase_n)? num1 : num0;
   
   
      wire checkzero;
      assign checkzero = ~cur_sec[0]&~cur_sec[1]&~cur_sec[2]&~cur_sec[3];
   assign led = phase;
       
   DFF dff_p (phase, phase_n, clk, rst);
   
   DFF dff0 (num1[0], num1_n[0], clk, rst);
   DFF dff1 (num1[1], num1_n[1], clk, rst);
   DFF dff2 (num1[2], num1_n[2], clk, rst);
   DFF dff3 (num1[3], num1_n[3], clk, rst);
   DFF dff4 (num0[0], num0_n[0], clk, rst);
   DFF dff5 (num0[1], num0_n[1], clk, rst);
   DFF dff6 (num0[2], num0_n[2], clk, rst);
   DFF dff7 (num0[3], num0_n[3], clk, rst);
   
   assign phase_n  = (~set&checkzero)?~phase:(~set)?phase:(btnR)? 1'b1:(btnL)?1'b0:phase;   
   assign U0 = btnU & (phase==0) & (num0!=4'b1001);
   assign D0 = btnD & (phase==0) & (num0!=4'b0000);
   assign U1 = btnU & (phase==1) & (num1!=4'b1001);
   assign D1 = btnD & (phase==1) & (num1!=4'b0000);
   
   assign num0_n[0] = (set&(U0|D0))? ~num0[0]:num0[0];
   assign num0_n[1] = (set&U0 & num0[0])? ~num0[1]:(D0 & ~num0[0])?~num0[1]:num0[1];
   assign num0_n[2] = (set & U0 & num0[0]& num0[1])? ~num0[2]:(D0 & ~num0[0]& ~num0[1])?~num0[2]:num0[2];
   assign num0_n[3] = (set & U0 & num0[0]& num0[1]& num0[2])? ~num0[3]:(D0 & ~num0[0]& ~num0[1]& ~num0[2])?~num0[3]:num0[3];
   
   assign num1_n[0] = (set & (U1|D1))? ~num1[0]:num1[0];
   assign num1_n[1] = (set & U1 & num1[0])? ~num1[1]:(D1 & ~num1[0])?~num1[1]:num1[1];
   assign num1_n[2] = (set & U1 & num1[0]& num1[1])? ~num1[2]:(D1 & ~num1[0]& ~num1[1])?~num1[2]:num1[2];
   assign num1_n[3] = (set & U1 & num1[0]& num1[1]& num1[2])? ~num1[3]:(D1 & ~num1[0]& ~num1[1]& ~num1[2])?~num1[3]:num1[3];

   ////LAB9
   wire [24:0] counter;
   wire [24:0] counter_n;
   wire [3:0] cur_sec_n;
   wire switch;
   
   assign switch = (counter==25'b1011111010111100001000000)? 1 :0;
   
   DFF   (counter[0 ], counter_n[0 ], clk, rst);
   DFF   (counter[1 ], counter_n[1 ], clk, rst);
   DFF   (counter[2 ], counter_n[2 ], clk, rst);
   DFF   (counter[3 ], counter_n[3 ], clk, rst);
   DFF   (counter[4 ], counter_n[4 ], clk, rst);
   DFF   (counter[5 ], counter_n[5 ], clk, rst);
   DFF   (counter[6 ], counter_n[6 ], clk, rst);
   DFF   (counter[7 ], counter_n[7 ], clk, rst);
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
   DFF dff22 (counter[22], counter_n[22], clk, rst);
   DFF dff23 (counter[23], counter_n[23], clk, rst);
   DFF dff24 (counter[24], counter_n[24], clk, rst);
   
   DFF dff25 (cur_sec[0], cur_sec_n[0], clk, rst);
   DFF dff26 (cur_sec[1], cur_sec_n[1], clk, rst);
   DFF dff27 (cur_sec[2], cur_sec_n[2], clk, rst);
   DFF dff28 (cur_sec[3], cur_sec_n[3], clk, rst);
   
   //MUX21(checkzero, ~phase, phase, phase_n);
   
   assign cur_sec_n[0] = (set)? new_sec[0]:(checkzero)? new_sec[0]: (switch)?~cur_sec[0]:cur_sec[0];
   assign cur_sec_n[1] = (set)? new_sec[1]:(checkzero)? new_sec[1]: (switch & ~cur_sec[0])?~cur_sec[1]:cur_sec[1];
   assign cur_sec_n[2] = (set)? new_sec[2]:(checkzero)? new_sec[2]: (switch & ~cur_sec[0]& ~cur_sec[1])?~cur_sec[2]:cur_sec[2];
   assign cur_sec_n[3] = (set)? new_sec[3]:(checkzero)? new_sec[3]: (switch & ~cur_sec[0]& ~cur_sec[1]& ~cur_sec[2])?~cur_sec[3]:cur_sec[3];
   
   assign counter_n[0] = (set | switch)? 0: ~counter[0];
   assign counter_n[1] = (set | switch)?0:(  counter[0])? ~counter[1]:counter[1];
   assign counter_n[2] = (set | switch)?0:( counter[0]& counter[1])? ~counter[2]:counter[2];
   assign counter_n[3] = (set | switch)?0:( counter[0]& counter[1]& counter[2])? ~counter[3]:counter[3];
   assign counter_n[4] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3])? ~counter[4]:counter[4];
   assign counter_n[5] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4])? ~counter[5]:counter[5];
   assign counter_n[6] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5])? ~counter[6]:counter[6];
   assign counter_n[7] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6])? ~counter[7]:counter[7];
   assign counter_n[8] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7])? ~counter[8]:counter[8];
   assign counter_n[9] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8])? ~counter[9]:counter[9];
   assign counter_n[10] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9])? ~counter[10]:counter[10];
   assign counter_n[11] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10])? ~counter[11]:counter[11];
   assign counter_n[12] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           )? ~counter[12]:counter[12];
   assign counter_n[13] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12])? ~counter[13]:counter[13];
   assign counter_n[14] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13])? ~counter[14]:counter[14];
   assign counter_n[15] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14])? ~counter[15]:counter[15];
   assign counter_n[16] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14]& counter[15])? ~counter[16]:counter[16];
   assign counter_n[17] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14]& counter[15]& counter[16])? ~counter[17]:counter[17];
   assign counter_n[18] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17])? ~counter[18]:counter[18];
   assign counter_n[19] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18])? ~counter[19]:counter[19];
   assign counter_n[20] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19])? ~counter[20]:counter[20];
   assign counter_n[21] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20])? ~counter[21]:counter[21];
   assign counter_n[22] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20]& counter[21])? ~counter[22]:counter[22];
                           
   assign counter_n[23] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                           & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20]& counter[21]& counter[22])? ~counter[23]:counter[23];
   assign counter_n[24] = (set | switch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]& counter[12]& 
                           counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20]& counter[21]& counter[22]& counter[23])? ~counter[24]:counter[24];
   

//=======================================


endmodule

/////////////////BUGS
//other side starts at 1111(15)
