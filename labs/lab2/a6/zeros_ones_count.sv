module zeros_ones_count #(
    parameter WIDTH_I = -1,
    parameter WIDTH_O = ( WIDTH_I & ( WIDTH_I - 1 )) ? $clog2( WIDTH_I ) : $clog2( WIDTH_I + 1 );
) (
    input  logic [WIDTH_I - 1:0] data_i,
    output logic [WIDTH_O - 1:0] zeros_o,
    output logic [WIDTH_O - 1:0] ones_o
);
    
    assign zeros_o = WIDTH_I - ones_o;
    always_comb begin
        ones_o  = 0;

        for ( int i = 0; i < WIDTH_I; ++i )
            if ( data_i[i] )
                ones_o = ones_o + 1'd1;
    end

endmodule