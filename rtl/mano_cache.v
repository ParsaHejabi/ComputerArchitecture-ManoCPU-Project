//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------
`include "rtl/basic_params.v"

module dmc256x16 (	clr, 
					clk, 
					// CPU - Cache signals
					cpu_addr, cpu_rd, cpu_wr, cpu_din, cpu_dout, cache_hit, 
					// Cache - Memory signals
					mem_addr, mem_rd, mem_wr, mem_din, mem_dout);
	input 	clr;
	input 	clk;
	input 	cpu_rd;
	input 	cpu_wr;
	input	[`addrwidth-1:0] cpu_addr;
	input	[`datawidth-1:0] cpu_din ;  // CPU --> CACHE
	output	[`datawidth-1:0] cpu_dout;	// CACHE --> CPU
	reg  	[`datawidth-1:0] cpu_dout;
	output  cache_hit;
	reg     cache_hit;

	output 	mem_rd;
	output 	mem_wr;
	output	[`addrwidth-1:0] mem_addr;
	reg	    [`addrwidth-1:0] mem_addr;
	input	[`datawidth-1:0] mem_din ;  // MEM --> CACHE
	output	[`datawidth-1:0] mem_dout;  // CACHE --> MEM
	reg  	[`datawidth-1:0] mem_dout;

	always @(cpu_addr)
	begin
	cache_hit = 0;
	end
	 
endmodule
