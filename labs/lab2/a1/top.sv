module top (
	input	logic					rst_i,
	input	logic					clk_i,
	input	logic					up,
	input	logic					down,
	output	logic [ 6 : 0 ]			msec,
	output	logic [ 5 : 0 ]			sec,
	output	logic [ 5 : 0 ]			min,
	output	logic [ 4 : 0 ]			hour
	);
	
	localparam INPUT_FREQ 	=	50_000_000;
	localparam MS_CYCLE		=	50_000;
	localparam MS_WIDTH		=	$clog2( MS_CYCLE );
	
	logic [ MS_WIDTH - 1 : 0 ] input_freq_div;
	
	counter #( .WIDTH( MS_WIDTH ), .OVERFLOW( MS_CYCLE ) ) ms_counter( .*, .en_i( 1'b1 ), .value( input_freq_div ) );
	
endmodule

module tb ( );
	timeunit 1ns;
	timeprecision 1ns;

	logic					rst_i;
	logic					clk_i;
	logic					up;
	logic					down;
	logic [ 6 : 0 ]			msec;
	logic [ 5 : 0 ]			sec;
	logic [ 5 : 0 ]			min;
	logic [ 4 : 0 ]			hour;
	
	top DUT( .* );
	
	initial begin
		rst_i = 1;
		clk_i = 1;
		#35ns;
		rst_i = 0;
	end
	
	initial begin
		#5ms $stop;
	end
	
	always begin
		#10ns clk_i = ~clk_i;
	end
	
endmodule
	 