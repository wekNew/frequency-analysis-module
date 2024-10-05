module FIR(
    input clk,
    input rst,
    input data_valid,
    input signed [15:0] data,
    output fir_valid,
    output signed [15:0] fir_d
);
`include "FIR_coefficient.dat"
reg [5:0] counter;          
wire valid;         
assign valid = (counter >= 6'd31); 
always@ (posedge clk) begin
    if(rst) counter <= 6'b0;
    else begin
        if(data_valid && (!valid)) counter <= counter + 6'b1;
        else                          counter <= counter;        
    end
end
integer i;              
reg signed [15:0] DFF [0:30];   
always@ (posedge clk) begin                  
    if(rst)begin                             
        for(i=0; i<=30; i=i+1)begin  
            DFF[i] <= 16'd0;          
        end
    end
    else begin
        if(data_valid) begin                 
            DFF[0] <= data;                  
            for(i=0; i<30; i=i+1) begin
                DFF[i+1] <= DFF[i];
            end
        end
        else begin                           
            for(i=0; i<=30; i=i+1)begin  
                DFF[i] <= DFF[i];          
            end
        end
    end 
end

reg signed [34:0] add[0:31];
always@(*) begin
    add[0]  = $signed(16'd0) + data * FIR_C00;
    add[1]  = add[0]  + DFF[0] * FIR_C01;
    add[2]  = add[1]  + DFF[1] * FIR_C02;
    add[3]  = add[2]  + DFF[2] * FIR_C03;
    add[4]  = add[3]  + DFF[3] * FIR_C04;
    add[5]  = add[4]  + DFF[4] * FIR_C05;
    add[6]  = add[5]  + DFF[5] * FIR_C06;
    add[7]  = add[6]  + DFF[6] * FIR_C07;
    add[8]  = add[7]  + DFF[7] * FIR_C08;
    add[9]  = add[8]  + DFF[8] * FIR_C09;
    add[10] = add[9]  + DFF[9] * FIR_C10;
    add[11] = add[10] + DFF[10] * FIR_C11;
    add[12] = add[11] + DFF[11] * FIR_C12;
    add[13] = add[12] + DFF[12] * FIR_C13;
    add[14] = add[13] + DFF[13] * FIR_C14;
    add[15] = add[14] + DFF[14] * FIR_C15;
    add[16] = add[15] + DFF[15] * FIR_C16;
    add[17] = add[16] + DFF[16] * FIR_C17;
    add[18] = add[17] + DFF[17] * FIR_C18;
    add[19] = add[18] + DFF[18] * FIR_C19;
    add[20] = add[19] + DFF[19] * FIR_C20;
    add[21] = add[20] + DFF[20] * FIR_C21;
    add[22] = add[21] + DFF[21] * FIR_C22;
    add[23] = add[22] + DFF[22] * FIR_C23;
    add[24] = add[23] + DFF[23] * FIR_C24;
    add[25] = add[24] + DFF[24] * FIR_C25;
    add[26] = add[25] + DFF[25] * FIR_C26;
    add[27] = add[26] + DFF[26] * FIR_C27;
    add[28] = add[27] + DFF[27] * FIR_C28;
    add[29] = add[28] + DFF[28] * FIR_C29;
    add[30] = add[29] + DFF[29] * FIR_C30;
    add[31] = add[30] + DFF[30] * FIR_C31;
end

assign fir_valid = valid;
assign fir_d     = {add[31][34],add[31][30:16]} + (add[31][34] == 1? 1:0);

endmodule