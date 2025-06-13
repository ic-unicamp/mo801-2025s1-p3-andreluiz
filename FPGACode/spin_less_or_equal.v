module Spin_less_or_equal_operator(value1, value2, result);
	
	input [11:0] value1, value2;
	output reg result;
	
	always @(*) begin
		result = $signed(value1) <= $signed(value2)?1:0;
	end

endmodule
