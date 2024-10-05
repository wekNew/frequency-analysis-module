module FFT(
    input clk,
    input rst,
    input s2p_valid,
    input signed [15:0] x0,
    input signed [15:0] x1,
    input signed [15:0] x2,
    input signed [15:0] x3,
    input signed [15:0] x4,
    input signed [15:0] x5,
    input signed [15:0] x6,
    input signed [15:0] x7,
    input signed [15:0] x8,
    input signed [15:0] x9,
    input signed [15:0] x10,
    input signed [15:0] x11,
    input signed [15:0] x12,
    input signed [15:0] x13,
    input signed [15:0] x14,
    input signed [15:0] x15,
    output reg fft_valid,
    output signed [31:0] fft_d0,
    output signed [31:0] fft_d1,
    output signed [31:0] fft_d2,
    output signed [31:0] fft_d3,
    output signed [31:0] fft_d4,
    output signed [31:0] fft_d5,
    output signed [31:0] fft_d6,
    output signed [31:0] fft_d7,
    output signed [31:0] fft_d8,
    output signed [31:0] fft_d9,
    output signed [31:0] fft_d10,
    output signed [31:0] fft_d11,
    output signed [31:0] fft_d12,
    output signed [31:0] fft_d13,
    output signed [31:0] fft_d14,
    output signed [31:0] fft_d15
);
`include "FFT_coefficient.dat"
reg signed [15:0] save_0;
reg signed [15:0] save_1;
reg signed [15:0] save_2;
reg signed [15:0] save_3;
reg signed [15:0] save_4;
reg signed [15:0] save_5;
reg signed [15:0] save_6;
reg signed [15:0] save_7;
reg signed [15:0] save_8;
reg signed [15:0] save_9;
reg signed [15:0] save_10;
reg signed [15:0] save_11;
reg signed [15:0] save_12;
reg signed [15:0] save_13;
reg signed [15:0] save_14;
reg signed [15:0] save_15;
integer i;

always@(posedge clk)begin   
    if(rst) begin
        save_0 <= 16'b0;
        save_1 <= 16'b0;
        save_2 <= 16'b0;
        save_3 <= 16'b0;
        save_4 <= 16'b0;
        save_5 <= 16'b0;
        save_6 <= 16'b0;
        save_7 <= 16'b0;
        save_8 <= 16'b0;
        save_9 <= 16'b0;
        save_10 <= 16'b0;
        save_11 <= 16'b0;
        save_12 <= 16'b0;
        save_13 <= 16'b0;
        save_14 <= 16'b0;
        save_15 <= 16'b0;
    end
    else begin
        if(s2p_valid)begin
            save_0  <= x0;
            save_1  <= x1;
            save_2  <= x2;
            save_3  <= x3;
            save_4  <= x4;
            save_5  <= x5;
            save_6  <= x6;
            save_7  <= x7;
            save_8  <= x8;
            save_9  <= x9;
            save_10 <= x10;
            save_11 <= x11;
            save_12 <= x12;
            save_13 <= x13;
            save_14 <= x14;
            save_15 <= x15;
        end 
        else begin
            save_0  <= save_0;
            save_1  <= save_1;
            save_2  <= save_2;
            save_3  <= save_3;
            save_4  <= save_4;
            save_5  <= save_5;
            save_6  <= save_6;
            save_7  <= save_7;
            save_8  <= save_8;
            save_9  <= save_9;
            save_10 <= save_10;
            save_11 <= save_11;
            save_12 <= save_12;
            save_13 <= save_13;
            save_14 <= save_14;
            save_15 <= save_15;
        end
    end
end

always@(posedge clk)begin         
    if(rst) fft_valid <= 1'b0;
    else begin
        fft_valid <= s2p_valid;
    end
end


//FIRST LAYER
wire signed [31:0] save_0_w;
wire signed [31:0] save_1_w;
wire signed [31:0] save_2_w;
wire signed [31:0] save_3_w;
wire signed [31:0] save_4_w;
wire signed [31:0] save_5_w;
wire signed [31:0] save_6_w;
wire signed [31:0] save_7_w;
wire signed [31:0] save_8_w;
wire signed [31:0] save_9_w;
wire signed [31:0] save_10_w;
wire signed [31:0] save_11_w;
wire signed [31:0] save_12_w;
wire signed [31:0] save_13_w;
wire signed [31:0] save_14_w;
wire signed [31:0] save_15_w;

assign save_0_w  = {save_0, 16'd0};
assign save_1_w  = {save_1, 16'd0};
assign save_2_w  = {save_2, 16'd0};
assign save_3_w  = {save_3, 16'd0};
assign save_4_w  = {save_4, 16'd0};
assign save_5_w  = {save_5, 16'd0};
assign save_6_w  = {save_6, 16'd0};
assign save_7_w  = {save_7, 16'd0};
assign save_8_w  = {save_8, 16'd0};
assign save_9_w  = {save_9, 16'd0};
assign save_10_w = {save_10, 16'd0};
assign save_11_w = {save_11, 16'd0};
assign save_12_w = {save_12, 16'd0};
assign save_13_w = {save_13, 16'd0};
assign save_14_w = {save_14, 16'd0};
assign save_15_w = {save_15, 16'd0};

wire signed [93:0] point_0_0;
wire signed [93:0] point_1_0;
wire signed [93:0] point_2_0;
wire signed [93:0] point_3_0;
wire signed [93:0] point_4_0;
wire signed [93:0] point_5_0;
wire signed [93:0] point_6_0;
wire signed [93:0] point_7_0;
wire signed [93:0] point_8_0;
wire signed [93:0] point_9_0;
wire signed [93:0] point_10_0;
wire signed [93:0] point_11_0;
wire signed [93:0] point_12_0;
wire signed [93:0] point_13_0;
wire signed [93:0] point_14_0;
wire signed [93:0] point_15_0;
ADDER  point00( save_0_w, save_8_w,  point_0_0);
ADDER  point10( save_1_w, save_9_w,  point_1_0);
ADDER  point20( save_2_w, save_10_w, point_2_0);
ADDER  point30( save_3_w, save_11_w, point_3_0);
ADDER  point40( save_4_w, save_12_w, point_4_0);
ADDER  point50( save_5_w, save_13_w, point_5_0);
ADDER  point60( save_6_w, save_14_w, point_6_0);
ADDER  point70( save_7_w, save_15_w, point_7_0);
COUNT  point80( save_0_w, save_8_w,  FFT_R0, FFT_I0, point_8_0);
COUNT  point90( save_1_w, save_9_w,  FFT_R1, FFT_I1, point_9_0);
COUNT  point100(save_2_w, save_10_w, FFT_R2, FFT_I2, point_10_0);
COUNT  point110(save_3_w, save_11_w, FFT_R3, FFT_I3, point_11_0);
COUNT  point120(save_4_w, save_12_w, FFT_R4, FFT_I4, point_12_0);
COUNT  point130(save_5_w, save_13_w, FFT_R5, FFT_I5, point_13_0);
COUNT  point140(save_6_w, save_14_w, FFT_R6, FFT_I6, point_14_0);
COUNT  point150(save_7_w, save_15_w, FFT_R7, FFT_I7, point_15_0);
//SECOND LAYER
wire signed [155:0] point_0_1;
wire signed [155:0] point_1_1;
wire signed [155:0] point_2_1;
wire signed [155:0] point_3_1;
wire signed [155:0] point_4_1;
wire signed [155:0] point_5_1;
wire signed [155:0] point_6_1;
wire signed [155:0] point_7_1;
wire signed [155:0] point_8_1;
wire signed [155:0] point_9_1;
wire signed [155:0] point_10_1;
wire signed [155:0] point_11_1;
wire signed [155:0] point_12_1;
wire signed [155:0] point_13_1;
wire signed [155:0] point_14_1;
wire signed [155:0] point_15_1;
ADDER_1  point01(point_0_0, point_4_0, point_0_1);
ADDER_1  point11(point_1_0, point_5_0, point_1_1);
ADDER_1  point21(point_2_0, point_6_0, point_2_1);
ADDER_1  point31(point_3_0, point_7_0, point_3_1);
COUNT_1  point41(point_0_0, point_4_0, FFT_R0, FFT_I0, point_4_1);
COUNT_1  point51(point_1_0, point_5_0, FFT_R2, FFT_I2, point_5_1);
COUNT_1  point61(point_2_0, point_6_0, FFT_R4, FFT_I4, point_6_1);
COUNT_1  point71(point_3_0, point_7_0, FFT_R6, FFT_I6, point_7_1);
ADDER_1  point81 (point_8_0,  point_12_0, point_8_1);
ADDER_1  point91 (point_9_0,  point_13_0, point_9_1);
ADDER_1  point101(point_10_0, point_14_0, point_10_1);
ADDER_1  point111(point_11_0, point_15_0, point_11_1);
COUNT_1  point121(point_8_0,  point_12_0, FFT_R0, FFT_I0, point_12_1);
COUNT_1  point131(point_9_0,  point_13_0, FFT_R2, FFT_I2, point_13_1);
COUNT_1  point141(point_10_0, point_14_0, FFT_R4, FFT_I4, point_14_1);
COUNT_1  point151(point_11_0, point_15_0, FFT_R6, FFT_I6, point_15_1);
//THIRD LAYER
wire signed [217:0] point_0_2;
wire signed [217:0] point_1_2;
wire signed [217:0] point_2_2;
wire signed [217:0] point_3_2;
wire signed [217:0] point_4_2;
wire signed [217:0] point_5_2;
wire signed [217:0] point_6_2;
wire signed [217:0] point_7_2;
wire signed [217:0] point_8_2;
wire signed [217:0] point_9_2;
wire signed [217:0] point_10_2;
wire signed [217:0] point_11_2;
wire signed [217:0] point_12_2;
wire signed [217:0] point_13_2;
wire signed [217:0] point_14_2;
wire signed [217:0] point_15_2;
ADDER_2  point02(point_0_1, point_2_1, point_0_2);
ADDER_2  point12(point_1_1, point_3_1, point_1_2);
COUNT_2  point22(point_0_1, point_2_1, FFT_R0, FFT_I0, point_2_2);
COUNT_2  point32(point_1_1, point_3_1, FFT_R4, FFT_I4, point_3_2);
ADDER_2  point42(point_4_1, point_6_1, point_4_2);
ADDER_2  point52(point_5_1, point_7_1, point_5_2);
COUNT_2  point62(point_4_1, point_6_1, FFT_R0, FFT_I0, point_6_2);
COUNT_2  point72(point_5_1, point_7_1, FFT_R4, FFT_I4, point_7_2);
ADDER_2  point82(point_8_1, point_10_1, point_8_2);
ADDER_2  point92(point_9_1, point_11_1, point_9_2);
COUNT_2  point102(point_8_1, point_10_1, FFT_R0, FFT_I0, point_10_2);
COUNT_2  point112(point_9_1, point_11_1, FFT_R4, FFT_I4, point_11_2);
ADDER_2  point122(point_12_1, point_14_1, point_12_2);
ADDER_2  point132(point_13_1, point_15_1, point_13_2);
COUNT_2  point142(point_12_1, point_14_1, FFT_R0, FFT_I0, point_14_2);
COUNT_2  point152(point_13_1, point_15_1, FFT_R4, FFT_I4, point_15_2);
//FORTH LAYER
wire signed [31:0] point_0_3;
wire signed [31:0] point_1_3;
wire signed [31:0] point_2_3;
wire signed [31:0] point_3_3;
wire signed [31:0] point_4_3;
wire signed [31:0] point_5_3;
wire signed [31:0] point_6_3;
wire signed [31:0] point_7_3;
wire signed [31:0] point_8_3;
wire signed [31:0] point_9_3;
wire signed [31:0] point_10_3;
wire signed [31:0] point_11_3;
wire signed [31:0] point_12_3;
wire signed [31:0] point_13_3;
wire signed [31:0] point_14_3;
wire signed [31:0] point_15_3;
ADDER_3  point03(point_0_2, point_1_2, point_0_3);
COUNT_3  point13(point_0_2, point_1_2, FFT_R0, FFT_I0, point_1_3);
ADDER_3  point23(point_2_2, point_3_2, point_2_3);
COUNT_3  point33(point_2_2, point_3_2, FFT_R0, FFT_I0, point_3_3);
ADDER_3  point43(point_4_2, point_5_2, point_4_3);
COUNT_3  point53(point_4_2, point_5_2, FFT_R0, FFT_I0, point_5_3);
ADDER_3  point63(point_6_2, point_7_2, point_6_3);
COUNT_3  point73(point_6_2, point_7_2, FFT_R0, FFT_I0, point_7_3);
ADDER_3  point83(point_8_2, point_9_2, point_8_3);
COUNT_3  point93(point_8_2, point_9_2, FFT_R0, FFT_I0, point_9_3);
ADDER_3  point103(point_10_2, point_11_2, point_10_3);
COUNT_3  point113(point_10_2, point_11_2, FFT_R0, FFT_I0, point_11_3);
ADDER_3  point123(point_12_2, point_13_2, point_12_3);
COUNT_3  point133(point_12_2, point_13_2, FFT_R0, FFT_I0, point_13_3);
ADDER_3  point143(point_14_2, point_15_2, point_14_3);
COUNT_3  point153(point_14_2, point_15_2, FFT_R0, FFT_I0, point_15_3);

assign fft_d0 = point_0_3;
assign fft_d1 = point_8_3;
assign fft_d2 = point_4_3;
assign fft_d3 = point_12_3;
assign fft_d4 = point_2_3;
assign fft_d5 = point_10_3;
assign fft_d6 = point_6_3;
assign fft_d7 = point_14_3;
assign fft_d8 = point_1_3;
assign fft_d9 = point_9_3;
assign fft_d10 = point_5_3;
assign fft_d11 = point_13_3;
assign fft_d12 = point_3_3;
assign fft_d13 = point_11_3;
assign fft_d14 = point_7_3;
assign fft_d15 = point_15_3;
endmodule

module ADDER(
    input signed [31:0] X,
    input signed [31:0] Y,
    output signed [93:0] ADDER
);

wire signed[15:0] real_X;
wire signed[15:0] image_X;
wire signed[15:0] real_Y;
wire signed[15:0] image_Y;

assign real_X = X[31:16];
assign image_X = X[15:0];
assign real_Y = Y[31:16];
assign image_Y = Y[15:0];


wire  signed[46:0] A;
wire  signed[46:0] B;
assign A =$signed({real_X[15],(real_X[15] == 1 ? 2**16 - 1 : 15'b0),real_X[14:0],$signed(16'd0) })+$signed({real_Y[15],(real_Y[15] == 1 ? 2**16 - 1 : 15'b0),real_Y[14:0],$signed(16'd0) });
assign B =$signed({image_X[15],(image_X[15] == 1 ? 2**16 - 1 : 15'b0),image_X[14:0],$signed(16'd0) })+$signed({image_Y[15],(image_Y[15] == 1 ? 2**16 - 1 : 15'b0),image_Y[14:0],$signed(16'd0) });


assign ADDER = {A,B};
endmodule

module ADDER_1(
    input signed [93:0] X,
    input signed [93:0] Y,
    output signed [155:0] ADDER
);

wire signed [46:0] real_X;
wire signed [46:0] image_X;
wire signed [46:0] real_Y;
wire signed [46:0] image_Y;

assign real_X = X[93:47];
assign image_X = X[46:0];
assign real_Y = Y[93:47];
assign image_Y = Y[46:0];


wire signed[77:0] A;
wire signed[77:0] B;
assign A =$signed({real_X[46],(real_X[46] == 1 ? 2**16 - 1 : 15'b0),real_X[45:0],$signed(16'd0) })+$signed({real_Y[46],(real_Y[46] == 1 ? 2**16 - 1 : 15'b0),real_Y[45:0],$signed(16'd0) });
assign B =$signed({image_X[46],(image_X[46] == 1 ? 2**16 - 1 : 15'b0),image_X[45:0],$signed(16'd0) })+$signed({image_Y[46],(image_Y[46] == 1 ? 2**16 - 1 : 15'b0),image_Y[45:0],$signed(16'd0) });



assign ADDER = {A,B};
endmodule

module ADDER_2(
    input signed [155:0] X,
    input signed [155:0] Y,
    output signed [217:0] ADDER
);

wire signed [77:0] real_X;
wire signed [77:0] image_X;
wire signed [77:0] real_Y;
wire signed [77:0] image_Y;

assign real_X = X[155:78];
assign image_X = X[77:0];
assign real_Y = Y[155:78];
assign image_Y = Y[77:0];


wire signed [108:0] A;
wire signed [108:0] B;
assign A =$signed({real_X[77],(real_X[77] == 1 ? 2**16 - 1 : 15'b0),real_X[76:0],$signed(16'd0) })+$signed({real_Y[77],(real_Y[77] == 1 ? 2**16 - 1 : 15'b0),real_Y[76:0],$signed(16'd0) });
assign B =$signed({image_X[77],(image_X[77] == 1 ? 2**16 - 1 : 15'b0),image_X[76:0],$signed(16'd0) })+$signed({image_Y[77],(image_Y[77] == 1 ? 2**16 - 1 : 15'b0),image_Y[76:0],$signed(16'd0) });


assign ADDER = {A,B};
endmodule

module ADDER_3(
    input signed [217:0] X,
    input signed [217:0] Y,
    output signed [31:0] ADDER
);

wire signed [108:0] real_X;
wire signed [108:0] image_X;
wire signed [108:0] real_Y;
wire signed [108:0] image_Y;

assign real_X = X[217:109];
assign image_X = X[108:0];
assign real_Y = Y[217:109];
assign image_Y = Y[108:0];


wire signed [139:0] A;
wire signed [139:0] B;
assign A =$signed({real_X[108],(real_X[108] == 1 ? 2**16 - 1 : 15'b0),real_X[107:0],$signed(16'd0) })  +  $signed({real_Y[108],(real_Y[108] == 1 ? 2**16 - 1 : 15'b0),real_Y[107:0],$signed(16'd0) });
assign B =$signed({image_X[108],(image_X[108] == 1 ? 2**16 - 1 : 15'b0),image_X[107:0],$signed(16'd0) })  +  $signed({image_Y[108],(image_Y[108] == 1 ? 2**16 - 1 : 15'b0),image_Y[107:0],$signed(16'd0) });


assign ADDER = {A[139],A[78:64],B[139],B[78:64]};
endmodule

module COUNT(
    input signed [31:0] X,
    input signed [31:0] Y,
    input signed [31:0] weight_real,
    input signed [31:0] weight_image,
    output signed [93:0] COUNT
);

wire signed [15:0] real_X;
wire signed [15:0] image_X;
wire signed [15:0] real_Y;
wire signed [15:0] image_Y;
wire [31:0] sum;
wire signed [46:0] A;
wire signed [46:0] B;

assign real_X = X[31:16];
assign image_X = X[15:0];
assign real_Y = Y[31:16];
assign image_Y = Y[15:0];

assign sum = {(real_X - real_Y),(image_X - image_Y)};

assign A = $signed(sum[31:16])* weight_real - $signed(sum[15:0])*weight_image;
assign B = $signed(sum[31:16])*weight_image + $signed(sum[15:0])*weight_real;
assign COUNT = {A,B};

endmodule

module COUNT_1(
    input signed [93:0] X,
    input signed [93:0] Y,
    input signed [31:0] weight_real,
    input signed [31:0] weight_image,
    output signed [155:0] COUNT
);

wire signed [46:0] real_X;
wire signed [46:0] image_X;
wire signed [46:0] real_Y;
wire signed [46:0] image_Y;
wire [93:0] sum;
wire signed [77:0] A;
wire signed [77:0] B;

assign real_X = X[93:47];
assign image_X = X[46:0];
assign real_Y = Y[93:47];
assign image_Y = Y[46:0];

assign sum = {(real_X - real_Y),(image_X - image_Y)};

assign A = $signed(sum[93:47])* weight_real - $signed(sum[46:0])*weight_image;
assign B = $signed(sum[93:47])*weight_image + $signed(sum[46:0])*weight_real;
assign COUNT = {A,B};

endmodule

module COUNT_2(
    input signed [155:0] X,
    input signed [155:0] Y,
    input signed [31:0] weight_real,
    input signed [31:0] weight_image,
    output signed [217:0] COUNT
);

wire signed [77:0] real_X;
wire signed [77:0] image_X;
wire signed [77:0] real_Y;
wire signed [77:0] image_Y;
wire [155:0] sum;
wire signed [108:0] A;
wire signed [108:0] B;

assign real_X = X[155:78];
assign image_X = X[77:0];
assign real_Y = Y[155:78];
assign image_Y = Y[77:0];

assign sum = {(real_X - real_Y),(image_X - image_Y)};

assign A = $signed(sum[155:78])* weight_real - $signed(sum[77:0])*weight_image;
assign B = $signed(sum[155:78])*weight_image + $signed(sum[77:0])*weight_real;
assign COUNT = {A,B};

endmodule

module COUNT_3(
    input signed [217:0] X,
    input signed [217:0] Y,
    input signed [31:0] weight_real,
    input signed [31:0] weight_image,
    output signed [31:0] COUNT
);

wire signed [108:0] real_X;
wire signed [108:0] image_X;
wire signed [108:0] real_Y;
wire signed [108:0] image_Y;
wire [217:0] sum;
wire signed [139:0] A;
wire signed [139:0] B;

assign real_X = X[217:109];
assign image_X = X[108:0];
assign real_Y = Y[217:109];
assign image_Y = Y[108:0];

assign sum = {(real_X - real_Y),(image_X - image_Y)};

assign A = $signed(sum[217:109])* weight_real - $signed(sum[108:0])*weight_image;
assign B = $signed(sum[217:109])*weight_image + $signed(sum[108:0])*weight_real;
assign COUNT = {A[139],A[78:64],B[139],B[78:64]};

endmodule