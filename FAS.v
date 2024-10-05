module FAS(
    input clk,
    input rst,
    input data_valid,
    input [15:0] data,

    output fir_valid,
    output [15:0] fir_d,

    output fft_valid,
    output [31:0] fft_d0,
    output [31:0] fft_d1,
    output [31:0] fft_d2,
    output [31:0] fft_d3,
    output [31:0] fft_d4,
    output [31:0] fft_d5,
    output [31:0] fft_d6,
    output [31:0] fft_d7,
    output [31:0] fft_d8,
    output [31:0] fft_d9,
    output [31:0] fft_d10,
    output [31:0] fft_d11,
    output [31:0] fft_d12,
    output [31:0] fft_d13,
    output [31:0] fft_d14,
    output [31:0] fft_d15,

    output done,
    output [3:0] freq
);

wire s2p_valid;                                                                              
wire signed [15:0] x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x13, x14, x15;     
wire signed [31:0] holds [15:0];                                                          

assign fft_d0 = holds[0];
assign fft_d1 = holds[1];
assign fft_d2 = holds[2];
assign fft_d3 = holds[3];
assign fft_d4 = holds[4];
assign fft_d5 = holds[5];
assign fft_d6 = holds[6];
assign fft_d7 = holds[7];
assign fft_d8 = holds[8];
assign fft_d9 = holds[9];
assign fft_d10 = holds[10];
assign fft_d11 = holds[11];
assign fft_d12 = holds[12];
assign fft_d13 = holds[13];
assign fft_d14 = holds[14];
assign fft_d15 = holds[15];


FIR FIR_1 (.clk(clk), .rst(rst), .data_valid(data_valid), .data(data), .fir_valid(fir_valid), .fir_d(fir_d));	

S2P S2P_1 (.clk(clk), .rst(rst), .fir_valid(fir_valid), .fir_d(fir_d), .s2p_valid(s2p_valid), .x0(x0), .x1(x1), .x2(x2), .x3(x3), .x4(x4), .x5(x5), .x6(x6), .x7(x7), .x8(x8), .x9(x9), .x10(x10), .x11(x11), .x12(x12), .x13(x13), .x14(x14), .x15(x15));

FFT FFT_1 (.clk(clk), .rst(rst), .s2p_valid(s2p_valid), .fft_valid(fft_valid), .x0(x0), .x1(x1), .x2(x2), .x3(x3), .x4(x4), .x5(x5)
            , .x6(x6), .x7(x7), .x8(x8), .x9(x9), .x10(x10), .x11(x11), .x12(x12), .x13(x13), .x14(x14), .x15(x15), .fft_d0(holds[0])
            , .fft_d1(holds[1]), .fft_d2(holds[2]), .fft_d3(holds[3]), .fft_d4(holds[4]), .fft_d5(holds[5]), .fft_d6(holds[6]), .fft_d7(holds[7])
            , .fft_d8(holds[8]), .fft_d9(holds[9]), .fft_d10(holds[10]), .fft_d11(holds[11]), .fft_d12(holds[12]), .fft_d13(holds[13]), .fft_d14(holds[14])
            , .fft_d15(holds[15])); 

Analysis analysis_1  (.clk(clk), .rst(rst), .fft_valid(fft_valid), .fft_d0(holds[0]), .fft_d1(holds[1]), .fft_d2(holds[2]), .fft_d3(holds[3]), .fft_d4(holds[4]), .fft_d5(holds[5]), .fft_d6(holds[6]),
                 .fft_d7(holds[7]), .fft_d8(holds[8]), .fft_d9(holds[9]), .fft_d10(holds[10]), .fft_d11(holds[11]), .fft_d12(holds[12]), .fft_d13(holds[13]), .fft_d14(holds[14]), .fft_d15(holds[15]), .done(done), .freq(freq));
 	

	
endmodule