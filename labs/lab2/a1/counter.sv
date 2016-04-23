module counter #( parameter WIDTH = 4, parameter OVERFLOW = 60 ) (
	input	logic			rst_i,
	input	logic			clk_i,
	input	logic			en_i,