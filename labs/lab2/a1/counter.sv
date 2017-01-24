module counter #(
    parameter WIDTH    = 8,
    parameter OVERFLOW = 2**WIDTH - 1
) (
    input  logic               rst_i,
    input  logic               clk_i,
    input  logic               en_i,
    input  logic               preset_i,
    input  logic [WIDTH - 1:0] preset_value,
    output logic [WIDTH - 1:0] value
);

    always_ff @( posedge clk_i or posedge rst_i )
        if ( rst_i )
            value <= '0;
        else
            if ( preset_i )
                value <= preset_value;
            else
                if ( en_i )
                    if ( value < OVERFLOW - 1 )
                        value <= value + 1'b1;
                    else
                        value <= '0;
endmodule
