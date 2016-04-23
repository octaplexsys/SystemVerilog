module watches (
	input	logic			rst_i,
	input	logic			clk_i,
	input	logic			up,
	input	logic			down,
	output	logic [ 6 : 0 ]	msec,
	output	logic [ 5 : 0 ]	sec,
	output	logic [ 5 : 0 ]	min,
	output	logic [ 4 : 0 ]	min
	);
	
	