module teste();

reg [7:0] mem[7:0];
integer k,l;

initial begin
  $display("*** Starting simulation. ***");
  $readmemb("memory.mem",mem,0,7);
  
  for (k = 0; k < 8; k = k + 1) begin
  for (l = 0; l < 8; l = l + 1) begin
	$write("%b-",mem[k][l]);
	//lattice[k][l] = mem[l][k];
  end 
  	$write("\n");
  end

end

endmodule
