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
      busy       <= '0;
    end else begin
      data  <= { data[3 : 0], ser_data_i };
      if ( !busy ) begin
        if ( data_val_i ) begin
          busy   <= '1;
          count  <= 3'd5;
        end else begin
          data_o <= '0;
        end
      end else begin
        if ( count == 3'd1 ) begin
          busy       <= '0;
          data_o     <= data;
          command_o  <= ser_data_i;
        end else begin
          count <= count + 3'd7;
        end
      end
    end
  end

endmodule
