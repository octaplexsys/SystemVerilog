`ifndef TYPES_PKG
`define TYPES_PKG

package types_pkg;

    typedef enum logic [2:0]{
        RED,
        RED_YELLOW,
        GREEN,
        GREEN_FLASH,
        YELLOW
    } light_color_e;

endpackage

import types_pkg::*;

`endif // !TYPES_PKG