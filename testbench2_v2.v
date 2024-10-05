`timescale 1ns/10ps
`define CYCLE       50      // Modify your clock period here
`define End_CYCLE   100000  // Modify cycle times once your design need more cycle times!

`define fir_fail_limit 48
`define fft_fail_limit 5

module testbench2_v2;

//============================================================================================================
//============================================================================================================
// Declaration

reg   clk;
reg   reset;

// Input Valid & Data
reg en;
reg [15:0] data;

// FIR Valid & Data
wire fir_valid;
wire [15:0] fir_d;

// FFT Valid & Data
wire fft_valid;
wire signed [31:0] fft_d [0:15];
reg  signed [31:0] fft_d_reg [0:15];

// Analysis Valid & Data
wire done;
wire [3:0] freq;
reg  [64:0] square [0:15];
wire [3:0]  tmp_freq [0:14];

// Input Data & Golden Memory
reg [15:0] data_mem [0:1023];
reg [15:0] fir_mem [0:1023];
reg signed [15:0] fftr_mem [0:1023];
reg signed [15:0] ffti_mem [0:1023];

// Verify
wire fir_verify;
reg [15:0] fft_r_verify;
reg [15:0] fft_i_verify;
reg need_check;




integer i;  // input data counter
integer j;  // FIR answer counter
integer k;  // FFT verify loop counter
integer l;  // FFT data register loop counter
integer m;  // FFT answer counter
integer n;  // Analysis square result loop counter 
integer fir_fail_global, fir_fail_local;
integer fft_fail;
integer analysis_fail;


//============================================================================================================
//============================================================================================================
// DUT

FAS DUT(
    .clk(clk), .rst(reset),
    .data_valid(en), .data(data),
    .fir_valid(fir_valid), .fir_d(fir_d),
    .fft_valid(fft_valid), 
	.fft_d0(fft_d[0]), .fft_d1(fft_d[1]), .fft_d2(fft_d[2]), .fft_d3(fft_d[3]), 
    .fft_d4(fft_d[4]), .fft_d5(fft_d[5]), .fft_d6(fft_d[6]), .fft_d7(fft_d[7]), 
    .fft_d8(fft_d[8]), .fft_d9(fft_d[9]), .fft_d10(fft_d[10]), .fft_d11(fft_d[11]), 
    .fft_d12(fft_d[12]), .fft_d13(fft_d[13]), .fft_d14(fft_d[14]), .fft_d15(fft_d[15]),
    .done(done), .freq(freq)
);


//============================================================================================================
//============================================================================================================
// Verify Logic

// Load(Prepare) Input Data & Golden Memory
initial $readmemh("Input_Pattern2.dat", data_mem);
initial $readmemh("Golden2_FIR.dat", fir_mem);
initial $readmemh("Golden2_FFT_real.dat", fftr_mem);
initial $readmemh("Golden2_FFT_imag.dat", ffti_mem);


// initilaize clk & rst & counters & control signals
initial begin
    #0; 
    clk = 1'b0;
    reset = 1'b0; 
    i = 0;
    j = 0;  
    m = 0;
    fir_fail_global = 0;
    fft_fail = 0;
    analysis_fail = 0;

    en = 0;
    #(`CYCLE*0.5)           reset = 1'b1; 
    #(`CYCLE*2);    #0.5;   reset = 1'b0; en = 1;
end

always begin #(`CYCLE/2) clk = ~clk; end


//============================================================================================================
// Given Input Data when (negedge clk & en)
always@(negedge clk) begin
	if (en) begin
		if (i >= 1024)
			data <= 0;
		else begin
			data <= data_mem[i];
			i <= i + 1;
		end
	end
end



//============================================================================================================
// FIR data output verify - with +- 1 error toleration range
assign fir_verify = (fir_d === fir_mem[j])   | 
                    (fir_d === fir_mem[j]+16'd1) | (fir_d === fir_mem[j]-16'd1);

always@(posedge clk) begin
	if (fir_valid & (j<1024)) begin
		if (!fir_verify) begin
			$display("ERROR at FIR dataout #%-4d : The real response output %4h != expectd %4h " ,j, fir_d, fir_mem[j]);
			fir_fail_global <= fir_fail_global + 1;
            fir_fail_local <= (j%16==0) ? 1 : fir_fail_local + 1;
		end
        else begin
            fir_fail_local <= (j%16==0) ? 0 : fir_fail_local;
        end
		j <= j + 1;
	end
end

// Print out phase information every time 16 datas are output
always@(*) begin
    if (j%16==15) begin
        if (fir_fail_local) $display("FIR dataout on pattern   %d ~ %d, FAIL !!", (j-15), j); 
        else begin
            $display("FIR dataout on pattern   %d ~ %d, PASS !!", (j-15), j); 
        end
    end
end

// Forced Termination - When fir_fall_global > 48
always@(*) begin
	if (fir_fail_global >= `fir_fail_limit) begin
		$display("-----------------------------------------------------\n");
 		$display("Terminate !!! Error !!! There are more than %d errors for FIR output !", `fir_fail_limit);
 		$display("-------------------------FAIL------------------------\n");
		$finish;
	end
end



//============================================================================================================
// FFT data output verify - with +- 3 error toleration range

// Verify for +- 3 tolerate
always @ (*) begin
    for (k=0; k<=15; k=k+1) begin
        fft_r_verify[k] <=  (fft_d[k][31:16] === fftr_mem[m+k])       |
                            (fft_d[k][31:16] === fftr_mem[m+k]+16'd1) | (fft_d[k][31:16] === fftr_mem[m+k]-16'd1) |
                            (fft_d[k][31:16] === fftr_mem[m+k]+16'd2) | (fft_d[k][31:16] === fftr_mem[m+k]-16'd2) |
                            (fft_d[k][31:16] === fftr_mem[m+k]+16'd3) | (fft_d[k][31:16] === fftr_mem[m+k]-16'd3) ;
        fft_i_verify[k] <=  (fft_d[k][15:0]  === ffti_mem[m+k])       |
                            (fft_d[k][15:0]  === ffti_mem[m+k]+16'd1) | (fft_d[k][15:0]  === ffti_mem[m+k]-16'd1) |
                            (fft_d[k][15:0]  === ffti_mem[m+k]+16'd2) | (fft_d[k][15:0]  === ffti_mem[m+k]-16'd2) |
                            (fft_d[k][15:0]  === ffti_mem[m+k]+16'd3) | (fft_d[k][15:0]  === ffti_mem[m+k]-16'd3) ;
    end
end

// Store fft output into fft_d_reg for Analysis later
// Print information
always @ (posedge clk) begin
    if (fft_valid & (m<1024)) begin
        for (l=0; l<=15; l=l+1) begin
            fft_d_reg[l] <= fft_d[l];
        end

        for (l=0; l<=15; l=l+1) begin
            if (!fft_r_verify[l] | !fft_i_verify[l]) begin
                $display("ERROR at FFT dataout #%-4d : The real response output %8h != expectd %8h " ,m+l, fft_d[l], {fftr_mem[m+l], ffti_mem[m+l]});
            end
        end

        if ((!(&fft_r_verify)) | (!(&fft_i_verify))) begin
            $display("FFT dataout on pattern   %d ~ %d, FAIL !!", m, m+15);
            fft_fail <= fft_fail + 1; 
        end
        else begin
            $display("FFT dataout on pattern   %d ~ %d, PASS !!", m, m+15);
        end

        m <= m + 16;
    end
end

//  need_check
always@(posedge clk) begin
    if (done) begin
        if (need_check & fft_valid) begin
            need_check <= 1'b1;
        end
        else if (need_check & ~fft_valid) begin
            need_check <= 1'b0;
        end
        else if (~need_check & fft_valid) begin
            need_check <= 1'b0;
        end
        else begin
            $display("ERROR ! Your Analysis outputs a freq when FFT haven't outputed to Analysis !");
			$display("-----------------------------------------------------");
			$finish;
        end
    end
    else begin
        if (need_check & fft_valid) begin
            $display("ERROR ! Your Analysis misses a freq after FFT have outputed to Analysis !");
			$display("-----------------------------------------------------");
			$finish;
        end
        else if (need_check & ~fft_valid) begin
            need_check <= 1'b1;
        end
        else if (~need_check & fft_valid) begin
            need_check <= 1'b1;
        end
        else begin
            need_check <= 1'b0;
        end
    end
    
end



// Forced Termination - When fft_fail round (16 data is a round) > 5
always@(*) begin
	if (fft_fail >= `fft_fail_limit) begin
		$display("-----------------------------------------------------\n");
 		$display("Error!!! There are more than %d rounds errors for FFT output !", `fft_fail_limit);
 		$display("-------------------------FAIL------------------------\n");
		$finish;
	end	
end



//============================================================================================================
// Final result verify

// Calculate the square result
always @ (*) begin
    for (n=0; n<=15; n=n+1) begin
        square[n] <= ($signed(fft_d_reg[n][31:16])*$signed(fft_d_reg[n][31:16])) + ($signed(fft_d_reg[n][15:0])*$signed(fft_d_reg[n][15:0]));
    end
end

assign tmp_freq[0] = square[0]  >= square[1]  ? 4'd0  : 4'd1;
assign tmp_freq[1] = square[2]  >= square[3]  ? 4'd2  : 4'd3;
assign tmp_freq[2] = square[4]  >= square[5]  ? 4'd4  : 4'd5;
assign tmp_freq[3] = square[6]  >= square[7]  ? 4'd6  : 4'd7;
assign tmp_freq[4] = square[8]  >= square[9]  ? 4'd8  : 4'd9;
assign tmp_freq[5] = square[10] >= square[11] ? 4'd10 : 4'd11;
assign tmp_freq[6] = square[12] >= square[13] ? 4'd12 : 4'd13;
assign tmp_freq[7] = square[14] >= square[15] ? 4'd14 : 4'd15;

assign tmp_freq[8]  = square[tmp_freq[0]] >= square[tmp_freq[1]] ? tmp_freq[0] : tmp_freq[1];
assign tmp_freq[9]  = square[tmp_freq[2]] >= square[tmp_freq[3]] ? tmp_freq[2] : tmp_freq[3];
assign tmp_freq[10] = square[tmp_freq[4]] >= square[tmp_freq[5]] ? tmp_freq[4] : tmp_freq[5];
assign tmp_freq[11] = square[tmp_freq[6]] >= square[tmp_freq[7]] ? tmp_freq[6] : tmp_freq[7];

assign tmp_freq[12] = square[tmp_freq[8]]  >= square[tmp_freq[9]]  ? tmp_freq[8]  : tmp_freq[9];
assign tmp_freq[13] = square[tmp_freq[10]] >= square[tmp_freq[11]] ? tmp_freq[10] : tmp_freq[11];

assign tmp_freq[14] = square[tmp_freq[12]] >= square[tmp_freq[13]] ? tmp_freq[12] : tmp_freq[13];



always@(posedge clk) begin
	if (done) begin
		if (freq !== tmp_freq[14]) begin
			$display("ERROR at 'ANALYSIS Stage', the freq signal output %2d !=expect %2d" , freq, tmp_freq[14]);
			$display("-----------------------------------------------------");
            analysis_fail <= analysis_fail + 1;
			$finish;
		end
        else begin
            $display("Analysis freq on pattern %d ~ %d, PASS !!", m-16, m-1);
            $display("-----------------------------------------------------");
        end
	end
end



// Terminate the simulation, infinitie simulation -> FAIL
initial  begin
    #(`CYCLE * `End_CYCLE);
    $display("-----------------------------------------------------");
    $display("Error!!! Somethings' wrong with your code ...!!");
    $display("-------------------------FAIL------------------------");
    $display("-----------------------------------------------------");
    $finish;
end



// Terminate the simulation, PASS
initial begin
    wait(en);
    wait(fir_valid);
    wait(fft_valid);
    wait(done);
    wait(m>=1023);
    #(`CYCLE*10);     
    if ( !(fft_fail) && !(fir_fail_global)) begin
        $display("-----------------------------------------------------\n");
        $display("Congratulations ! Testbench 2 ver2  Pass !! All data have been generated successfully !!!\n");
        $display("-------------------------PASS------------------------\n");
    #(`CYCLE/2); $finish;
    end
    else begin
        $display("-----------------------------------------------------\n");
        $display("Testbench 2 ver2 Fail !!! There are some error with your code !!!\n");
        $display("-------------------------FAIL------------------------\n");
    #(`CYCLE/2); $finish;
    end
end








endmodule
