module top (
	input	logic				rst_i,
	input	logic				clk_i,
	input	logic [ 15 : 0 ]	data_i,
	input	logic [ 4 : 0 ]		data_mod_i,
	input	logic				data_val_i,
	output	logic				ser_data_o,
	output	logic				busy_o
	);
	
	logic [ 15 : 0 ]	data;
	logic [ 4 : 0 ]		data_mod;
	assign ser_data_o = data[ 15 ];
	
	always_ff @( posedge rst_i or posedge clk_i ) begin
		if ( rst_i ) begin
			data		<= '0;
			busy_o		<= '0;
			data_mod	<= '0;
		end else begin
			if ( !busy_o ) begin
				if ( data_val_i ) begin
					if ( data_mod_i > 3) begin
						data 		<= data_i;
						busy_o 		<= '1;
						if ( data_mod_i > 16 ) begin
							data_mod 	<= 5'd16;
						end else begin
							data_mod 	<= data_mod_i;
						end
					end
				end
			end else begin
				if ( data_mod == 1) begin
					busy_o		<= '0;
				end else begin
					for ( int i = 15; i > 0; --i ) begin
						data[i]	<= data[i - 1];
					end
					data_mod	<= data_mod - 1'b1;
				end
			end
		end
	end

endmodule
