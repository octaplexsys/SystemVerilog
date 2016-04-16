module linear_point (
	input	logic				rst_i,
	input	logic				clk_i,
	input	logic 				en_i,
	input	logic [ 2 : 0 ]		object_selection,
	input	logic				command_i,
	output	logic [ 4 : 0 ]		status_o
	);
	
	logic [ 4 : 0 ] select;
	logic [ 4 : 0 ] object_status;
	
	assign status_o = object_status;
	
	always_comb begin
		if ( rst_i ) begin
			select = 0;
		end else begin
			if ( en_i ) begin
				case( object_selection )
					0: begin select = 1; end
					1: begin select = 2; end
					2: begin select = 4; end
					3: begin select = 8; end
					4: begin select = 16; end
					default: begin select = 0; end
				endcase
			end else begin
				select = 0;
			end
		end
	end
		
	object objects0( rst_i, clk_i, select[0], command_i, object_status[0] );
	object objects1( rst_i, clk_i, select[1], command_i, object_status[1] );
	object objects2( rst_i, clk_i, select[2], command_i, object_status[2] );
	object objects3( rst_i, clk_i, select[3], command_i, object_status[3] );
	object objects4( rst_i, clk_i, select[4], command_i, object_status[4] );
	
endmodule
