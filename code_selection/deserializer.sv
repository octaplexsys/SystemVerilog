module deserializer (
  input  logic           rst_i,
  input  logic           clk_i,
  input  logic           data_val_i,
  input  logic           ser_data_i,
  output logic [ 4 : 0 ] data_o,
  output logic           command_o
);
  
  logic [ 16 : 0 ] data;
  logic [ 4 : 0 ] count;
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
          count   <= 5'd17;
        end else begin
          data       <= '0;
          data_o     <= '0;
          count      <= '0;
          busy       <= '0;
        end
      end else begin
        if ( count == 1'd1 ) begin
          busy       <= '0;
          data_o[4]  <= data[16] && ( data[15] || data[14]   ) || data[15] && data[14]   ;
          data_o[3]  <= data[13] && ( data[12] || data[11]   ) || data[12] && data[11]   ;
          data_o[2]  <= data[10] && ( data[9]  || data[8]    ) || data[9]  && data[8]    ;
          data_o[1]  <= data[7]  && ( data[6]  || data[5]    ) || data[6]  && data[5]    ;
          data_o[0]  <= data[4]  && ( data[3]  || data[2]    ) || data[3]  && data[2]    ;
          command_o  <= data[1]  && ( data[0]  || ser_data_i ) || data[0]  && ser_data_i ;
        end else begin
          for ( int i = 16; i > 0; --i ) begin
            data[i] <= data[i - 1];
          end
          data[0] <= ser_data_i;
          count <= count - 1'd1;
        end
      end
    end
  end

endmodule
