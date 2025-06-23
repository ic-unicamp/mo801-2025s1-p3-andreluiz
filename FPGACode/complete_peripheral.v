module teste();

reg clk, reset;
reg enable_white, enable_grey;

reg lattice [31:0][31:0];
wire final_lattice [31:0][31:0];

integer counter;
wire [31:0] rand32;
integer k,l;
reg [31:0] mem[31:0];

/*Sfrl_32 rand32_mod(
	.clk(clk),
	.seed_val(counter[7:0]),
	.random(rand32)
);*/

initial begin
	enable_white = 1;
	enable_grey = 0;
	counter=0;
	$readmemb("memory.mem", mem, 0,31);
	
	for (k = 0; k < 32; k = k + 1)begin
	for (l = 0; l < 32; l = l + 1) begin
		lattice[k][l] = mem[k][l];
	end
	end
end

genvar i,j;
generate
    for (i = 0; i < 32; i = i + 1) begin
    for (j = 0; j < 32; j = j + 1) begin : spins_white  
    	if((i%2==0 & j%2==0) | (i%2!=0 & j%2!=0)) begin
		   Spin spin_inst(
		   	.clk(clk),
		   	.spin_val(lattice[i][j]), 
		   	.left(lattice[(i+31)%32][j]), // (i+-1+8)%8 --> se i=0, então 7%8 = 7. Se i>0. então i=3 --> 3-1+8=10 ---> 10%8 = 2
		   	.right(lattice[(i+1)%32][j]), 
		   	.top(lattice[i][(j+31)%32]),// (i+-1+8)%8 --> se i=0, então 7%8 = 7. Se i>0. então i=3 --> 3-1+8=10 ---> 10%8 = 2 
		   	.bottom(lattice[i][(j+1)%32]), 
		   	.rand32(rand32), 
		   	.enable(enable_white),
		   	.final_spin_val(final_lattice[i][j])
		   );
	   end
    end
    end
    for (i = 0; i < 32; i = i + 1) begin
    for (j = 0; j < 32; j = j + 1) begin : spins_grey   
    	if((i%2==0 & j%2!=0) | (i%2!=0 & j%2==0)) begin
		   Spin spin_inst(
   		   	.clk(clk),
		   	.spin_val(lattice[i][j]), 
		   	.left(lattice[(i+31)%32][j]), //(i+-1+8)%8 --> se i=0, então 7%8 = 7. Se i>0. então i=3 --> 3-1+8=10 ---> 10%8 = 2
		   	.right(lattice[(i+1)%32][j]), 
		   	.top(lattice[i][(j+31)%32]), //(i+-1+8)%8 --> se i=0, então 7%8 = 7. Se i>0. então i=3 --> 3-1+8=10 ---> 10%8 = 2
		   	.bottom(lattice[i][(j+1)%32]), 
		   	.rand32(rand32), 
		   	.enable(enable_grey),
		   	.final_spin_val(final_lattice[i][j])
		   );
	   end
    end
    end
endgenerate

always #1 clk = (clk===1'b0);

integer energy, spin_dir;

always @(posedge clk or posedge reset) begin
    if(counter<1000) begin
    	    //Update lattice
    	    if(counter > 1) begin
		    for (k = 0; k < 32; k = k + 1) begin
		    for (l = 0; l < 32; l = l + 1) begin  
			lattice[k][l] = final_lattice[k][l];
		    end
		    end 	    
    	    end
    	    
    	    //Alternate between white and grey set of lattices. This mechanism allows paralelism
	    if (reset) begin
		enable_white = 1;
		enable_grey = 0;
	    end else begin
		enable_white = ~enable_white;
		enable_grey  = ~enable_grey;
	    end 
	    counter++;
	    if(counter%4 == 0) begin
	    energy = 0;
    	    spin_dir = 0;
	    //Calculate hamiltonian
	    for (k = 0; k < 32; k = k + 1) begin
	    for (l = 0; l < 32; l = l + 1) begin  
	        
		energy += (-2*lattice[k][l]-1)*(
			(2*lattice[(k+31)%32][l]-1)+
		   	(2*lattice[(k+1)%32][l]-1)+ 
		   	(2*lattice[k][(l+31)%32]-1)+
		   	(2*lattice[k][(l+1)%32]-1));
	    end
	    end
    	    
    	    //Calculate spin avg dir
    	    for (k = 0; k < 32; k = k + 1) begin
	    for (l = 0; l < 32; l = l + 1) begin  
		spin_dir += 2*lattice[k][l]-1;
	    end
	    end
	    end
	    //Write in file
	    $write("%d,%.3f,%.3f\n",counter,energy,spin_dir*0.0009765625);
    		
    /*for (k = 0; k < 8; k = k + 1) begin
    for (l = 0; l < 8; l = l + 1) begin  
	$write("%d ",final_lattice[k][l]);
    end
        $write("\n");
    end
    $write("\n");*/
    
    end else begin
    	$finish;
    end
end
endmodule
