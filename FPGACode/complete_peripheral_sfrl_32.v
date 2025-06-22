module Sfrl_32(clk,seed_val,random);
	input clk;
	input [7:0] seed_val;
	output reg [31:0] random;
	integer i;
	reg [7:0]seed;
	reg seed_bit;
	always @(posedge clk) begin
		seed = seed_val;
		for(i=0; i<32; i=i+1)begin
		random[i] = seed[0];
		seed_bit = seed[0] ^ seed[1]; 
		seed = seed >> 1;
		seed[7] = seed_bit;
		//$display("seed_val:%5b ,seed_bit:%5b,seed:%5b; random:%5b",seed_val ,seed_bit, seed, random);
		end
	end

endmodule
