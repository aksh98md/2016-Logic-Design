//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: MP_TimerController, handle cur_phase , phase0_t~phase4_t
//////////////////////////////////////////////////////////////////////////////////

module MP_TimerController(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk, // 25 MHz clock
    input                   rst, // Asynchronus reset
    input                   set, // 1 for set mode
    input                   buttonU, // Button Up
    input                   buttonD, // Button Down
    input                   buttonL, // Button Left
    input                   buttonR, // Button Right
    //====================================================
    //=======           Output                      ======
    //====================================================
    output     [2:0]        cur_phase,  // current phase for Display_Controller
    output     [3:0]        seven_num   // seven_num for Display_Controller    
    );
    
//=======================================
//=======          TODO            ======
/////LAB 8
   wire [3:0] num0;
   wire [3:0] num1;
   wire [3:0] num2;
   wire [3:0] num3;
   wire [3:0] num4;
   
   wire [3:0] num0_n;
   wire [3:0] num1_n;
   wire [3:0] num2_n;
   wire [3:0] num3_n;
   wire [3:0] num4_n;
   
   wire phase_0_t;
   wire phase_1_t;
   wire phase_2_t;
   wire phase_3_t;
   wire phase_4_t;
   
   wire phase_0_t_n;
   wire phase_1_t_n;
   wire phase_2_t_n;
   wire phase_3_t_n;
   wire phase_4_t_n;
  
   wire U0;
   wire D0;
   wire U1;
   wire D1;
   wire U2;
   wire D2;
   wire U3;
   wire D3;
   wire U4;
   wire D4;
   

   //=======================================================
   //  Combinational Part
   //=======================================================                      
   wire [3:0] new_sec;
   wire [2:0] cur_phase_n;
   assign phase_0_t = ~cur_phase_n[2]&~cur_phase_n[1]&~cur_phase_n[0];
   assign phase_1_t = ~cur_phase_n[2]&~cur_phase_n[1]&cur_phase_n[0];
   assign phase_2_t = ~cur_phase_n[2]&cur_phase_n[1]&~cur_phase_n[0];
   assign phase_3_t = ~cur_phase_n[2]&cur_phase_n[1]&cur_phase_n[0];
   assign phase_4_t = cur_phase_n[2]&~cur_phase_n[1]&~cur_phase_n[0];
   
   
   assign new_sec = (phase_0_t)? num0_n : (phase_1_t)? num1_n : (phase_2_t)? num2_n : (phase_3_t)? num3_n : num4_n;
   
   
   wire checkzero;
   assign checkzero = ~seven_num[0]&~seven_num[1]&~seven_num[2]&~seven_num[3];
   
   
   DFF dff_p (cur_phase[0], cur_phase_n[0], clk, rst, 1'b0);
   DFF dff_q (cur_phase[1], cur_phase_n[1], clk, rst, 1'b0);
   DFF dff_r (cur_phase[2], cur_phase_n[2], clk, rst, 1'b0);
   
   DFF dff0 (num0[0], num0_n[0], clk, rst, 1'b0);
   DFF dff1 (num0[1], num0_n[1], clk, rst, 1'b0);
   DFF dff2 (num0[2], num0_n[2], clk, rst, 1'b1);
   DFF dff3 (num0[3], num0_n[3], clk, rst, 1'b0);
   DFF dff4 (num1[0], num1_n[0], clk, rst, 1'b0);
   DFF dff5 (num1[1], num1_n[1], clk, rst, 1'b0);
   DFF dff6 (num1[2], num1_n[2], clk, rst, 1'b1);
   DFF dff7 (num1[3], num1_n[3], clk, rst, 1'b0);
   DFF dff8 (num2[0], num2_n[0], clk, rst, 1'b0);
   DFF dff9 (num2[1], num2_n[1], clk, rst, 1'b0);
   DFF dff10 (num2[2], num2_n[2], clk, rst, 1'b1);
   DFF dff11 (num2[3], num2_n[3], clk, rst, 1'b0);
   DFF dff12 (num3[0], num3_n[0], clk, rst, 1'b0);
   DFF dff13 (num3[1], num3_n[1], clk, rst, 1'b0);
   DFF dff14 (num3[2], num3_n[2], clk, rst, 1'b1);
   DFF dff15 (num3[3], num3_n[3], clk, rst, 1'b0);
   DFF dff16 (num4[0], num4_n[0], clk, rst, 1'b0);
   DFF dff17 (num4[1], num4_n[1], clk, rst, 1'b0);
   DFF dff18 (num4[2], num4_n[2], clk, rst, 1'b1);
   DFF dff19 (num4[3], num4_n[3], clk, rst, 1'b0);
   
   assign A = cur_phase[2];
   assign B = cur_phase[1];
   assign C = cur_phase[0];
   assign cur_phase_n[0]  = (checkzero)?~A&~C:(buttonL)?~A&~C:(buttonR)?(B&~C)|A:cur_phase[0];  
   assign cur_phase_n[1]  = (checkzero)?((~B&C)|(B&~C)):(buttonL)?((~B&C)|(B&~C)):(buttonR)?((B&C)|A):cur_phase[1];   
   assign cur_phase_n[2]  = (checkzero)?(B&C):(buttonL)?(B&C):(buttonR)?~A&~B&~C:cur_phase[2];    
   
   
   
   assign U0 = buttonU & (cur_phase[2]==0&cur_phase[1]==0&cur_phase[0]==0) & (num0!=4'b1001);
   assign D0 = buttonD & (cur_phase[2]==0&cur_phase[1]==0&cur_phase[0]==0) & (num0!=4'b0001);
   assign U1 = buttonU & (cur_phase[2]==0&cur_phase[1]==0&cur_phase[0]==1) & (num1!=4'b1001);
   assign D1 = buttonD & (cur_phase[2]==0&cur_phase[1]==0&cur_phase[0]==1) & (num1!=4'b0001);
   assign U2 = buttonU & (cur_phase[2]==0&cur_phase[1]==1&cur_phase[0]==0) & (num2!=4'b1001);
   assign D2 = buttonD & (cur_phase[2]==0&cur_phase[1]==1&cur_phase[0]==0) & (num2!=4'b0001);
   assign U3 = buttonU & (cur_phase[2]==0&cur_phase[1]==1&cur_phase[0]==1) & (num3!=4'b1001);
   assign D3 = buttonD & (cur_phase[2]==0&cur_phase[1]==1&cur_phase[0]==1) & (num3!=4'b0001);
   assign U4 = buttonU & (cur_phase[2]==1&cur_phase[1]==0&cur_phase[0]==0) & (num4!=4'b1001);
   assign D4 = buttonD & (cur_phase[2]==1&cur_phase[1]==0&cur_phase[0]==0) & (num4!=4'b0001);
   
   
   assign num0_n[0] = (set&(U0|D0))? ~num0[0]:num0[0];
   assign num0_n[1] = (set&U0 & num0[0])? ~num0[1]:(D0 & ~num0[0])?~num0[1]:num0[1];
   assign num0_n[2] = (set & U0 & num0[0]& num0[1])? ~num0[2]:(D0 & ~num0[0]& ~num0[1])?~num0[2]:num0[2];
   assign num0_n[3] = (set & U0 & num0[0]& num0[1]& num0[2])? ~num0[3]:(D0 & ~num0[0]& ~num0[1]& ~num0[2])?~num0[3]:num0[3];
   
   assign num1_n[0] = (set & (U1|D1))? ~num1[0]:num1[0];
   assign num1_n[1] = (set & U1 & num1[0])? ~num1[1]:(D1 & ~num1[0])?~num1[1]:num1[1];
   assign num1_n[2] = (set & U1 & num1[0]& num1[1])? ~num1[2]:(D1 & ~num1[0]& ~num1[1])?~num1[2]:num1[2];
   assign num1_n[3] = (set & U1 & num1[0]& num1[1]& num1[2])? ~num1[3]:(D1 & ~num1[0]& ~num1[1]& ~num1[2])?~num1[3]:num1[3];

   assign num2_n[0] = (set&(U2|D2))? ~num2[0]:num2[0];
   assign num2_n[1] = (set&U2 & num2[0])? ~num2[1]:(D2 & ~num2[0])?~num2[1]:num2[1];
   assign num2_n[2] = (set & U2 & num2[0]& num2[1])? ~num2[2]:(D2 & ~num2[0]& ~num2[1])?~num2[2]:num2[2];
   assign num2_n[3] = (set & U2 & num2[0]& num2[1]& num2[2])? ~num2[3]:(D2 & ~num2[0]& ~num2[1]& ~num2[2])?~num2[3]:num2[3];
   
   assign num3_n[0] = (set & (U3|D3))? ~num3[0]:num3[0];
   assign num3_n[1] = (set & U3 & num3[0])? ~num3[1]:(D3 & ~num3[0])?~num3[1]:num3[1];
   assign num3_n[2] = (set & U3 & num3[0]& num3[1])? ~num3[2]:(D3 & ~num3[0]& ~num3[1])?~num3[2]:num3[2];
   assign num3_n[3] = (set & U3 & num3[0]& num3[1]& num3[2])? ~num3[3]:(D3 & ~num3[0]& ~num3[1]& ~num3[2])?~num3[3]:num3[3];

   assign num4_n[0] = (set & (U4|D4))? ~num4[0]:num4[0];
   assign num4_n[1] = (set & U4 & num4[0])? ~num4[1]:(D4 & ~num4[0])?~num4[1]:num4[1];
   assign num4_n[2] = (set & U4 & num4[0]& num4[1])? ~num4[2]:(D4 & ~num4[0]& ~num4[1])?~num4[2]:num4[2];
   assign num4_n[3] = (set & U4 & num4[0]& num4[1]& num4[2])? ~num4[3]:(D4 & ~num4[0]& ~num4[1]& ~num4[2])?~num4[3]:num4[3];




   ////LAB9
   wire [24:0] counter;
   wire [24:0] counter_n;
   wire [3:0] cur_sec_n;
   wire switch;
   
   assign switch = (counter==25'b1011111010111100001000000)? 1 :0;
   
   DFF  (counter[0 ], counter_n[0 ], clk, rst, 1'b0);
   DFF  (counter[1 ], counter_n[1 ], clk, rst, 1'b0);
   DFF  (counter[2 ], counter_n[2 ], clk, rst, 1'b0);
   DFF  (counter[3 ], counter_n[3 ], clk, rst, 1'b0);
   DFF  (counter[4 ], counter_n[4 ], clk, rst, 1'b0);
   DFF  (counter[5 ], counter_n[5 ], clk, rst, 1'b0);
   DFF  (counter[6 ], counter_n[6 ], clk, rst, 1'b0);
   DFF  (counter[7 ], counter_n[7 ], clk, rst, 1'b0);
   DFF  (counter[8 ], counter_n[8 ], clk, rst, 1'b0);
   DFF  (counter[9 ], counter_n[9 ], clk, rst, 1'b0);
   DFF  (counter[10], counter_n[10], clk, rst, 1'b0);
   DFF  (counter[11], counter_n[11], clk, rst, 1'b0);
   DFF  (counter[12], counter_n[12], clk, rst, 1'b0);
   DFF  (counter[13], counter_n[13], clk, rst, 1'b0);
   DFF  (counter[14], counter_n[14], clk, rst, 1'b0);
   DFF  (counter[15], counter_n[15], clk, rst, 1'b0);
   DFF  (counter[16], counter_n[16], clk, rst, 1'b0);
   DFF  (counter[17], counter_n[17], clk, rst, 1'b0);
   DFF  (counter[18], counter_n[18], clk, rst, 1'b0);
   DFF  (counter[19], counter_n[19], clk, rst, 1'b0);
   DFF  (counter[20], counter_n[20], clk, rst, 1'b0);
   DFF  (counter[21], counter_n[21], clk, rst, 1'b0);
   DFF  (counter[22], counter_n[22], clk, rst, 1'b0);
   DFF  (counter[23], counter_n[23], clk, rst, 1'b0);
   DFF  (counter[24], counter_n[24], clk, rst, 1'b0);
   
   DFF dff25 (seven_num[0], cur_sec_n[0], clk, rst, 1'b0);
   DFF dff26 (seven_num[1], cur_sec_n[1], clk, rst, 1'b0);
   DFF dff27 (seven_num[2], cur_sec_n[2], clk, rst, 1'b1);
   DFF dff28 (seven_num[3], cur_sec_n[3], clk, rst, 1'b0);
   
   //MUX21(checkzero, ~phase, phase, phase_n);
   
   assign cur_sec_n[0] = (set|checkzero|buttonL|buttonR)?new_sec[0]: (switch)?(~seven_num[1]&~seven_num[0])|(seven_num[1]&~seven_num[0]):seven_num[0];
   assign cur_sec_n[1] = (set|checkzero|buttonL|buttonR)?new_sec[1]: (switch)?(~seven_num[1]&~seven_num[0])|(seven_num[1]&seven_num[0]):seven_num[1];
   assign cur_sec_n[2] = (set|checkzero|buttonL|buttonR)?new_sec[2]: (switch)?(seven_num[3]&~seven_num[0])|(seven_num[2]&seven_num[0])|(seven_num[2]&seven_num[1]):seven_num[2];
   assign cur_sec_n[3] = (set|checkzero|buttonL|buttonR)?new_sec[3]: (switch)?(seven_num[3]&~seven_num[2]&~seven_num[1]&seven_num[0]):seven_num[3];
   
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
   

//=======       Reuse Timer        ======
//=======================================
    
endmodule
