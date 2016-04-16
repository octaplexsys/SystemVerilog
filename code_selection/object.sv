module object(
	input	logic				rst_i,
	input	logic				clk_i,
	input	logic 				en_i,
	input	logic				command_i,
	output	logic				status_o
	);
	
	always_ff @( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			status_o <= 0;
		end else begin
			if ( en_i ) begin
				status_o <= command_i & en_i;
			end
		end
	end

endmodule
