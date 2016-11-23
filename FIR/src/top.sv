module top #(
   parameter WIDTH = 12,
   parameter DELAY = 100
   ) (
   input logic rst,
   input logic clk,


   input  logic [WIDTH - 1:0] coeff [0:DELAY - 1] ,
   
   input  logic [WIDTH - 1:0] adc_samples,
   output logic [WIDTH - 1:0] out
   );

   FIR #(WIDTH, DELAY) fir(.*);

endmodule // top
