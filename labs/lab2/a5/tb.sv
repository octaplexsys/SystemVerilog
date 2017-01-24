module tb ( );

    parameter WIDTH = 5;

    logic [WIDTH - 1:0] data_i,
                        left_o,
                        right_o;
    logic clk;

    corner_ones #(
        .WIDTH( WIDTH )
    ) DUT (
        .data_i ( data_i ),
        .left_o ( left_o ),
        .right_o( right_o )
    );

    initial begin
        data_i = '0;
        clk    = 1;
        #500ns $stop;
    end

    always
        #10ns clk = ~clk;

    always @( posedge clk )
        data_i <= $urandom_range(0, 2**WIDTH - 1);

endmodule