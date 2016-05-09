module tb( );
  logic            rst_i;
  logic            clk_i;
  logic [ 5 : 0 ]  data_i;
  logic            data_val_i;
  logic [ 17 : 0 ] status_o;
  
  top DUT ( .* );
  
  initial begin
    rst_i      = 1;
    clk_i    = 1;
    data_i     = '0;
    data_val_i = 1;
    #45ns;
    rst_i = 0;
  end
  
  initial begin
    #5us;
    $stop;
  end
  
  always begin
    #10ns; clk_i = ~clk_i;
  end
  
  always @( posedge clk_i )begin
    data_i     = $urandom % 18 + 1'd1;
    data_val_i = $urandom % 2;
  end

endmodule
