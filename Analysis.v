module Analysis(
    input clk,
    input rst,
    input fft_valid,
    input signed [31:0] fft_d0,
    input signed [31:0] fft_d1,
    input signed [31:0] fft_d2,
    input signed [31:0] fft_d3,
    input signed [31:0] fft_d4,
    input signed [31:0] fft_d5,
    input signed [31:0] fft_d6,
    input signed [31:0] fft_d7,
    input signed [31:0] fft_d8,
    input signed [31:0] fft_d9,
    input signed [31:0] fft_d10,
    input signed [31:0] fft_d11,
    input signed [31:0] fft_d12,
    input signed [31:0] fft_d13,
    input signed [31:0] fft_d14,
    input signed [31:0] fft_d15,
    output reg done,
    output reg[3:0] freq
);

wire signed [31:0] fft_d [15:0];
wire signed [31:0] hold [15:0];
reg signed [31:0] biggerfreq;
integer i, j;

assign fft_d[0] = {(fft_d0[31] == 1 ? ~(fft_d0[31:16]) + 16'b1 : fft_d0[31:16]), (fft_d0[15] == 1 ? ~(fft_d0[15:0]) + 16'b1 : fft_d0[15:0])};
assign fft_d[1] = {(fft_d1[31] == 1 ? ~(fft_d1[31:16]) + 16'b1 : fft_d1[31:16]), (fft_d1[15] == 1 ? ~(fft_d1[15:0]) + 16'b1 : fft_d1[15:0])};
assign fft_d[2] = {(fft_d2[31] == 1 ? ~(fft_d2[31:16]) + 16'b1 : fft_d2[31:16]), (fft_d2[15] == 1 ? ~(fft_d2[15:0]) + 16'b1 : fft_d2[15:0])};
assign fft_d[3] = {(fft_d3[31] == 1 ? ~(fft_d3[31:16]) + 16'b1 : fft_d3[31:16]), (fft_d3[15] == 1 ? ~(fft_d3[15:0]) + 16'b1 : fft_d3[15:0])};
assign fft_d[4] = {(fft_d4[31] == 1 ? ~(fft_d4[31:16]) + 16'b1 : fft_d4[31:16]), (fft_d4[15] == 1 ? ~(fft_d4[15:0]) + 16'b1 : fft_d4[15:0])};
assign fft_d[5] = {(fft_d5[31] == 1 ? ~(fft_d5[31:16]) + 16'b1 : fft_d5[31:16]), (fft_d5[15] == 1 ? ~(fft_d5[15:0]) + 16'b1 : fft_d5[15:0])};
assign fft_d[6] = {(fft_d6[31] == 1 ? ~(fft_d6[31:16]) + 16'b1 : fft_d6[31:16]), (fft_d6[15] == 1 ? ~(fft_d6[15:0]) + 16'b1 : fft_d6[15:0])};
assign fft_d[7] = {(fft_d7[31] == 1 ? ~(fft_d7[31:16]) + 16'b1 : fft_d7[31:16]), (fft_d7[15] == 1 ? ~(fft_d7[15:0]) + 16'b1 : fft_d7[15:0])};
assign fft_d[8] = {(fft_d8[31] == 1 ? ~(fft_d8[31:16]) + 16'b1 : fft_d8[31:16]), (fft_d8[15] == 1 ? ~(fft_d8[15:0]) + 16'b1 : fft_d8[15:0])};
assign fft_d[9] = {(fft_d9[31] == 1 ? ~(fft_d9[31:16]) + 16'b1 : fft_d9[31:16]), (fft_d9[15] == 1 ? ~(fft_d9[15:0]) + 16'b1 : fft_d9[15:0])};
assign fft_d[10] = {(fft_d10[31] == 1 ? ~(fft_d10[31:16]) + 16'b1 : fft_d10[31:16]), (fft_d10[15] == 1 ? ~(fft_d10[15:0]) + 16'b1 : fft_d10[15:0])};
assign fft_d[11] = {(fft_d11[31] == 1 ? ~(fft_d11[31:16]) + 16'b1 : fft_d11[31:16]), (fft_d11[15] == 1 ? ~(fft_d11[15:0]) + 16'b1 : fft_d11[15:0])};
assign fft_d[12] = {(fft_d12[31] == 1 ? ~(fft_d12[31:16]) + 16'b1 : fft_d12[31:16]), (fft_d12[15] == 1 ? ~(fft_d12[15:0]) + 16'b1 : fft_d12[15:0])};
assign fft_d[13] = {(fft_d13[31] == 1 ? ~(fft_d13[31:16]) + 16'b1 : fft_d13[31:16]), (fft_d13[15] == 1 ? ~(fft_d13[15:0]) + 16'b1 : fft_d13[15:0])};
assign fft_d[14] = {(fft_d14[31] == 1 ? ~(fft_d14[31:16]) + 16'b1 : fft_d14[31:16]), (fft_d14[15] == 1 ? ~(fft_d14[15:0]) + 16'b1 : fft_d14[15:0])};
assign fft_d[15] = {(fft_d15[31] == 1 ? ~(fft_d15[31:16]) + 16'b1 : fft_d15[31:16]), (fft_d15[15] == 1 ? ~(fft_d15[15:0]) + 16'b1 : fft_d15[15:0])};


assign hold[0] = fft_d[0][31:16]*fft_d[0][31:16] + fft_d[0][15:0]*fft_d[0][15:0];
assign hold[1] = fft_d[1][31:16]*fft_d[1][31:16] + fft_d[1][15:0]*fft_d[1][15:0];
assign hold[2] = fft_d[2][31:16]*fft_d[2][31:16] + fft_d[2][15:0]*fft_d[2][15:0];
assign hold[3] = fft_d[3][31:16]*fft_d[3][31:16] + fft_d[3][15:0]*fft_d[3][15:0];
assign hold[4] = fft_d[4][31:16]*fft_d[4][31:16] + fft_d[4][15:0]*fft_d[4][15:0];
assign hold[5] = fft_d[5][31:16]*fft_d[5][31:16] + fft_d[5][15:0]*fft_d[5][15:0];
assign hold[6] = fft_d[6][31:16]*fft_d[6][31:16] + fft_d[6][15:0]*fft_d[6][15:0];
assign hold[7] = fft_d[7][31:16]*fft_d[7][31:16] + fft_d[7][15:0]*fft_d[7][15:0];
assign hold[8] = fft_d[8][31:16]*fft_d[8][31:16] + fft_d[8][15:0]*fft_d[8][15:0];
assign hold[9] = fft_d[9][31:16]*fft_d[9][31:16] + fft_d[9][15:0]*fft_d[9][15:0];
assign hold[10] = fft_d[10][31:16]*fft_d[10][31:16] + fft_d[10][15:0]*fft_d[10][15:0];
assign hold[11] = fft_d[11][31:16]*fft_d[11][31:16] + fft_d[11][15:0]*fft_d[11][15:0];
assign hold[12] = fft_d[12][31:16]*fft_d[12][31:16] + fft_d[12][15:0]*fft_d[12][15:0];
assign hold[13] = fft_d[13][31:16]*fft_d[13][31:16] + fft_d[13][15:0]*fft_d[13][15:0];
assign hold[14] = fft_d[14][31:16]*fft_d[14][31:16] + fft_d[14][15:0]*fft_d[14][15:0];
assign hold[15] = fft_d[15][31:16]*fft_d[15][31:16] + fft_d[15][15:0]*fft_d[15][15:0];

always@(posedge clk, posedge rst) begin
    if (rst) begin
        biggerfreq <= 0;
        done = 0;
    end
    else begin
        if (fft_valid) begin
            done = 1;
            j = 0;
            biggerfreq = 0;
            for (i = 0; i < 16; i = i + 1) begin
                if (hold[i] > biggerfreq) begin
                    biggerfreq = hold[i];
                    j = i;
                end
            end
            case (j)
                0: begin
                    freq = 4'b0000;
                end
                1: begin
                    freq = 4'b0001;
                end
                2: begin
                    freq = 4'b0010;
                end
                3: begin
                    freq = 4'b0011;
                end
                4: begin
                    freq = 4'b0100;
                end
                5: begin
                    freq = 4'b0101;
                end
                6: begin
                    freq = 4'b0110;
                end
                7: begin
                    freq = 4'b0111;
                end
                8: begin
                    freq = 4'b1000;
                end
                9: begin
                    freq = 4'b1001;
                end
                10: begin
                    freq = 4'b1010;
                end
                11: begin
                    freq = 4'b1011;
                end
                12: begin
                    freq = 4'b1100;
                end
                13: begin
                    freq = 4'b1101;
                end
                14: begin
                    freq = 4'b1110;
                end
                15: begin
                    freq = 4'b1111;
                end
                default begin
                    freq = 4'bxxxx;
                end
            endcase 
         end
         else begin
            done = 0;
         end
     end
end
    
    
    
endmodule