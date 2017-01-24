module top (
    input  logic       rst_i,
    input  logic       clk_i,
    input  logic       preset_i,
    input  logic [9:0] msec_preset,
    input  logic [5:0] sec_preset,
    input  logic [5:0] min_preset,
    input  logic [4:0] hour_preset,
    output logic [9:0] msec,
    output logic [5:0] sec,
    output logic [5:0] min,
    output logic [4:0] hour
);

    localparam INPUT_FREQ = 50_000_000;
    localparam MS_CYCLE   = INPUT_FREQ/1000;
    localparam MS_WIDTH   = $clog2( MS_CYCLE ) + 1;

    logic [MS_WIDTH - 1:0] input_freq_div;

    logic clock_cycle;
    logic msec_ovf;
    logic sec_ovf;
    logic min_ovf;

    assign clock_cycle = ( input_freq_div == MS_CYCLE - 1 );
    assign msec_ovf    = ( msec           == 10'd999  );
    assign sec_ovf     = ( sec            == 6'd59    );
    assign min_ovf     = ( min            == 6'd59    );

    counter #(
        .WIDTH( MS_WIDTH ),
        .OVERFLOW( MS_CYCLE )
    ) msec_div (
        .rst_i( rst_i ),
        .clk_i( clk_i ),
        .en_i( 1'b1 ),
        .preset_i( preset_i ),
        .preset_value( 0 ),
        .value( input_freq_div )
    );

    counter #(
        .WIDTH( $bits( msec ) ),
        .OVERFLOW( 1000 )
    ) msec_counter (
        .rst_i( rst_i ),
        .clk_i( clk_i ),
        .en_i( clock_cycle ),
        .preset_i( preset_i ),
        .preset_value( msec_preset ),
        .value( msec )
    );

    counter #(
        .WIDTH( $bits( sec ) ),
        .OVERFLOW( 60 )
    ) sec_counter (
        .rst_i( rst_i ),
        .clk_i( clk_i ),
        .en_i( clock_cycle && msec_ovf ),
        .preset_i( preset_i ),
        .preset_value( sec_preset ),
        .value( sec )
    );

    counter #(
        .WIDTH( $bits( min ) ),
        .OVERFLOW( 60 )
    ) min_counter (
        .rst_i( rst_i ),
        .clk_i( clk_i ),
        .en_i( clock_cycle && msec_ovf && sec_ovf ),
        .preset_i( preset_i ),
        .preset_value( min_preset ),
        .value( min )
    );

    counter #(
        .WIDTH( $bits( hour ) ),
        .OVERFLOW( 24 )
    ) hour_counter (
        .rst_i( rst_i ),
        .clk_i( clk_i ),
        .en_i( clock_cycle && msec_ovf && sec_ovf && min_ovf ),
        .preset_i( preset_i ),
        .preset_value( hour_preset ),
        .value( hour )
    );

endmodule
