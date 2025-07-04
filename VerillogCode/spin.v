module Spin(clk, spin_val, left, right, top, bottom, rand32, enable, final_spin_val);
	
	input clk;
	input spin_val, left, right, top, bottom; 
	input enable;
	input [31:0]rand32;
	output final_spin_val;
	
	//reg[31:0] seed;
	
	wire dE_negative, valid_alpha;
	wire [4:0] dE;
	wire [11:0] rand12; 
	reg [11:0] random;
	integer counter, rand_aux;

	Spin_calculate_dE calculate_dE(
	.spin_val(spin_val),
	.left(left),
	.right(right),
	.top(top),
	.bottom(bottom),
	.enable(enable),
	.dE(dE),
	.result(dE_negative)
	);
	
	Sfrl_12 rand12_mod(
	.clk(clk),
	.seed_val(rand_aux[7:0]),
	.random(rand12)
	);
		
	Spin_lut lut(
	.dE(dE),
	.enable(enable),
	.random(random),
	.result(valid_alpha)
	);
	
	Spin_flip flip(
	.spin_val(spin_val),
	.dE_negative(dE_negative),
	.valid_alpha(valid_alpha),
	.enable(enable),
	.result(final_spin_val)
	);
	
	initial begin
		counter = 0;
	end
	
	always @(clk) begin
		rand_aux = counter[7:0] + left + right + top + bottom;
		counter++;
		random = $random%12'b111111111111;//rand32[31:20] ^ rand12;//$random%12'b111111111111;//
	end;

endmodule
