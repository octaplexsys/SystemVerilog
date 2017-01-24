`include "types_pkg.sv"

module lights_control (
    input  logic clk_i,

    input  light_color_e current_light_color,

    output logic red_o,
    output logic yellow_o,
    output logic green_o
);

    assign red_o    = ( current_light_color == RED_YELLOW ) || ( current_light_color == RED );
    assign yellow_o = ( current_light_color == RED_YELLOW ) || ( current_light_color == YELLOW );
    assign green_o  = ( current_light_color == GREEN ) || ( current_light_color == GREEN_FLASH ) && ~clk_i;

endmodule