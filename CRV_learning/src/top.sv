import defs::*;

module top
(
	input	logic		rst,
	input	logic		clk,
	input	logic[31:0]	a,
	input	logic[31:0]	b,
	input	op_code_e	op_code,
	output	logic[31:0]	result
);

always_ff @(posedge clk or posedge rst)
begin
	if (rst)
		result <= '0;
	else
	begin
		case(op_code)
			ADD: result <= a + b;
			SUB: result <= a - b;
			AND: result <= a & b;
			NOT: result <= ~b;
		endcase
	end
end

endmodule

