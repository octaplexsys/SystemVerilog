module serial (
    input  logic        rst_i,
    input  logic        clk_i,
    input  logic [15:0] data_i,
    input  logic  [4:0] data_mod_i,
    input  logic        data_val_i,
    output logic        ser_data_o,
    output logic        ser_data_val_o,
    output logic        busy_o
);

    logic [15:0] data;
    logic  [3:0] data_mod;

    assign ser_data_o = data[15];

    always_ff @( posedge rst_i or posedge clk_i )
        if ( rst_i ) begin
            data           <= 0;
            ser_data_val_o <= 0;
            busy_o         <= 0;
            data_mod       <= 0;
        end else
            if ( !busy_o ) begin
                if ( data_val_i )
                    if ( data_mod_i > 3) begin
                        ser_data_val_o <= 1;
                        data           <= data_i;
                        busy_o         <= '1;
                        data_mod       <= ( data_mod_i > 16 ) ? 4'd15 : data_mod_i - 4'd1;
                    end
                else
                    ser_data_val_o <= 0;
            end else begin
                data     <= { data[14:0], 1'd0 };
                data_mod <= data_mod - 1'b1;

                if ( data_mod == 0 )
                    ser_data_val_o <= 0;
                
                if ( data_mod == 1 )
                    busy_o <= '0;
            end

endmodule
