`include "types_pkg.sv"

module tb ( );

    logic clk_i,
          rst_i,
          red_o,
          yellow_o,
          green_o;

    traffic_light #(
        .RED_TIME        ( 10 ),
        .RED_YELLOW_TIME (  3 ),
        .GREEN_TIME      ( 10 ),
        .GREEN_FLASH_TIME(  3 ),
        .YELLOW_TIME     (  5 )
    ) DUT (
        .clk_i   ( clk_i ),
        .rst_i   ( rst_i ),
        .red_o   ( red_o ),
        .yellow_o( yellow_o ),
        .green_o ( green_o )
    );

    initial begin
        rst_i = 1;
        clk_i = 1;

        #50ns;
        rst_i = 0;
    end

    initial
        #2us $stop;

    always
        #10ns clk_i = ~clk_i;

endmodule