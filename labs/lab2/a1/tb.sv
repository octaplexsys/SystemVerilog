module tb ( );
    timeunit      1ns;
    timeprecision 1ns;

    logic       rst_i;
    logic       clk_i;
    logic       preset_i;
    logic [9:0] msec_preset;
    logic [5:0] sec_preset;
    logic [5:0] min_preset;
    logic [4:0] hour_preset;
    logic [9:0] msec;
    logic [5:0] sec;
    logic [5:0] min;
    logic [4:0] hour;
    
    top DUT (
        .rst_i      ( rst_i ),
        .clk_i      ( clk_i ),
        .preset_i   ( preset_i ),
        .msec_preset( msec_preset ),
        .sec_preset ( sec_preset ),
        .min_preset ( min_preset ),
        .hour_preset( hour_preset ),
        .msec       ( msec ),
        .sec        ( sec ),
        .min        ( min ),
        .hour       ( hour )
    );
    
    initial begin
        rst_i          = 1;
        clk_i          = 1;
        preset_i       = 1;
        msec_preset    = 950;
        sec_preset     = 59;
        min_preset     = 59;
        hour_preset    = 23;
        #55ns rst_i    = 0;
        #25ns preset_i = 0;
    end
    
    initial
        #60000us $stop;
    
    always
        #10ns clk_i = ~clk_i;
    
endmodule
