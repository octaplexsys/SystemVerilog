module serializer (
  input  logic           rst_i,
  input  logic           clk_i,
  input  logic [ 5 : 0 ] data_i,
  input  logic           data_val_i,
  output logic           ser_data_o,
  output logic           busy_o
);
  
  logic [ 5 : 0 ] data;
  logic [ 2 : 0 ] count;
  
  assign ser_data_o = data[5];
  
  always_ff @( posedge rst_i or posedge clk_i ) begin
    if ( rst_i ) begin
      data   <= '0;
      busy_o <= '0;
      count  <= '0;
    end else begin
      if ( !busy_o ) begin
        if ( data_val_i ) begin
          data   <= data_i;
          busy_o <= '1;
          count  <= 3'd6;
        end
      end else begin
        if ( count == 1'd1) begin
          busy_o <= '0;
          data   <= '0;
        end else begin
          for ( int i = 5; i > 0; --i ) begin
            data[i] <= data[i - 1];
            data[0] <= 1'd0;
          end
          count <= count - 1'b1;
        end
      end
    end
  end

endmodule
