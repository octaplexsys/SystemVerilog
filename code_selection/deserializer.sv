module deserializer (
  input  logic           rst_i,
  input  logic           clk_i,
  input  logic           data_val_i,
  input  logic           ser_data_i,
  output logic [ 4 : 0 ] data_o,
  output logic           command_o
);
  
  logic [ 4 : 0 ] data;
  logic [ 2 : 0 ] count;
  logic busy;
  
  always_ff @( posedge rst_i or posedge clk_i ) begin
    if ( rst_i ) begin
      data       <= '0;
      data_o     <= '0;
      count      <= '0;
      busy       <= '0;
    end else begin
      if ( !busy ) begin
        if ( data_val_i ) begin
          busy    <= '1;
          data[0] <= ser_data_i;
          count   <= 5'd5;
        end else begin
          data       <= '0;
          data_o     <= '0;
          count      <= '0;
          busy       <= '0;
        end
      end else begin
        if ( count == 1'd1 ) begin
          busy       <= '0;
          data_o[4]  <= data[4];
          data_o[3]  <= data[3];
          data_o[2]  <= data[2];
          data_o[1]  <= data[1];
          data_o[0]  <= data[0];
          command_o  <= ser_data_i;
        end else begin
          for ( int i = 4; i > 0; --i ) begin
            data[i] <= data[i - 1];
          end
          data[0] <= ser_data_i;
          count <= count - 1'd1;
        end
      end
    end
  end

endmodule
