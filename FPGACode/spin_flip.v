module Spin_flip(spin_val, dE_negative, valid_alpha, enable, result);
	
	input spin_val, dE_negative, valid_alpha;
	input enable;
	output reg result;
	
	always @(*) begin
	        $display("FLIP");
		if(enable)
			result = spin_val ^ (dE_negative | valid_alpha);
	end

endmodule
