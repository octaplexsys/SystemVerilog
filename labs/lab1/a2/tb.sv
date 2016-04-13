module tb( );

	timeunit 1ns;
	timeprecision 1ns;

	logic [ 3 : 0 ] a, b;
	logic ext_carry, smaller, greather, eq;
	
	top DUT( .* );
	
	initial begin
		ext_carry = 1;
		a = 0;
		b = 0;
		#2560ns;
		$stop;
	end
	
	always begin
		#10ns; a++;
	end
	
	always begin
		#160ns; b++;
	end
	
endmodule
