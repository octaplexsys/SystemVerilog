module tb ( );

    localparam DELAY_CYCLES = 4;

    logic clk_i,
          key_i,
          key_pressed_stb_o;

    debounce #(
        .DELAY_CYCLES( DELAY_CYCLES )
    ) DUT (
        .clk_i            ( clk_i ),
        .key_i            ( key_i ),
        .key_pressed_stb_o( key_pressed_stb_o )
    );

    initial begin
        clk_i = 1;
        key_i = 1;

        #1us $stop;
    end

    always
        #10ns clk_i = ~clk_i;

    int i;
    logic in_task;

    initial begin
        i       = 0;
        in_task = 0;
    end

    always @( posedge clk_i )
        if ( ~in_task ) begin
            i <= i + 1;
            if ( i % 2 )
                press_key();
            else
                bounce();
        end

    task press_key;
        in_task = 1;
        @( posedge clk_i )
            key_i <= 0;
        repeat ( DELAY_CYCLES + 1 )
            @( posedge clk_i );
        @( posedge clk_i )
            key_i <= 1;
        in_task = 0;
    endtask : press_key

    task bounce;
        in_task = 1;
        @( posedge clk_i )
            key_i <= 0;
        @( posedge clk_i )
            key_i <= 1;
        @( posedge clk_i )
            key_i <= 0;
        @( posedge clk_i )
            key_i <= 1;
        @( posedge clk_i )
            key_i <= 0;
        repeat ( DELAY_CYCLES + 1 )
            @( posedge clk_i );
        @( posedge clk_i )
            key_i <= 1;
        in_task = 0;
    endtask : bounce

endmodule