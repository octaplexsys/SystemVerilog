module tb( );
	
	timeunit 1ns;
	timeprecision 1ns;

	logic rst_i, preload_i, clk_i, inc_i, reverse_i;
	logic [ 3 : 0 ] counter;
	
	top DUT( .* );
	
	initial begin
		rst_i = 1;
		preload_i = 1;
		clk_i = 1;
		inc_i = 1;
		reverse_i = 0;
		#20ns;
		rst_i = 0;
		#680ns;
		reverse_i = 1;
		#680ns;
		$stop;
	end
	
	always begin
		#20ns; clk_i = ~clk_i;
	end

endmodule
	