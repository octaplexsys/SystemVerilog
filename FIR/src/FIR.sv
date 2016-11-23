module FIR #(
   parameter WIDTH = -1,
   parameter DELAY = -1
   ) (
   input logic rst,
   input logic clk,


   input  logic [WIDTH - 1:0] coeff [0:DELAY - 1],
   input  logic [WIDTH - 1:0] adc_samples,
   output logic [WIDTH - 1:0] out
   );
   
   logic [WIDTH - 1:0]     delay [0:DELAY - 1];
   logic [WIDTH * 2 - 1:0] part_sums [DELAY - 1:0];
   logic [WIDTH * 2 - 1:0] mid_result;
   
   always_comb begin
      mid_result = '0;
      for(int i = 0; i < DELAY; ++i) begin
         part_sums[i] = coeff[i] * delay[i];
         mid_result = mid_result + part_sums[i];
      end
   end

   assign out = mid_result[WIDTH * 2 - 1:WIDTH];

   always_ff @(posedge clk or posedge rst)
      if(rst) begin
         for(int i = 0; i < DELAY; ++i)
            delay[i]     <= '0;
      end else begin
         delay[0] <= adc_samples;
         
         for(int i = 1; i < DELAY; ++i)
            delay[i] <= delay[i-1];
      end

endmodule // FIR
