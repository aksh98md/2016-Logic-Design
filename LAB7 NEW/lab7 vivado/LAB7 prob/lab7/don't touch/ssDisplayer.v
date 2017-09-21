//////////////////////////////////////////////////////////////////////////////////
// Submodule Name: ssDisplayer
//////////////////////////////////////////////////////////////////////////////////

module ssDisplayer(
    //====================================================
    //=======           Input                       ======
    //====================================================
    input                   clk,         // 25 MHz clock
    input                   rst,         // Asynchronus reset
    input      [3:0]        mask,        // 1-bit encode, position of displayed num e.g. 1000:rightest display
    input      [6:0]        seg3,    
    input      [6:0]        seg2,     
    input      [6:0]        seg1,         
    input      [6:0]        seg0,         
    //====================================================
    //=======           Output                      ======
    //====================================================
    output reg [6:0]       seg,         // Number
    output                 dp_on,       // Dot point
    output reg [3:0]       an           // Mux for 4 number
    );

assign dp_on = 1'b1;
reg  [16:0] cnt_time, next_cnt_time;
reg  [6:0]  next_seg;
reg  [3:0]  next_an;

always@(*) begin
    next_cnt_time = cnt_time+1;
    case(cnt_time[16:15])
        2'b00: begin
               next_seg = (~mask[3])?seg3:7'b1111111;
               next_an  = 4'b0111;
               end
        2'b01: begin
               next_seg = (~mask[2])?seg2:7'b1111111;
               next_an  = 4'b1011;        
               end
        2'b10: begin
               next_seg = (~mask[1])?seg1:7'b1111111;
               next_an  = 4'b1101;        
               end
        2'b11: begin
               next_seg = (~mask[0])?seg0:7'b1111111;
               next_an  = 4'b1110;        
               end
    endcase
end

always@(posedge clk or posedge rst) begin
    if(rst) begin
        cnt_time <= 17'd0;
        seg      <= 7'b1111111;
        an       <= 4'b1111;
    end
    else begin
        cnt_time <= next_cnt_time;
        seg      <= next_seg;
        an       <= next_an;
    end
end
endmodule