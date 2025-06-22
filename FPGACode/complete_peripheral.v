module teste();

reg clk, reset;
reg enable_white, enable_grey;

wire lattice [7:0][7:0];
wire final_lattice [7:0][7:0];

integer counter;
wire [31:0] rand32;

initial begin

  $display("*** Starting simulation. ***");
  counter = 0;
end

Sfrl_32 rand32_mod(
	.clk(clk),
	.seed_val(counter[7:0]),
	.random(rand32)
);

genvar i,j;
generate
    for (i = 0; i < 8; i = i + 1) begin
    for (j = 0; j < 8; j = j + 1) begin : spins_white  
    	if((i%2==0 & j%2==0) | (i%2!=0 & j%2!=0)) begin
		   Spin spin_inst(
		   	.clk(clk),
		   	.spin_val(lattice[i][j]), 
		   	.left(lattice[(i+7)%8][j]), // (i+-1+8)%8 --> se i=0, então 7%8 = 7. Se i>0. então i=3 --> 3-1+8=10 ---> 10%8 = 2
		   	.right(lattice[(i+1)%8][j]), 
		   	.top(lattice[i][(j+7)%8]),// (i+-1+8)%8 --> se i=0, então 7%8 = 7. Se i>0. então i=3 --> 3-1+8=10 ---> 10%8 = 2 
		   	.bottom(lattice[i][(j+1)%8]), 
		   	.rand32(rand32), 
		   	.enable(enable_white),
		   	.final_spin_val(final_lattice[i][j])
		   );
	   end
    end
    end
    for (i = 0; i < 8; i = i + 1) begin
    for (j = 0; j < 8; j = j + 1) begin : spins_grey   
    	if((i%2==0 & j%2!=0) | (i%2!=0 & j%2==0)) begin
		   Spin spin_inst(
   		   	.clk(clk),
		   	.spin_val(lattice[i][j]), 
		   	.left(lattice[(i+7)%8][j]), //(i+-1+8)%8 --> se i=0, então 7%8 = 7. Se i>0. então i=3 --> 3-1+8=10 ---> 10%8 = 2
		   	.right(lattice[(i+1)%8][j]), 
		   	.top(lattice[i][(j+7)%8]), //(i+-1+8)%8 --> se i=0, então 7%8 = 7. Se i>0. então i=3 --> 3-1+8=10 ---> 10%8 = 2
		   	.bottom(lattice[i][(j+1)%8]), 
		   	.rand32(rand32), 
		   	.enable(enable_grey),
		   	.final_spin_val(final_lattice[i][j])
		   );
	   end
    end
    end
endgenerate

always #1 clk = (clk===1'b0);

always @(posedge clk or posedge reset) begin
    if(counter<20) begin
	    if (reset) begin
		enable_white = 1;
		enable_grey = 0;
	    end else begin
		enable_white = ~enable_white;
		enable_grey  = ~enable_grey;
	    end 
	    $display("%d",counter);
	    counter++;
    end else begin
    	$finish;
    end
end
endmodule
