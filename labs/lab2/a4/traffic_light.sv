`include "types_pkg.sv"

module traffic_light #(
    parameter RED_TIME         = 10,
    parameter RED_YELLOW_TIME  =  3,
    parameter GREEN_TIME       = 10,
    parameter GREEN_FLASH_TIME =  3,
    parameter YELLOW_TIME      =  5
) (
    input  logic clk_i,
    input  logic rst_i,

    output logic red_o,
    output logic yellow_o,
    output logic green_o
);
    
    logic stopped_red,
          stopped_red_yellow,
          stopped_green,
          stopped_green_flash,
          stopped_yellow;

    light_color_e current_light_color,
                  next_light_color;

    fsm light_sequence (
        .clk_i( clk_i ),
        .rst_i( rst_i ),
        .stopped_red( stopped_red ),
        .stopped_red_yellow( stopped_red_yellow ),
        .stopped_green( stopped_green ),
        .stopped_green_flash( stopped_green_flash ),
        .stopped_yellow( stopped_yellow ),
        .current_light_color( current_light_color ),
        .next_light_color( next_light_color )
    );

    countdown_timer #(
        .COUNT( RED_TIME )
    ) red_timer (
        .clk_i    ( clk_i ),
        .rst_i    ( rst_i ),
        .enable_i ( next_light_color == RED && stopped_yellow ),
        .stopped_o( stopped_red )
    );

    countdown_timer #(
        .COUNT( RED_YELLOW_TIME )
    ) red_yellow_timer (
        .clk_i    ( clk_i ),
        .rst_i    ( rst_i ),
        .enable_i ( next_light_color == RED_YELLOW && stopped_red ),
        .stopped_o( stopped_red_yellow )
    );

    countdown_timer #(
        .COUNT( GREEN_TIME )
    ) green_timer (
        .clk_i    ( clk_i ),
        .rst_i    ( rst_i ),
        .enable_i ( next_light_color == GREEN && stopped_red_yellow ),
        .stopped_o( stopped_green )
    );

    countdown_timer #(
        .COUNT( GREEN_FLASH_TIME )
    ) green_flash_timer (
        .clk_i    ( clk_i ),
        .rst_i    ( rst_i ),
        .enable_i ( next_light_color == GREEN_FLASH && stopped_green ),
        .stopped_o( stopped_green_flash )
    );

    countdown_timer #(
        .COUNT( YELLOW_TIME )
    ) yellow_timer (
        .clk_i    ( clk_i ),
        .rst_i    ( rst_i ),
        .enable_i ( next_light_color == YELLOW && stopped_green_flash ),
        .stopped_o( stopped_yellow )
    );

    lights_control lc (
        .clk_i              ( clk_i ),
        .current_light_color( current_light_color ),
        .red_o              ( red_o ),
        .yellow_o           ( yellow_o ),
        .green_o            ( green_o )
    );

endmodule // traffic_light
