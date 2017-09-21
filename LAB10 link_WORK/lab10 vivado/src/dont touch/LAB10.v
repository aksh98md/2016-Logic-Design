//////////////////////////////////////////////////////////////////////////////////
// Module Name: LAB10
// Submodule: ButtonFSM
//////////////////////////////////////////////////////////////////////////////////

module LAB10(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,        // 100 MHz clock
    input      [15:0]       sw,         // 16 Switches, sw[15] for asynchronous reset
    input                   btnU,       // Up     Button
    input                   btnD,       // Down   Button
    //====================================================
    //=======           Output                      ======
    //====================================================
    //-----------7 segment display-----
    output reg [6:0]        seg,         // Number
    output                  dp,          // Dot point
    output reg [3:0]        an           // Mux for 4 number
    );
    
    //=======================================================
    //  REG/WIRE declarations
    //=======================================================
    wire rst;
    wire clk25; //25 MHz clock
    wire de_btnU, de_btnD;
    reg [3:0]   num3;
    reg [3:0]   num2;
    reg [3:0]   num1;
    reg [3:0]   num0;
    reg [3:0]   mask;
    reg [3:0]   counter, next_counter;
    reg [16:0]  cnt_time, next_cnt_time;
    reg [6:0]   next_seg;
    reg [3:0]   next_an;
    reg [6:0]   seg0,seg1,seg2,seg3;

    //=======================================================
    //  Combinational Part
    //======================================================= 
    assign rst = sw[15];
    assign dp = 1'b1;
    
    clk_wiz_0       ck0(.clk_in1(clk), .clk_out1(clk25), .reset(rst));
    ButtonFSM       bU(.clk(clk25), .rst(rst), .button(btnU), .debounced(de_btnU));
    ButtonFSM       bD(.clk(clk25), .rst(rst), .button(btnD), .debounced(de_btnD));
    
    always@(*) begin
        if(de_btnU) next_counter = (counter==9)?9:counter+1;
        else if(de_btnD) next_counter = (counter==0)?0:counter-1;
        else next_counter = counter;
        mask = 4'b0001;
        num0 = counter;
        num1 = 0;
        num2 = 0;
        num3 = 0;
    end
    
    always@(*) begin
        case(num3) 
        4'd0: seg3 = 7'b1000000;
        4'd1: seg3 = 7'b1111001;
        4'd2: seg3 = 7'b0100100;
        4'd3: seg3 = 7'b0110000;
        4'd4: seg3 = 7'b0011001;
        4'd5: seg3 = 7'b0010010;
        4'd6: seg3 = 7'b0000010;
        4'd7: seg3 = 7'b1111000;
        4'd8: seg3 = 7'b0000000;
        4'd9: seg3 = 7'b0010000;
        default: seg3 = 7'b1111111;
        endcase
        
        case(num2) 
        4'd0: seg2 = 7'b1000000;
        4'd1: seg2 = 7'b1111001;
        4'd2: seg2 = 7'b0100100;
        4'd3: seg2 = 7'b0110000;
        4'd4: seg2 = 7'b0011001;
        4'd5: seg2 = 7'b0010010;
        4'd6: seg2 = 7'b0000010;
        4'd7: seg2 = 7'b1111000;
        4'd8: seg2 = 7'b0000000;
        4'd9: seg2 = 7'b0010000;
        default: seg2 = 7'b1111111;
        endcase   
    
        case(num1) 
        4'd0: seg1 = 7'b1000000;
        4'd1: seg1 = 7'b1111001;
        4'd2: seg1 = 7'b0100100;
        4'd3: seg1 = 7'b0110000;
        4'd4: seg1 = 7'b0011001;
        4'd5: seg1 = 7'b0010010;
        4'd6: seg1 = 7'b0000010;
        4'd7: seg1 = 7'b1111000;
        4'd8: seg1 = 7'b0000000;
        4'd9: seg1 = 7'b0010000;
        default: seg1 = 7'b1111111;
        endcase  
        
        case(num0) 
        4'd0: seg0 = 7'b1000000;
        4'd1: seg0 = 7'b1111001;
        4'd2: seg0 = 7'b0100100;
        4'd3: seg0 = 7'b0110000;
        4'd4: seg0 = 7'b0011001;
        4'd5: seg0 = 7'b0010010;
        4'd6: seg0 = 7'b0000010;
        4'd7: seg0 = 7'b1111000;
        4'd8: seg0 = 7'b0000000;
        4'd9: seg0 = 7'b0010000;
        default: seg0 = 7'b1111111;
        endcase        
    end
    
    always@(*) begin
    next_cnt_time = cnt_time+1;
    case(cnt_time[16:15])
        2'b00: begin
               next_seg = (mask[3])?seg3:7'b1111111;
               next_an  = 4'b0111;
               end
        2'b01: begin
               next_seg = (mask[2])?seg2:7'b1111111;
               next_an  = 4'b1011;        
               end
        2'b10: begin
               next_seg = (mask[1])?seg1:7'b1111111;
               next_an  = 4'b1101;        
               end
        2'b11: begin
               next_seg = (mask[0])?seg0:7'b1111111;
               next_an  = 4'b1110;        
               end
    endcase
    end
    
    
    //=======================================================
    //  Sequential   Part
    //======================================================= 
    always@(posedge clk25 or posedge rst) begin
        if(rst) begin
            counter  <= 0;
            cnt_time <= 17'd0;
            seg      <= 7'b1111111;
            an       <= 4'b1111;
        end
        else begin
            counter  <= next_counter;
            cnt_time <= next_cnt_time;
            seg      <= next_seg;     
            an       <= next_an;      
        end
    end    
endmodule
