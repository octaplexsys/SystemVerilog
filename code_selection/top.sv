module top (
	input	logic				rst_i,
	input	logic				clk_i,
	input	logic [ 2 : 0 ]		lp_i,
	input	logic [ 2 : 0 ]		object_number_i,
	input	logic				command_i,
	input	logic				en_i,
	output	logic [ 19 : 0 ]	status_o
	);
	
	logic [ 3 : 0 ] select;
	logic [ 19 : 0 ] object_status;
	
	linear_point lp0( rst_i, clk_i, select[0], object_number_i, command_i, object_status[4 : 0] );
	linear_point lp1( rst_i, clk_i, select[1], object_number_i, command_i, object_status[9 : 5] );
	linear_point lp2( rst_i, clk_i, select[2], object_number_i, command_i, object_status[14 : 10] );
	linear_point lp3( rst_i, clk_i, select[3], object_number_i, command_i, object_status[19 : 15] );
	
	assign status_o = object_status;
	
	always_comb begin
		if ( rst_i ) begin
			select = 0;
		end else begin
			if ( en_i ) begin
				case( lp_i )
					0: begin select = 1; end
					1: begin select = 2; end
					2: begin select = 4; end
					3: begin select = 8; end
					default: begin select = 0; end
				endcase
			end else begin
				select = 0;
			end
		end
	end
	
	
endmodule
