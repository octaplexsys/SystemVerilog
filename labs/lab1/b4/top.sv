module top #( parameter N = 2 ) (
	input	logic					data_i,
	input	logic [ N - 1 : 0 ]		select_i,
	output	logic [ 2**N - 1 : 0 ]	selected_o
	);
	
	dmux #( N ) mux_instance( .* );

endmodule

module dmux #( parameter N = 4 ) (
	input	logic					data_i,
	input	logic [ N - 1 : 0 ]		select_i,
	output	logic [ 2**N - 1 : 0 ]	selected_o
	);
	
	always_comb begin
		selected_o = '0;
		selected_o[select_i] = data_i;
	end

endmodule

module tb ( );
	timeunit 1ns;
	timeprecision 1ns;
	
	localparam N = 3;
	
	logic					data_i;
	logic [ N - 1 : 0 ]		select_i;
	logic [ 2**N - 1 : 0 ]	selected_o;
	
	top #( N ) DUT( .* );
	
	initial begin
		data_i = '0;
		select_i = '0;
		#1us;
		$stop;
	end
	
	event error;
	
	always @( data_i or select_i ) begin
		#1ns;
		if ( selected_o[select_i] !== data_i ) begin
			-> error;
		end
	end
	
	always begin
		#10ns;
		data_i <= $urandom % 2;
		select_i <= $urandom % 2**N;
	end
	
	always @( error ) $stop; 
	
endmodule
