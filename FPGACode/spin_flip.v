module Spin_flip(spin_val, dE_negative, valid_alpha, result);
	
	input spin_val, dE_negative, valid_alpha;
	output reg result;
	
	always @(*) begin
		result = spin_val ^ (dE_negative | valid_alpha);
	end

endmodule
