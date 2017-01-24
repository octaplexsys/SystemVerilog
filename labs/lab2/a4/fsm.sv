`include "types_pkg.sv"

module fsm (
    input  logic clk_i,
    input  logic rst_i,

    input  logic stopped_red,
    input  logic stopped_red_yellow,
    input  logic stopped_green,
    input  logic stopped_green_flash,
    input  logic stopped_yellow,

    output light_color_e current_light_color,
    output light_color_e next_light_color
);
    
    always_ff @( posedge clk_i or posedge rst_i )
        if ( rst_i )
            current_light_color <= RED;
        else
            current_light_color <= next_light_color;
    
    always_comb
        case ( current_light_color )
            RED:
                if ( stopped_red )
                    next_light_color = RED_YELLOW;
                else
                    next_light_color = RED;
            RED_YELLOW:
                if ( stopped_red_yellow )
                    next_light_color = GREEN;
                else
                    next_light_color = RED_YELLOW;
            GREEN:
                if ( stopped_green )
                    next_light_color = GREEN_FLASH;
                else
                    next_light_color = GREEN;
            GREEN_FLASH:
                if ( stopped_green_flash )
                    next_light_color = YELLOW;
                else
                    next_light_color = GREEN_FLASH;
            YELLOW:
                if ( stopped_yellow )
                    next_light_color = RED;
                else                    
                    next_light_color = YELLOW;
        endcase // current_light_color

endmodule // fsm