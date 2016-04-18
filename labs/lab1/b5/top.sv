module top #( parameter N = 2 ) (
	input	logic					rst_i,
	input	logic					clk_i,
	input	logic					reverse_i,
	output	logic [ 2**N - 1 : 0 ]	value_o
	);
	
	reverse_counter #( N ) rc( .* );

endmodule

module reverse_counter #( parameter N = 4 ) (
	input	logic					rst_i,
	input	logic					clk_i,
	input	logic					reverse_i,
	output	logic [ 2**N - 1 : 0 ]	value_o
	);
	
	always_ff @( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			value_o <= '0;
		end else begin
			if ( reverse_i ) begin
				value_o <= value_o - 1'b1;
			end else begin
				value_o <= value_o + 1'b1;
			end
		end
	end

endmodule

module tb ( );
	timeunit 1ns;
	timeprecision 1ns;
	
	localparam N = 3;
	
	logic					rst_i;
	logic					clk_i;
	logic					reverse_i;
	logic [ 2**N - 1 : 0 ]	value_o;
	
	top #( N ) DUT( .* );
	
	initial begin
		rst_i = '1;
		clk_i = '1;
		reverse_i = '0;
		#25ns;
		rst_i = '0;
	end
	
	initial begin
		#1us;
		$stop;
	end
	
	always begin
		#10ns; clk_i <= ~clk_i;
	end
	
	always @( posedge clk_i ) begin
		reverse_i <= $urandom % 2;
	end
	
endmodule
