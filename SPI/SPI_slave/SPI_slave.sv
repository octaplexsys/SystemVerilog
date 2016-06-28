/**********************************************************
***********************************************************
**                                                       **
**                      SPI slave                        **
**               Author: Grigorii Kuzmin                 **
**                  kga1389@gmail.com                    **
**                  Date: 25.06.2016                     **
**                                                       **
** This SPI module works in slave mode. It haves two 8   **
** bit wide registers to store received and reading      **
** transmitted data. tx_ena signal must be logical 1 to  **
** enable transfer.                                      **
**                                                       **
***********************************************************
***********************************************************/

module SPI_slave (
  input  logic           rst_i,
  input  logic           clk_i,
  input  logic           ena_i,
  
  input  logic           tx_ena,
  input  logic [ 7 : 0 ] tx_data,
  
  input  logic           MSB,  // if 1, then most significant bit first
  input  logic           CPOL, // master clock polarity
  input  logic           CPHA, // data read/shift phase
  
  input  logic           CS,
  input  logic           SCK,
  input  logic           MOSI,
  output tri             MISO,
  
  output logic           done, // 1-clock cycle long flag when tranceiving is done 
  output logic [ 7 : 0 ] rx_data
);

  logic [ 7 : 0 ] tx_reg;
  logic [ 7 : 0 ] rx_reg;
  logic [ 3 : 0 ] bit_counter;
  logic           sout;
  logic           CS_sync;
  logic           SCK_sync;
  logic           out;
  
  assign out  = MSB                        ? tx_reg[7] : tx_reg[0];
  assign MISO = ( CS && tx_ena && !rst_i ) ? out       : 'z;
  
  always_ff @( posedge rst_i or posedge clk_i ) // rx logic
  begin
  
    if ( rst_i )
    begin
      rx_reg      <= '0;
      rx_data     <= '0;
      done        <= '0;
      bit_counter <= '0;
    end else
    begin
    
      if ( ena_i )
      begin
        CS_sync  <= CS;  // CS edges looking
        SCK_sync <= SCK; // SCK edges looking
        
        if ( !CPHA )
        begin
        
          if ( CS && ( SCK && !SCK_sync && !CPOL || !SCK && SCK_sync && CPOL ) ) // if posedge SCK or negedge SCK ( depend on CPOL )
          begin 
          
            if ( MSB )
            begin
              rx_reg <= { rx_reg[6 : 0], MOSI };
            end else
            begin
              rx_reg <= { MOSI, rx_reg[7 : 1] };
            end
            
            bit_counter <= bit_counter + 1'd1;
          
          end
          
          if ( bit_counter != 4'd7 || !CPOL && ( !SCK || SCK_sync ) || CPOL && ( SCK || !SCK_sync ) ) // if receiving isn't ended and it's no SCK edges
          begin
            done <= '0;
          end else 
          begin // received data clamping
          
            if ( MSB )
            begin
              rx_data <= { rx_reg[6 : 0], MOSI };
            end else
            begin
              rx_data <= { MOSI, rx_reg[7 : 1] };
            end
            
            done        <= 1'd1;
            bit_counter <= '0;
          end
        
        end else
        begin
        
          if ( CS && ( SCK && !SCK_sync && CPOL || !SCK && SCK_sync && !CPOL ) )
          begin 
          
            if ( MSB )
            begin
              rx_reg <= { rx_reg[6 : 0], MOSI };
            end else
            begin
              rx_reg <= { MOSI, rx_reg[7 : 1] };
            end
            
            bit_counter <= bit_counter + 1'd1;
          
          end
          
          if ( bit_counter != 4'd7 || CPOL && ( !SCK || SCK_sync ) || !CPOL && ( SCK || !SCK_sync ) )
          begin
            done <= '0;
          end else
          begin
          
            if ( MSB )
            begin
              rx_data <= { rx_reg[6 : 0], MOSI };
            end else
            begin
              rx_data <= { MOSI, rx_reg[7 : 1] };
            end
            
            done        <= 1'd1;
            bit_counter <= '0;
          end
        
        end
      
      end
    
    end
  
  end

  always_ff @( posedge rst_i or posedge clk_i ) // tx logic
  begin
  
    if ( rst_i )
    begin
      tx_reg <= '0;
    end else
    begin
    
      if ( ena_i )
      begin
      
        if( CS )
        begin
        
          if ( !CPHA )
          begin
          
            if( !CS_sync || !bit_counter ) // if posedge CS and it's first transmitted bit
            begin
              tx_reg <= tx_data;
            end else
            begin // if it's not first transmitted bit
            
              if ( !SCK && SCK_sync && !CPOL || SCK && !SCK_sync && CPOL ) // if posedge SCK or negedge SCK ( depend on CPOL )
              begin
              
                if( !MSB )
                begin
                  tx_reg <= { 1'b1, tx_reg[7 : 1] };
                end else
                begin
                  tx_reg <= { tx_reg[6 : 0], 1'b1 };
                end
              
              end
            
            end
          
          end else
          begin
          
            if ( !SCK && SCK_sync && !CPOL || SCK && !SCK_sync && CPOL ) // if posedge SCK or negedge SCK ( depend on CPOL )
            begin
            
              if ( !bit_counter ) // if it's first transmitted bit
              begin
                tx_reg <= tx_data;
              end else
              begin // if it's not first transmitted bit
              
                if( !MSB )
                begin
                  tx_reg <= { 1'b1, tx_reg[7 : 1] };
                end else
                begin
                  tx_reg <= { tx_reg[6 : 0], 1'b1 };
                end
              
              end
            
            end
          
          end
        
        end
      
      end
    
    end
  
  end

endmodule
