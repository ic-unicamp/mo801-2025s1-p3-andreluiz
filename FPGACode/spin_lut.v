module Spin_lut(dE,enable,random,result);

	input [4:0] dE;
	input [11:0] random;
	input enable;
	output reg result;
	
	reg [11:0] probability;

	always @(*) begin
		if(enable) begin
			case (dE)
			     0: probability = 12'b111111111111; //probability = min(1,e^{-dE/T}) = 1 ---> 1 = biggest 12 bits number = 111111111111 = 4095
			     2: probability = 12'b001000101010; //probability = min(1,e^{-dE/T}) = e^{-(2/T)} = 0.13533528323 = relative to 12 bits int number ≃ 554 = 1000101010 
			     4: probability = 12'b000001001011; //probability = min(1,e^{-dE/T}) = e^{-(4/T)} = 0.01831563888 = relative to 12 bits int number ≃ 75  = 1000101010 
			    -2: probability = 12'b111111111111; //probability = min(1,e^{-dE/T}) = 1 ---> 1 = biggest 12 bits number = 4096 = 111111111111 
			    -4: probability = 12'b111111111111; //probability = min(1,e^{-dE/T}) = 1 ---> 1 = biggest 12 bits number = 4096 = 111111111111 
			    default: probability = 12'b111111111111;
			endcase
			result = (random <= probability)?1:0;
		end
	end
	
endmodule
