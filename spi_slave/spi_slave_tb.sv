module spi_slave_tb;

   logic rst;
   logic clk;
   
   tri   sdio;
   logic sck;
   logic cs;
   
   logic cpol;
   logic cpha;
   
   logic msb_first;
   logic two_bytes;
   
   logic[15:0] data_tx;
   logic[15:0] data_rx;
   
   logic busy;
   logic end_of_byte;
   
   mailbox transmitted = new;
   logic[15:0] temp;
   event check;
   
   spi_slave DUV(
      .rst(rst),
      .clk(clk),
      
      .miso(sdio),
      .mosi(sdio),
      .sck(sck),
      .cs(cs),
      
      .cpol(cpol),
      .cpha(cpha),
      
      .msb_first(msb_first),
      .two_bytes(two_bytes),
      
      .data_tx(data_tx),
      .data_rx(data_rx),

      .busy(busy),
      .end_of_byte(end_of_byte)
   );
   
   logic pos;
   logic neg;
   
   assign pos = sck & (cpol & ~cpha | ~cpol & cpha);
   assign neg = sck & (cpol & cpha | ~cpol & ~cpha);
   
   initial begin
      rst = 1;
      clk = 0;
      
      sck  = 0;
      cs   = 1;
      
      cpol = 0;
      cpha = 0;
      
      msb_first = 0;
      two_bytes = 0;
      
      data_tx = 0;
      
      #40ns
      rst = ~rst;
      
      repeat (100) begin
         #63ns;
         transmit;
      end
      
      #77ns
      $stop;
   end
   
   always begin
      @(check)
      
      transmitted.try_get(temp);   
      if(data_rx === temp)
         $display("SUCCESSFUL TRANSMITTING");
      else
         $display("FAILED TRANSMITTING");
   end
      
   always
      #10ns clk = ~clk;
      
   task transmit;
      cpol      = $urandom() % 2;
      cpha      = $urandom() % 2;
      msb_first = $urandom() % 2;
      two_bytes = $urandom() % 2;
      sck       = cpol;
      
      data_tx = two_bytes ? $urandom() % 2**16 : $urandom() % 2**8;
      
      transmitted.put(data_tx);
      
      #20ns;
      cs  = ~cs;
      
      if(two_bytes) begin
         #10ns;
         repeat (32) begin
            #77ns
            sck = ~sck;
         end
      end else begin
         #10ns;
         repeat (16) begin
            #77ns
            sck = ~sck;
         end
      end
      
      #77ns
      cs = ~cs;
      
      @(posedge clk)
      -> check;
   endtask
   
endmodule
