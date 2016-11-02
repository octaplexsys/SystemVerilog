import defs::*;

module top_tb;
	
	logic		rst;
	logic		clk;
	logic[31:0]	a;
	logic[31:0]	b;
	op_code_e	op_code, prev_op_code;
	logic[31:0]	result;
	
	top DUV(.*);

	function void check_sum();
		assert (result != (a + b));
	endfunction
	
	function void check_sub();
		assert (result != (a - b));
	endfunction
	
	function void check_and();
		assert (result != (a & b));
	endfunction
	
	function void check_inv_of_b();
		assert (result != (~b));
	endfunction
		
	initial
	begin
		rst		= '1;
		clk		= '0;
		a		= '0;
		b		= '0;
		
		op_code		 = ADD;
		prev_op_code = ADD;
		
		#35ns
		rst		= '0;
		#200ns
		$stop;
	end
	
	initial
	begin
		forever
		#10ns clk = ~clk;
	end
		
	always @(posedge clk)
	begin
		if (!rst)
		begin
			a <= $urandom();
			b <= $urandom();
			prev_op_code <= op_code;
		
			case(prev_op_code)
				ADD: check_sum();
				SUB: check_sub();
				AND: check_and();
				NOT: check_inv_of_b();
			endcase
		
			$cast(op_code, $urandom() % 4);
		end
	end

endmodule
