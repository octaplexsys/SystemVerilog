module corner_ones #(
    parameter WIDTH = -1
) (
    input  logic [WIDTH - 1:0] data_i,
    output logic [WIDTH - 1:0] left_o,
    output logic [WIDTH - 1:0] right_o
);

    always_comb begin
        left_o  = 0;
        right_o = 0;

        for ( int i = 0; i < WIDTH; ++i )
            if ( data_i[i] ) begin
                left_o    = 0;
                left_o[i] = 1;
            end
        for ( int i = WIDTH - 1; i >= 0; --i )
            if ( data_i[i] ) begin
                right_o    = 0;
                right_o[i] = 1;
            end
    end

endmodule