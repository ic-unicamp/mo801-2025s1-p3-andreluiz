module Spin_calculate_dE(spin_val,left,right,top,bottom,dE);
	
	input spin_val,left,right,top,bottom;
	output reg [7:0] dE;

	always @(spin_val) begin
	    case ({spin_val,left,right,top,bottom})
		    5'b00000: dE =  4;
	    	    5'b00001: dE =  2;
	      	    5'b00010: dE =  2;
	    	    5'b00011: dE =  0;
	    	    5'b00100: dE =  2;
	      	    5'b00101: dE =  0;
	      	    5'b00110: dE =  0;
	      	    5'b00111: dE = -2;
	  	    5'b01000: dE =  2;
	  	    5'b01001: dE =  0;
	  	    5'b01010: dE =  0;
	  	    5'b01011: dE = -2;
	  	    5'b01100: dE =  0;
	  	    5'b01101: dE = -2;
	  	    5'b01110: dE = -2;
	  	    5'b01111: dE = -4;  	    
		    5'b10000: dE = -4;
	    	    5'b10001: dE = -2;
	      	    5'b10010: dE = -2;
	    	    5'b10011: dE =  0;
	    	    5'b10100: dE = -2;
	      	    5'b10101: dE =  0;
	      	    5'b10110: dE =  0;
	      	    5'b10111: dE =  2;
	  	    5'b11000: dE = -2;
	  	    5'b11001: dE =  0;
	  	    5'b11010: dE =  0;
	  	    5'b11011: dE =  2;
	  	    5'b11100: dE =  0;
	  	    5'b11101: dE =  2;
	  	    5'b11110: dE =  2;
	  	    5'b11111: dE =  4;	    
		    default: dE = 0;
	    endcase
	end

endmodule
