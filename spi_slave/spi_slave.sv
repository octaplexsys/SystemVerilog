/*
 *    SPI slave module
 * Author: Grigorii Kuzmin
 *    Date: 01.11.2016
 *    kga1389@gmail.com
 */
module spi_slave
(
    input   logic   rst, // global external reset
    input   logic   clk, // global system/bus clock

    input   logic   mosi,
    output  tri     miso,
    input   logic   sck,
    input   logic   cs,

    input   logic   cpol, // polarity control
    input   logic   cpha, // phase control

    input   logic   msb_first, // when is 1, most significant bit is sended at first
                               // else - at least (direction of transmission)

    input   logic[7:0]  data_out, // storage register for transmitted data
    output  logic[7:0]  data_in,  // storage register for received data

    output  logic   busy,       // is 1 if spi_slave is busy, 0 if it's free
    output  logic   end_of_byte // is 1 at the end of transmission, keep value until new transmission
);
    // synchronizers against metastability	
    logic   sck_sync_1;
    logic   sck_sync_2;
    logic   sck_sync_2_prev;

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            sck_sync_1      <= 0; // if cpol = 1, sck wire is 1 when idle
            sck_sync_2      <= 0; // else
            sck_sync_2_prev <= 0; // if cpol = 0, sck wire is 0 when idle
        end else
        begin
            sck_sync_1      <= sck;
            sck_sync_2      <= sck_sync_1;
            sck_sync_2_prev <= sck_sync_2;
        end
    end

    // looking for the edges
    logic   sck_posedge;
    logic   sck_negedge;

    assign  sck_posedge = (~sck_sync_2_prev) & sck_sync_2; // from 0 to 1
    assign  sck_negedge = sck_sync_2_prev & (~sck_sync_2); // from 1 to 0

    logic   read_edge;
    logic   shift_edge;

    assign  read_edge   = cpha ? (cpol ? sck_posedge : sck_negedge):
                                 (cpol ? sck_negedge : sck_posedge);
    assign  shift_edge  = cpha ? (cpol ? sck_negedge : sck_posedge):
                                 (cpol ? sck_posedge : sck_negedge);	

    // synchronizers against metastability	
    logic   cs_sync_1;
    logic   cs_sync_2;
    logic   cs_sync_2_prev;

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            cs_sync_1       <= 1;
            cs_sync_2       <= 1;
            cs_sync_2_prev  <= 1;
        end else
        begin
            cs_sync_1       <= cs;
            cs_sync_2       <= cs_sync_1;
            cs_sync_2_prev  <= cs_sync_2;
        end
    end

    // looking for the edges
    logic   cs_negedge;
    logic   cs_posedge;

    assign  cs_posedge = (~cs_sync_2_prev) & cs_sync_2; // from 0 to 1
    assign  cs_negedge = cs_sync_2_prev & (~cs_sync_2); // from 1 to 0

    // synchronizers against metastability
    logic   mosi_sync_1;
    logic   mosi_sync_2;

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            mosi_sync_1 <= 0;
            mosi_sync_2 <= 0;
        end else
        begin
            mosi_sync_1 <= mosi;
            mosi_sync_2 <= mosi_sync_1;
        end
    end

    // main shift registers
    logic[7:0]  input_shift_reg;
    logic[7:0]  output_shift_reg;

    logic[7:0]  bit_counter;

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
            data_in          <= '0;
            input_shift_reg  <= '0;
            output_shift_reg <= '0;
            bit_counter      <= '0;

            busy        <= 0;
            end_of_byte <= 0;
        end else
        begin
            if(cs_negedge)
            begin
                end_of_byte <= 0;
                busy        <= 1;
                
                bit_counter <= 8'b1000_0000;
                
                if (~cpha)
                    output_shift_reg <= data_out;
            end

            if (read_edge)
            begin
                if (bit_counter != 1)
                    input_shift_reg <= msb_first ? {input_shift_reg[6:0], mosi_sync_2}:
                                                   {mosi_sync_2, input_shift_reg[7:1]};
                else
                begin
                    data_in <= msb_first ? {input_shift_reg[6:0], mosi_sync_2}:
                                           {mosi_sync_2, input_shift_reg[7:1]};
                    end_of_byte <= 1;
                end
            end

            if (shift_edge)
            begin
                if (~(cpha && (bit_counter == 8'b1000_0000)))
                    output_shift_reg <= msb_first ? {output_shift_reg[6:0], 1'b0}:
                                                    {1'b0, output_shift_reg[7:1]};
                bit_counter <= (bit_counter >> 1);
            end

            if (cs_posedge)
                busy <= 0;
        end
    end

    logic   miso_internal;

    assign  miso_internal = msb_first ? output_shift_reg[7] : output_shift_reg[0];
    assign  miso = (cs | rst) ? 'z : miso_internal;

endmodule
