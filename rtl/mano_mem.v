//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------
`include "rtl/basic_params.v"

module mem4096x16 (clk, addr, rd, wr, din, dout);
	input 	clk;
	input 	rd;
	input 	wr;
	input	[`addrwidth-1:0] addr;
	input	[`datawidth-1:0] din ;
	output	[`datawidth-1:0] dout;
	reg  	[`datawidth-1:0] dout;

	reg [`datawidth-1:0] bank [0:`memcap-1];
	
	always @(addr)
		dout = bank[addr];
		
    always @(posedge clk)
		if (wr == 1)
			bank[addr] = din;
	
	
	initial
		$readmemb("prog.asm",bank);
 
endmodule
