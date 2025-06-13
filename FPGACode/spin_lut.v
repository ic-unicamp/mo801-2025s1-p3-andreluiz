module Spin_lut(dE,probability);

	input [7:0] dE;
	output reg [11:0] probability;

	always @(*) begin
	case (dE)
	    7'b00000000: probability = 1; //0
	    7'b00000010: probability = 2; //2
	    7'b00000100: probability = 3; //4
	    7'b11111110: probability = 4; //-2
	    7'b11111100: probability = 5; //-4
	    default: probability = 1;
	endcase
	end

endmodule
