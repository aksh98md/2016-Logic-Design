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
    input          [7:0]    sw,     
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------7 segment display-----
    output      [15:0]       cur_sec,     // Number
   
    output      [14:0]      led,          // led0
    output         reg         stopsignal
    );
    
//=======================================
reg [2:0] ledchooser;
    reg [7:0] a;
    assign led[0] = a[0];
    assign led[1] = a[1];
    assign led[2] = a[2];
    assign led[3] = a[3];
    assign led[4] = a[4];
    assign led[5] = a[5];
    assign led[6] = a[6];
    assign led[7] = a[7];
    
    /*assign cur_sec[0] = ledchooser[0];
    assign cur_sec[1] = ledchooser[1];
    assign cur_sec[2] = ledchooser[2];*/
    
    wire [24:0] counter;
    wire [24:0] counter_n;
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
    
       assign counter_n[0] =  ~counter[0];
       assign counter_n[1] = (  counter[0])? ~counter[1]:counter[1];
       assign counter_n[2] = ( counter[0]& counter[1])? ~counter[2]:counter[2];
       assign counter_n[3] = ( counter[0]& counter[1]& counter[2])? ~counter[3]:counter[3];
       assign counter_n[4] = ( counter[0]& counter[1]& counter[2]& counter[3])? ~counter[4]:counter[4];
       assign counter_n[5] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4])? ~counter[5]:counter[5];
       assign counter_n[6] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5])? ~counter[6]:counter[6];
       assign counter_n[7] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6])? ~counter[7]:counter[7];
       assign counter_n[8] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7])? ~counter[8]:counter[8];
       assign counter_n[9] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8])? ~counter[9]:counter[9];
       assign counter_n[10] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9])? ~counter[10]:counter[10];
       assign counter_n[11] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10])? ~counter[11]:counter[11];
       assign counter_n[12] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               )? ~counter[12]:counter[12];
       assign counter_n[13] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12])? ~counter[13]:counter[13];
       assign counter_n[14] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13])? ~counter[14]:counter[14];
       assign counter_n[15] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14])? ~counter[15]:counter[15];
       assign counter_n[16] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14]& counter[15])? ~counter[16]:counter[16];
       assign counter_n[17] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14]& counter[15]& counter[16])? ~counter[17]:counter[17];
       assign counter_n[18] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17])? ~counter[18]:counter[18];
       assign counter_n[19] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18])? ~counter[19]:counter[19];
       assign counter_n[20] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19])? ~counter[20]:counter[20];
       assign counter_n[21] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20])? ~counter[21]:counter[21];
       assign counter_n[22] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20]& counter[21])? ~counter[22]:counter[22];
                               
       assign counter_n[23] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]
                               & counter[12]& counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20]& counter[21]& counter[22])? ~counter[23]:counter[23];
       assign counter_n[24] = ( counter[0]& counter[1]& counter[2]& counter[3]& counter[4]& counter[5]& counter[6]& counter[7]& counter[8]& counter[9]& counter[10]& counter[11]& counter[12]& 
                               counter[13]& counter[14]& counter[15]& counter[16]& counter[17]& counter[18]& counter[19]& counter[20]& counter[21]& counter[22]& counter[23])? ~counter[24]:counter[24];
       
   // integer r;
   // integer i;
    
    
    
    always@(posedge clk) begin
    if (set==1'b1) begin
        a =8'b00000000;
    end
        
        if (set==1'b0 && a == 8'b00000000)  begin
             // r = 3'b111;
             // for (i=r;i>0;i=i-1) begin
             //     #500;
             // end 
              ledchooser[0] = counter[20];
              ledchooser[1] = counter[21];
              ledchooser[2] = counter[22];
              case(ledchooser)
                     3'b000: begin
                         a[0] = 1'b1;
                     end
                     3'b001: begin
                          a[1] = 1'b1;
                     end
                     3'b010: begin
                          a[2] = 1'b1;
                     end
                     3'b011: begin
                          a[3] = 1'b1;
                     end
                     3'b100: begin
                          a[4] = 1'b1;
                     end
                     3'b101: begin
                          a[5] = 1'b1;
                     end
                     3'b110: begin
                          a[6] = 1'b1;
                     end
                     3'b111: begin
                          a[7] = 1'b1;
                     end
                 endcase
           end
           
           if (ledchooser==3'b000) begin
                stopsignal = sw[0];
           end else if(ledchooser==3'b001) begin
                stopsignal = sw[1];
           end else if(ledchooser==3'b010) begin
                stopsignal = sw[2];
           end else if(ledchooser==3'b011) begin
                 stopsignal = sw[3];
           end else if(ledchooser==3'b100) begin
                 stopsignal = sw[4];
           end else if(ledchooser==3'b101) begin
                 stopsignal = sw[5];
           end else if(ledchooser==3'b110) begin
                 stopsignal = sw[6];
           end else if(ledchooser==3'b111) begin
                 stopsignal = sw[7];
           end 
           
    end
    
    //¼Æ´X­Óms
    reg [30:0] counterms, next_counterms;
        reg [15:0]  next_cur_sec;
        reg        switch_flag;
        reg [15:0] cur_secms;
        assign cur_sec = cur_secms;
        
        always@(posedge clk) begin
            switch_flag = (counterms == 12500); // 1 sec for 25 MHz clock
            if(set) begin
                next_counterms = 0;
                next_cur_sec = 0;
            end
            else begin
                next_counterms = (switch_flag)?0:counterms+1;
                next_cur_sec = (switch_flag&~stopsignal)? cur_secms+1 : cur_secms;
            end
        end
        
        always@(posedge clk or posedge rst) begin
            if(rst) begin
                counterms <= 0;
                cur_secms <= 0;
            end
            else begin
                counterms <= next_counterms;
                cur_secms <= next_cur_sec;
            end
        end

endmodule

/////////////////BUGS
//other side starts at 1111(15)
