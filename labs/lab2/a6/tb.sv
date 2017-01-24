module tb ( );

    localparam WIDTH_I = 1;
    localparam WIDTH_O = ( WIDTH_I & ( WIDTH_I - 1 )) ? $clog2( WIDTH_I ) : $clog2( WIDTH_I + 1 );

    logic [WIDTH_I - 1:0] data_i;
    logic [WIDTH_O - 1:0] zeros_o,
                          ones_o;
    logic clk;

    zeros_ones_count #(
        .WIDTH_I( WIDTH_I )
    ) DUT (
        .data_i ( data_i ),
        .zeros_o( zeros_o ),
        .ones_o ( ones_o )
    );

    initial begin
        data_i = '0;
        clk    = 1;
        #500ns $stop;
    end

    always
        #10ns clk = ~clk;

    always @( posedge clk )
        data_i <= $urandom_range(0, 2**WIDTH_I - 1);

endmodule