module tb ( );
	timeunit 1ns;
	timeprecision 1ns;

	logic					rst_i;
	logic					clk_i;
	logic					up;
	logic					down;
	logic [ 9 : 0 ]			msec;
	logic [ 5 : 0 ]			sec;
	logic [ 5 : 0 ]			min;
	logic [ 4 : 0 ]			hour;
	
	top DUT( .* );
	
	initial begin
		rst_i = 1;
		clk_i = 1;
		#55ns;
		rst_i = 0;
	end
	
	initial begin
		#10ms $stop;
	end
	
	always begin
		#10ns clk_i = ~clk_i;
	end
	
endmodule
