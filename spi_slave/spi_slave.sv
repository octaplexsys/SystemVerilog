/*
 *    SPI slave module
 * Author: Grigorii Kuzmin
 *    Date: 01.11.2016
 *    kga1389@gmail.com
 */
module spi_slave (
   input  logic rst, // global external reset
   input  logic clk, // global system/bus clock
   
   input  tri   mosi,
   output tri   miso,
   input  logic sck,
   input  logic cs,
   
   input  logic cpol, // polarity control
   input  logic cpha, // phase control
   
   input  logic msb_first, // when is 1, most significant bit is sended at first
                           // else - at least (direction of transmission)
   input  logic two_bytes,
   
   input  logic[15:0] data_tx, // storage register for transmitted data
   output logic[15:0] data_rx, // storage register for received data
   
   output logic busy,       // is 1 if spi_slave is busy, 0 if it's free
   output logic end_of_byte // is 1 at the end of transmission, keep value until new transmission
);
   // synchronizers against metastability	
   logic   cs_d1;
   logic   cs_d2;
   logic   cs_d2_prev;
   
   always_ff @(posedge clk or posedge rst) begin
      if(rst) begin
         cs_d1       <= 1;
         cs_d2       <= 1;
         cs_d2_prev  <= 1;
      end else begin
         cs_d1       <= cs;
         cs_d2       <= cs_d1;
         cs_d2_prev  <= cs_d2;
      end
   end
   
   // looking for the edges
   logic   cs_negedge;
   logic   cs_posedge;
   
   assign  cs_posedge = (~cs_d2_prev) & cs_d2; // from 0 to 1
   assign  cs_negedge = cs_d2_prev & (~cs_d2); // from 1 to 0
   
   // synchronizers against metastability	
   logic   sck_d1;
   logic   sck_d2;
   logic   sck_d2_prev;
   
   always_ff @(posedge clk or posedge rst) begin
      if(rst) begin
         sck_d1      <= 0;
         sck_d2      <= 0;
         sck_d2_prev <= 0;
      end else begin
         sck_d1      <= sck;    // if cpol = 1, sck wire is 1 when idle
         sck_d2      <= sck_d1; // else
         sck_d2_prev <= sck_d2; // if cpol = 0, sck wire is 0 when idle
      end
   end
   
   // looking for the edges
   logic   sck_posedge;
   logic   sck_negedge;
   
   assign  sck_posedge = (~sck_d2_prev) & sck_d2; // from 0 to 1
   assign  sck_negedge = sck_d2_prev & (~sck_d2); // from 1 to 0
   
   logic   read_edge;
   logic   shift_edge;
   
   assign  read_edge  = ~cs_d2 & (cpha ? (cpol ? sck_posedge : sck_negedge):
                                         (cpol ? sck_negedge : sck_posedge));
   assign  shift_edge = ~cs_d2 & (cpha ? (cpol ? sck_negedge : sck_posedge):
                                         (cpol ? sck_posedge : sck_negedge));	
   
   // synchronizers against metastability
   logic   mosi_d1;
   logic   mosi_d2;
   
   always_ff @(posedge clk or posedge rst) begin
      if(rst) begin
         mosi_d1 <= 0;
         mosi_d2 <= 0;
      end else begin
         mosi_d1 <= mosi;
         mosi_d2 <= mosi_d1;
      end
   end
   
   // in & out shift registers
   logic[15:0]  i_buf;
   logic[15:0]  o_buf;
   
   logic[15:0]  tx_bit_counter;
   logic[15:0]  rx_bit_counter;
   
   logic is_tx_counter_full;
   assign is_tx_counter_full = two_bytes ? (tx_bit_counter == 16'h8000) : (tx_bit_counter == 16'h0080);
   
   assign end_of_byte = !(tx_bit_counter || rx_bit_counter || rst);
   
   always_ff @(posedge clk or posedge rst) begin
      if(rst) begin
         data_rx     <= '0;
         
         i_buf <= '0;
         o_buf <= '0;
      end else begin
         if(cs_negedge) begin
            i_buf <= '0;
            o_buf <= data_tx;
         end
               
         if(!rx_bit_counter)
            data_rx <= i_buf;
         
         if(read_edge)
            if(rx_bit_counter)
               i_buf <= msb_first ? {i_buf[14:0], mosi_d2}:
                                    (two_bytes ? {mosi_d2, i_buf[15:1]}
                                               : {i_buf[15:8], mosi_d2, i_buf[7:1]});
         
         if(shift_edge)
            if(~(cpha && is_tx_counter_full))
               o_buf <= msb_first ? {o_buf[14:0], 1'b0}:
                                    {1'b0, o_buf[15:1]};
      end
   end
   
   always_ff @(posedge clk or posedge rst) begin
      if(rst) begin
         tx_bit_counter <= '0;
         rx_bit_counter <= '0;
         busy           <= 0;
      end else begin
         if(cs_negedge) begin
            busy        <= 1;                
            tx_bit_counter <= two_bytes ? 16'h8000 : 16'h0080;
            rx_bit_counter <= two_bytes ? 16'h8000 : 16'h0080;
         end
         
         if(shift_edge)                
            tx_bit_counter <= (tx_bit_counter >> 1);
            
         if(read_edge)                
            rx_bit_counter <= (rx_bit_counter >> 1);
         
         if(cs_posedge)
            busy <= 0;
      end
   end
   
   logic   miso_internal;

   assign  miso_internal = msb_first ? (two_bytes ? o_buf[15] : o_buf[7]) : o_buf[0];
   assign  miso = (cs | rst) ? 'z : miso_internal;
   
endmodule
