module tb( );
	timeunit 1ns;
	timeprecision 1ns;
	
	logic				rst_i;
	logic				clk_i;
	logic [ 2 : 0 ]		lp_i;
	logic [ 2 : 0 ]		object_number_i;
	logic				command_i;
	logic				en_i;
	logic [ 19 : 0 ]	status_o;
	
	top DUT(.*);
	
	initial begin
		rst_i = 1;
		clk_i = 1;
		lp_i = 0;
		object_number_i = 0;
		command_i = 0;
		en_i = 0;
		#45ns;
		rst_i = 0;
	end
	
	initial begin
		#50us;
		$stop;
	end
	
	always begin
		#10ns; clk_i = ~clk_i;
	end
	
	always @( posedge clk_i )begin
		lp_i = $urandom % 4;
		object_number_i = $urandom % 5;
		command_i = $urandom % 2;
		en_i = $urandom % 2;
	end
	
endmodule
