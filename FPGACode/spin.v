module Spin(spin_val, left, right, top, bottom, random, final_spin_val);

	input spin_val, left, right, top, bottom; 
	input [11:0]random;
	output final_spin_val;
	
	wire dE_negative, valid_alpha;
	wire [4:0] dE;
	wire [11:0] probability;
	
	Spin_calculate_dE calculate_dE(
	.spin_val(spin_val),
	.left(left),
	.right(right),
	.top(top),
	.bottom(bottom),
	.dE(dE)
	);

	Spin_less_or_equal_operator dE_negative_or_positive(
	.value1(dE),
	.value2(0),
	.result(dE_negative)
	);
		
	Spin_lut lut(
	.dE(dE),
	.probability(probability)
	);
	
	Spin_less_or_equal_operator alpha_verification(
	.value1(random),
	.value2(probability)
	);
	
	Spin_flip flip(
	.spin_val(spin_val),
	.dE_negative(dE_negative),
	.valid_alpha(valid_alpha),
	.result(final_spin_val)
	);

endmodule
