module S2P(
    input clk,
    input rst,
    input fir_valid,
    input signed [15:0]fir_d,
    output reg s2p_valid,
    output reg signed [15:0] x0,
    output reg signed [15:0] x1,
    output reg signed [15:0] x2,
    output reg signed [15:0] x3,
    output reg signed [15:0] x4,
    output reg signed [15:0] x5,
    output reg signed [15:0] x6,
    output reg signed [15:0] x7,
    output reg signed [15:0] x8,
    output reg signed [15:0] x9,
    output reg signed [15:0] x10,
    output reg signed [15:0] x11,
    output reg signed [15:0] x12,
    output reg signed [15:0] x13,
    output reg signed [15:0] x14,
    output reg signed [15:0] x15
);

reg signed [15:0] hold [15:0];  
integer i;

always@(posedge clk, posedge rst) begin
    if (rst) begin
        s2p_valid <= 0;         
        i = 0;
    end
    else begin                  
        if (s2p_valid) begin       ‚å ‡å…¶  ‰ä  
            s2p_valid <= 0;
            i = 0;                 „è ‡æ  
        end
        if (fir_valid) begin        
            hold[i] = fir_d;     
            i = i + 1;             ä 
        end
        if (i == 16) begin
            s2p_valid <= 1;     
        end
    end
    x0 <= hold[0];              
    x1 <= hold[1];
    x2 <= hold[2];
    x3 <= hold[3];
    x4 <= hold[4];
    x5 <= hold[5];
    x6 <= hold[6];
    x7 <= hold[7];
    x8 <= hold[8];
    x9 <= hold[9];
    x10 <= hold[10];
    x11 <= hold[11];
    x12 <= hold[12];
    x13 <= hold[13];
    x14 <= hold[14];
    x15 <= hold[15];
end

endmodule