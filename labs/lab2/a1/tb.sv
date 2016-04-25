module tb ( );
	timeunit 1ns;
	timeprecision 1ns;

	logic					rst_i;
	logic					clk_i;
	logic					preset_i;
	logic [ 9 : 0 ] 		msec_preset;
	logic [ 5 : 0 ]			sec_preset;
	logic [ 5 : 0 ]			min_preset;
	logic [ 4 : 0 ]			hour_preset;
	logic [ 9 : 0 ]			msec;
	logic [ 5 : 0 ]			sec;
	logic [ 5 : 0 ]			min;
	logic [ 4 : 0 ]			hour;
	
	top DUT( .* );
	
	initial begin
		rst_i = 1;
		clk_i = 1;
		preset_i = 1;
		msec_preset = 10'd999;
		sec_preset = 6'd59;
		min_preset = 6'd59;
		hour_preset = 5'd23;
		#55ns;
		rst_i = 0;
		#25ns;
		preset_i = 0;
	end
	
	initial begin
		#1001us $stop;
	end
	
	always begin
		#10ns clk_i = ~clk_i;
	end
	
endmodule
