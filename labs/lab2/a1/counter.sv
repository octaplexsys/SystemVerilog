module counter #( parameter WIDTH = 8, parameter OVERFLOW = 2**WIDTH - 1 ) (
	input	logic					rst_i,
	input	logic					clk_i,
	input	logic					en_i,
	output	logic [ WIDTH - 1 : 0 ] value
	);
	
	always_ff @( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			value <= '0;
		end else begin
			if ( en_i ) begin
				if ( value < OVERFLOW - 1 ) begin
					value <= value + 1'b1;
				end else begin
					value <= '0;
				end
			end
		end
	end
endmodule
