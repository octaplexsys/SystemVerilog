module tb ( );

	timeunit 1ns;
	timeprecision 1ns;
	
	logic				rst_i;
	logic				clk_i;
	logic [ 15 : 0 ]	data_i;
	logic [ 4 : 0 ]		data_mod_i;
	logic				data_val_i;
	logic				ser_data_o;
	logic				busy_o;
	
	top DUT ( .* );
	
	initial begin
		rst_i		= 1;
		clk_i		= 1;
		data_i		= '0;
		data_mod_i	= '0;
		data_val_i	= 0;
		#45ns;
		rst_i		= 0;
	end
	
	always begin
		#10ns;
		clk_i = ~clk_i;
	end
	
	always @( posedge clk_i ) begin
		if ( !busy_o && !data_val_i ) begin
			data_i		<= $urandom % 2**16;
			data_mod_i	<= $urandom % 2**5;
			data_val_i	<= $urandom % 2;
		end else begin
			data_i		= '0;
			data_mod_i	= '0;
			data_val_i	= 0;
		end
	end
	
	initial begin
		#10us;
		$stop;
	end
	
endmodule
