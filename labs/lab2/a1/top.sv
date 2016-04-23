module watches (
	input	logic					rst_i,
	input	logic					clk_i,
	input	logic					up,
	input	logic					down,
	output	logic [ 6 : 0 ]			msec,
	output	logic [ 5 : 0 ]			sec,
	output	logic [ 5 : 0 ]			min,
	output	logic [ 4 : 0 ]			hour
	);
	
	localparam INPUT_FREQ	50_000_000;
	localparam MS_CYCLE		50_000;
	localparam MS_WIDTH		$bits( MS_CYCLE );
	
	logic [ MS_WIDTH - 1 : 0 ] input_freq_div;
	
	counter #( .WIDTH( MS_WIDTH ), .OVERFLOW( MS_CYCLE ) ) ms_counter( .*, .en_i( 1'b1 ), input_freq_div);
	
endmodule
