module deserial (
    input  logic        rst_i,
    input  logic        clk_i,
    input  logic        ser_data_i,
    input  logic        ser_data_val_i,
    input  logic        busy_i,
    output logic [15:0] data_o,
    output logic  [4:0] data_mod_o,
    output logic        data_val_o
);

    typedef enum logic { IDLE, RECEIVING } status_e;

    status_e status;

    always_ff @(posedge clk_i or posedge rst_i)
        if( rst_i )
            status <= IDLE;
        else
            if ( ser_data_val_i && busy_i )
                status <= RECEIVING;
            else
                status <= IDLE;

    logic  [3:0] current_bit;

    always_ff @(posedge clk_i or posedge rst_i)
        if ( rst_i ) begin
            data_o      <= 0;
            data_mod_o  <= 0;
            data_val_o  <= 0;
            current_bit <= '1;
        end else begin
            if ( status == IDLE ) begin
                data_val_o <= 0;
                if ( ser_data_val_i && busy_i ) begin
                    data_o      <= { ser_data_i, 15'd0 };
                    current_bit <= current_bit - 4'd1;
                end
            end

            if ( status == RECEIVING )
                if ( ser_data_val_i && busy_i )
                    if ( current_bit ) begin
                        data_o[current_bit] <= ser_data_i;
                        current_bit         <= current_bit - 4'd1;
                    end else begin
                        current_bit         <= '1;
                    end
                else begin
                    current_bit <= '1;
                    if ( ser_data_val_i ) begin
                        data_o[current_bit] <= ser_data_i;
                        data_mod_o          <= 5'd16 - current_bit;
                        data_val_o          <= 1'd1;
                    end
                end
        end

endmodule
