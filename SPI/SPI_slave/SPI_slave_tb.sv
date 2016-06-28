module SPI_slave_tb;

  logic                              rst_i;
  logic                              clk_i;
  logic                              ena_i;
  
  logic                              tx_ena;
  logic [ 7 : 0 ]                    tx_data;
  
  logic                              MSB;
  logic                              CPOL;
  logic                              CPHA;
  
  logic                              CS;
  logic                              SCK;
  logic                              MOSI;
  logic                              MISO;
  
  logic                              done;
  logic [ 7 : 0 ]                    rx_data;
  
  initial
  begin
    rst_i   = '0;
    clk_i   = '0;
    ena_i   = '0;
    tx_ena  = '0;
    tx_data = '0;
    MSB     = '0;
    CS      = '0;
    SCK     = '0;
    MOSI    = '0;
    CPOL    = '0;
    CPHA    = '0;
    
    #15ns;
    rst_i   = '1;
    #30ns;
    rst_i   = '0;
    
    #30ns;
    ena_i   = '1;
    MOSI    = '1;
    MSB     = '1;
    CS      = '1;
    
    #2ms;
    $stop;
  end
  
  always
  begin
  #10ns;
    clk_i = !clk_i;
  end
  
  always @( posedge clk_i )
  begin
  
    if ( !CS )
    begin
    
      if ( !CPOL )
      begin
        SCK <= '0;
      end else
      begin
        SCK <= '1;
      end
    
    end else
    begin
      #30ns;
      @ ( posedge clk_i )
      SCK  <= !SCK;
      
      if ( SCK && ( !CPOL && !CPHA || CPOL && CPHA ) || !SCK && ( !CPOL && CPHA || !CPOL && CPHA ) )
      begin
        MOSI <= $urandom % 2;
      end
    
    end
  
  end
  
  always @( posedge clk_i )
  begin
  
    if ( done )
    begin
      CS      <= '0;
      CPOL    <= $urandom % 2;
      CPHA    <= $urandom % 2;
      tx_ena  <= $urandom % 2;
      tx_data <= $urandom % 256;
      #60ns;
      CS <= '1;
      #60ns;
    end
  
  end
  
  SPI_slave DUT( .* );

endmodule
