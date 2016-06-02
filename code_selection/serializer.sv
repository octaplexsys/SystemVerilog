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
  
  always_ff @( posedge clk_i or negedge rst_i ) begin
    if ( !rst_i ) begin
      data   <= '0;
      busy_o <= '0;
    end else begin
      if ( !busy_o ) begin
        data   <= data_i;
        busy_o <= data_val_i;
        count  <= 3'd5;
      end else begin
        if ( count == 3'd0) begin
          busy_o <= '0;
        end else begin
          data <= { data[ 4 : 0 ], 1'd0 };
          count <= count + 3'd7;
        end
      end
    end
  end

endmodule
