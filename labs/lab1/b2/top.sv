parameter N = 3;

module top (
	input		logic [ N : 0 ]			code,
	output	logic [ 2**N - 1 : 0 ]	line
	);
	
	decoder #( N ) decoder_instance ( .* );
	
endmodule

module decoder #(parameter WIDTH = 4) (
	input	logic [ WIDTH : 0 ]		code,
	output	logic [ 2**WIDTH - 1 : 0 ]	line
	);
	
	always_comb begin
		line = '0;
		if ( code ) begin
			line[code - 1'b1] = 1'b1;
		end else begin
			line = '0;
		end
	end		
	
endmodule

module tb ( );

	timeunit 1ns;
	timeprecision 1ns;

	parameter N = 4;
	
	logic [ N : 0 ]		code;
	logic [ 2**N - 1 : 0 ]	line;
	
	decoder #( N ) decoder_instance ( .* );
	
	initial begin
		code = '0;
		#1us;
		$stop;
	end
		
	always begin
		#10ns;
		code <= $urandom % 2**N + $urandom % 2;
	end		
	
endmodule
