module debounce #(
    parameter DELAY_CYCLES = 10
) (
    input  logic clk_i,
    input  logic key_i,
    output logic key_pressed_stb_o
);
    
    localparam WIDTH = ( DELAY_CYCLES & ( DELAY_CYCLES - 1 )) ? $clog2( DELAY_CYCLES ) : $clog2( DELAY_CYCLES + 1 );

    logic [WIDTH - 1:0] delay;

    always_ff @( posedge clk_i )
        if ( key_i ) begin
            delay             <= DELAY_CYCLES;
            key_pressed_stb_o <= 0;
        end else
            if ( delay > 0 ) begin
                delay <= delay - 1'd1;
                if ( delay == 1'd1 )
                    key_pressed_stb_o <= 1;
            end else
                key_pressed_stb_o <= 0;


endmodule // debounce