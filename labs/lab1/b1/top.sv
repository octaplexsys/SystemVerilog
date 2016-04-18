parameter N = 3;

module top (
	input		logic [ 2**N - 1 : 0 ]	line,
	output	logic [ N : 0 ]		code
	);
	
	coder #( N ) coder_instance ( .* );
	
endmodule

module coder #( parameter WIDTH = 4 ) (
	input		logic [ 2**WIDTH - 1 : 0 ]	line,
	output	logic [ WIDTH : 0 ]		code
	);
	
	logic [ WIDTH + 1 : 0 ]	wtf;
	
	always_comb begin
		wtf = '0;
		code = '0;
		while ( wtf < 2**WIDTH ) begin
			if ( line[wtf] == 1 ) begin
				code = wtf[ WIDTH : 0 ] + 1'b1;
			end
			wtf++;
		end
	end
	
endmodule

module tb ( );
	timeunit 1ns;
	timeprecision 1ns;
	
	localparam N = 3;
	
	logic [ 2**N - 1 : 0 ]	line;
	logic [ N : 0 ]		code;
	
	coder #( N ) DUT( .* );
	
	initial begin
		line = 0;
		#1us;
		$stop;
	end
	
	always begin
		#10ns;
		line = $urandom % 2**( 2**N );
	end
endmodule
