parameter N = 3;

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
	
	logic [ WIDTH - 1 : 0 ]	wtf;
	
	always_comb begin
		wtf = '0;
		while ( wtf < WIDTH ) begin
			if ( line[wtf] == 1 ) begin
				code = wtf;
			end
			++wtf;
		end
	end
	
endmodule
