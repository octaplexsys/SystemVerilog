module top (
	input	logic					rst_i,
	input	logic					clk_i,
	input	logic					up,
	input	logic					down,
	output	logic [ 9 : 0 ]			msec,
	output	logic [ 5 : 0 ]			sec,
	output	logic [ 5 : 0 ]			min,
	output	logic [ 4 : 0 ]			hour
	);
	
	localparam INPUT_FREQ 	=	50_000_000;
	localparam MS_CYCLE		=	INPUT_FREQ/1000;
	localparam MS_WIDTH		=	$clog2( MS_CYCLE ) + 1;
	
	logic [ MS_WIDTH - 1 : 0 ] input_freq_div;
	
	counter
	#( .WIDTH( MS_WIDTH ),		.OVERFLOW( MS_CYCLE ) )	msec_div		(
		.*,
		.en_i( 1'b1 ),
		.value( input_freq_div )
	);
	
	counter
	#( .WIDTH( $bits( msec ) ),	.OVERFLOW( 1000 ) )		msec_counter	(
		.*,
		.en_i( !input_freq_div ),
		.value( msec )
	);
	
	counter
	#( .WIDTH( $bits( sec ) ),	.OVERFLOW( 60 ) ) 		sec_counter		(
		.*,
		.en_i( !input_freq_div && ( msec == 10'd999 ) ),
		.value( sec )
	);
	
	counter
	#( .WIDTH( $bits( min ) ),	.OVERFLOW( 60 ) ) 		min_counter		(
		.*,
		.en_i( !input_freq_div && ( sec == 6'd59 ) && ( msec == 10'd999 ) ),
		.value( min )
	);
	
	counter
	#( .WIDTH( $bits( hour ) ),	.OVERFLOW( 24 ) )	 	hour_counter	(
		.*,
		.en_i( !input_freq_div && ( min == 6'd59 ) && ( sec == 6'd59 ) && ( msec == 10'd999 ) ),
		.value( hour )
	);
	
endmodule
