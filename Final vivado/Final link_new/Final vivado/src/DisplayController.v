//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: DisplayController: 
// From cur_phase/num to VGADisplayer & SevenSegment & led/dp
//////////////////////////////////////////////////////////////////////////////////

module DisplayController(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input            clk,        // 25 MHz clock
    input            rst,        // Asynchronus reset
    input      [2:0] cur_phase,  // Current phase
    input      [3:0] seven_num,
    //====================================================
    //=======           Output                      ======
    //====================================================
    // to VGADisplayer
    output     [2:0]  car_state,
    output     [3:0]  man_state,
    // from SevenSegment
    output     [6:0]  seg,
    output     [3:0]  an,
    output            dp,
    output     [15:0] led
    );
     
//=======================================
//=======          TODO            ======

 wire [3:0]  cur_phase_four;
 
 assign cur_phase_four[3] = 1'b0;
 assign cur_phase_four[2] = cur_phase[2];
  assign cur_phase_four[1] = cur_phase[1];
   assign cur_phase_four[0] = cur_phase[0];
   //test
/*assign led[0]=cur_phase[0];
assign led[1]=cur_phase[1];
assign led[2]=cur_phase[2];
assign led[4]=seven_num[0];
assign led[5]=seven_num[1];
assign led[6]=seven_num[2];
assign led[7]=seven_num[3];*/
//============
 

 SevenSegment(.clk(clk), .rst(rst), .num3(4'b0000), .num2(cur_phase_four), .num1(4'b0000), .num0(seven_num), .mask(4'b1010), .seg(seg), .dp_on(dp), .an(an));
   assign car_state[2] = cur_phase[2];
   assign car_state[1] = cur_phase[1]& cur_phase[0];
   assign car_state[0] = (~cur_phase[2]& ~cur_phase[1])| (~cur_phase[2]& ~cur_phase[0]);

   //lab12
    wire [24:0] counter;
   wire [24:0] counter_n;
   wire [3:0] man_state_n;
   wire switch;
   wire fasterswitch;
   wire chooseswitch;

   DFF (counter[0], counter_n[0], clk, rst, 1'b0);
   DFF (counter[1], counter_n[1], clk, rst, 1'b0);
   DFF (counter[2], counter_n[2], clk, rst, 1'b0);
   DFF (counter[3], counter_n[3], clk, rst, 1'b0);
   DFF (counter[4], counter_n[4], clk, rst, 1'b0);
   DFF (counter[5], counter_n[5], clk, rst, 1'b0);
   DFF (counter[6], counter_n[6], clk, rst, 1'b0);
   DFF (counter[7], counter_n[7], clk, rst, 1'b0);
   DFF (counter[8], counter_n[8], clk, rst, 1'b0);
   DFF (counter[9], counter_n[9], clk, rst, 1'b0);
   DFF (counter[10], counter_n[10], clk, rst, 1'b0);
   DFF (counter[11], counter_n[11], clk, rst, 1'b0);
   DFF (counter[12], counter_n[12], clk, rst, 1'b0);
   DFF (counter[13], counter_n[13], clk, rst, 1'b0);
   DFF (counter[14], counter_n[14], clk, rst, 1'b0);
   DFF (counter[15], counter_n[15], clk, rst, 1'b0);
   DFF (counter[16], counter_n[16], clk, rst, 1'b0);
   DFF (counter[17], counter_n[17], clk, rst, 1'b0);
   DFF (counter[18], counter_n[18], clk, rst, 1'b0);
   DFF (counter[19], counter_n[19], clk, rst, 1'b0);
   DFF (counter[20], counter_n[20], clk, rst, 1'b0);
   DFF (counter[21], counter_n[21], clk, rst, 1'b0);

   DFF (man_state[0], man_state_n[0], clk, rst, 1'b0);
   DFF (man_state[1], man_state_n[1], clk, rst, 1'b0);
   DFF (man_state[2], man_state_n[2], clk, rst, 1'b0);
   DFF (man_state[3], man_state_n[3], clk, rst, 1'b0);


   //(3125000)10 = (10 1111 1010 1111 0000 1000)2
   //(1562500)10  = (1 0111 1101 0111 1000 0100)2

   assign switch = counter[21]& ~counter[20]& counter[19]& counter[18]& counter[17]& counter[16]& counter[15]& ~counter[14]& counter[13]& ~counter[12]& counter[11]& counter[10]& & counter[9]& counter[8]& ~counter[7]& ~counter[6]& ~counter[5]& ~counter[4]& counter[3]& ~counter[2]& ~counter[1]& ~counter[0];
   //assign fasterswitch = counter[20]& ~counter[19]& counter[18]& counter[17]& counter[16]& counter[15]& counter[14]& ~counter[13]& counter[12]& ~counter[11]& counter[10]& counter[9]& counter[8]& counter[7]& ~counter[6]& ~counter[5]& ~counter[4]& ~counter[3]& counter[2]& ~counter[1]& ~counter[0];
   assign fasterswitch = counter[19]& ~counter[18]& counter[17]& counter[16]& counter[15]& counter[14]& counter[13]& ~counter[12]& counter[11]& ~counter[10]& counter[9]& counter[8]& counter[7]& counter[6]& ~counter[5]& ~counter[4]& ~counter[3]& ~counter[2]& counter[1]& ~counter[0];
   MUX21(cur_phase[0],fasterswitch,switch,chooseswitch);
   
   
   assign man_state_n[3] = (cur_phase[2]| cur_phase[1])?0 :(chooseswitch)? (~man_state[3]&man_state[2]&man_state[1]&man_state[0]) :man_state[3] ;
   assign man_state_n[2] = (cur_phase[2]| cur_phase[1])?0 :(chooseswitch)? ((man_state[2]&~man_state[1])|(man_state[2]&~man_state[0])|(~man_state[2]&man_state[1]&man_state[0])):man_state[2];
   assign man_state_n[1] = (cur_phase[2]| cur_phase[1])?0 :(chooseswitch)? ((~man_state[1]& man_state[0])|(man_state[1]&~man_state[0])) :man_state[1];
   assign man_state_n[0] = (cur_phase[2]| cur_phase[1])?0 :(chooseswitch)? ((~man_state[1]&~man_state[0])|(man_state[1]&~man_state[0])):man_state[0];    
   
   assign counter_n[0] = (chooseswitch)? 0: ~counter[0];
   assign counter_n[1] = (chooseswitch)?0:( counter[0])? ~counter[1]:counter[1];
   assign counter_n[2] = (chooseswitch)?0:( counter[0]& counter[1])? ~counter[2]:counter[2];
   assign counter_n[3] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2])? ~counter[3]:counter[3];
   assign counter_n[4] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3])? ~counter[4]:counter[4];
   assign counter_n[5] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4])? ~counter[5]:counter[5];
   assign counter_n[6] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5])? ~counter[6]:counter[6];
   assign counter_n[7] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6])? ~counter[7]:counter[7];
   assign counter_n[8] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7])? ~counter[8]:counter[8];
   assign counter_n[9] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8])? ~counter[9]:counter[9];
   assign counter_n[10] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9])? ~counter[10]:counter[10];
   assign counter_n[11] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10])? ~counter[11]:counter[11];
   assign counter_n[12] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       )? ~counter[12]:counter[12];
   assign counter_n[13] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12])? ~counter[13]:counter[13];
   assign counter_n[14] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12]& counter[13])? ~counter[14]:counter[14];
   assign counter_n[15] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12]& counter[13]& counter[14])? ~counter[15]:counter[15];
   assign counter_n[16] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12]& counter[13]& counter[14]& counter[15])? ~counter[16]:counter[16];
   assign counter_n[17] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12]& counter[13]& counter[14]& counter[15]& counter[16])? ~counter[17]:counter[17];
   assign counter_n[18] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17])? ~counter[18]:counter[18];
   assign counter_n[19] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18])? ~counter[19]:counter[19];
   assign counter_n[20] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19])? ~counter[20]:counter[20];
   assign counter_n[21] = (chooseswitch)?0:( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
       & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20])? ~counter[21]:counter[21];
   
//=======    Reuse SevenSegment    ======
//=======================================
    
endmodule
