module tb ( );

    timeunit      1ns;
    timeprecision 1ns;
    
    logic        rst_i;
    logic        clk_i;
    logic [15:0] data_i;
    logic  [4:0] data_mod_i;
    logic        data_val_i;
    logic        ser_data;
    logic        ser_data_val;
    logic        busy;
    logic [15:0] data_o;
    logic  [4:0] data_mod_o;
    logic        data_val_o;
    
    serial DUT_serial (
        .rst_i         ( rst_i ),
        .clk_i         ( clk_i ),
        .data_i        ( data_i ),
        .data_mod_i    ( data_mod_i ),
        .data_val_i    ( data_val_i ),
        .ser_data_o    ( ser_data ),
        .ser_data_val_o( ser_data_val ),
        .busy_o        ( busy )
    );
    
    deserial DUT_deserial (
        .rst_i          ( rst_i ),
        .clk_i          ( clk_i ),
        .ser_data_i     ( ser_data ),
        .ser_data_val_i ( ser_data_val ),
        .busy_i         ( busy ),
        .data_o         ( data_o ),
        .data_mod_o     ( data_mod_o ),
        .data_val_o     ( data_val_o )
    );

    initial begin
        rst_i       = 1;
        clk_i       = 1;
        data_i      = 0;
        data_mod_i  = 0;
        data_val_i  = 0;
        #45ns;
        rst_i       = 0;
    end
    
    always
        #10ns clk_i = ~clk_i;
    
    always @( posedge clk_i )
        if ( !busy ) begin
            data_i     <= $urandom % 2**16;
            data_mod_i <= $urandom % 16 + 1;
            data_val_i <= $urandom % 2;
        end else
            if ( !data_val_i ) begin
                data_i     <= $urandom % 2**16;
                data_mod_i <= $urandom % 16 + 1;
                data_val_i <= $urandom % 2;
            end
    
    initial
        #3us $stop;
    
endmodule
