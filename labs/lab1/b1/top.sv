parameter N = 8;

module top (
	input	logic [ 2**N - 1 : 0 ]	line,
	output	logic [ N - 1 : 0 ]		code
	);
	
	coder #( N ) coder_instance ( .* );
	
endmodule

module coder #(parameter WIDTH = 4) (
	input	logic [ 2**WIDTH - 1 : 0 ]	line,
	output	logic [ WIDTH - 1 : 0 ]		code
	);
	
	always_comb begin
		if ( line ) begin
			code = 1';
			
	end
		
	
endmodule
