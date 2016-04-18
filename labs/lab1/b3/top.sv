module top #( parameter N = 2 ) (
	input	logic [ 2**N - 1 : 0 ]	data_i,
	input	logic [ N - 1 : 0 ]		select_i,
	output	logic					selected_o
	);
	
	mux_N #( N ) mux_instance( .* );

endmodule

module mux_N #( parameter N = 4 ) (
	input	logic [ 2**N - 1 : 0 ]	data_i,
	input	logic [ N - 1 : 0 ]		select_i,
	output	logic					selected_o
	);
	
	assign selected_o = data_i[select_i];

endmodule

module tb ( );
	timeunit 1ns;
	timeprecision 1ns;
	
	localparam N = 4;
	
	logic [ 2**N - 1 : 0 ]	data_i;
	logic [ N - 1 : 0 ]		select_i;
	logic					selected_o;
	
	top #( N ) DUT( .* );
	
	initial begin
		data_i = '0;
		select_i = '0;
		#1us;
		$stop;
	end
	
	event error;
	
	always @( data_i ) begin
		if ( selected_o !== data_i[select_i] ) begin
			-> error;
		end
	end
	
	always begin
		#10ns;
		data_i <= $urandom % 2**( 2**N );
		select_i <= $urandom % 2**N;
	end
	
	always @( error ) $stop;
	
endmodule
