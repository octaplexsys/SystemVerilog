module countdown_timer #(
    parameter COUNT = -1
) (
    input  logic clk_i,
    input  logic rst_i,
    input  logic enable_i,

    output logic stopped_o
);

    localparam WIDTH = ( COUNT & ( COUNT - 1 )) ? $clog2( COUNT ) : $clog2( COUNT + 1 );

    logic [WIDTH - 1:0] counter;

    always_ff @(posedge clk_i or posedge rst_i)
        if( rst_i ) begin
            counter   <= '0;
            stopped_o <= 1;
        end else
            if ( enable_i )
                if ( stopped_o ) begin
                    stopped_o <= 0;
                    counter   <= COUNT - 1'd1;
                end
            else
                if ( ~stopped_o ) begin
                    counter <= counter - 1'd1;
                    if ( counter == 1'd1 )
                        stopped_o <= 1;
                end

endmodule // traffic_light_timer
