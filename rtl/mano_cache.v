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

	// NEW!!
	reg [`cachewidth-1:0] cacheBank [0:`cachecap-1];
	reg [`cachewidth-1:0] zero = 0;

	reg [7:0] offset;
	reg [3:0] tag;
	reg [21:0] selectedRow;

	reg mem_rd_reg;
	reg mem_wr_reg;

	integer i;

	initial
	begin
		cache_hit = 1;
		for (i = 0; i < `cachewidth; i = i+1) begin
			cacheBank[i] = zero;
		end
	end

	always @(cpu_addr)
	begin
		if (cpu_rd == 1) begin
			offset = cpu_addr[7:0];
			tag = cpu_addr[11:8];
			selectedRow = cacheBank[offset];
			if (selectedRow[0] == 1) begin
				// VALID bit is 1 so data is VALID!
				if (tag == selectedRow[5:2]) begin
					cache_hit = 1;
					cpu_dout = selectedRow[21:6];
				end
				else begin
					cache_hit = 0;
					mem_addr = cpu_addr;
					mem_rd_reg = 1'b1;
					selectedRow[21:6] = mem_din;
					selectedRow[5:2] = tag;
					selectedRow[1] = 0;
					selectedRow[0] = 1;
					cpu_dout = selectedRow[21:6];
				end
			end
			else begin
				// VALID bit is 0 so data is NOT VALID!
				cache_hit = 0;
				mem_addr = cpu_addr;
				mem_rd_reg = 1'b1;
				selectedRow[21:6] = mem_din;
				selectedRow[5:2] = tag;
				selectedRow[1] = 0;
				selectedRow[0] = 1;
				cpu_dout = selectedRow[21:6];
			end
			cache_hit = 1;
		end
	end

	assign mem_rd = mem_rd_reg;

	reg [7:0] offsetIncoming;
	reg [3:0] tagIncoming;
	reg [21:0] selectedRow2;
	reg [21:0] rowToWrite;

	always @(posedge clk)
	begin
		if(cpu_wr == 1) begin
			offsetIncoming = cpu_addr[7:0];
			tagIncoming = cpu_addr[11:8];
			selectedRow2 = cacheBank[offsetIncoming];
			if (selectedRow2[0] == 1) begin
				if (selectedRow2[1] == 1) begin
					mem_wr_reg = 1'b1;
					mem_addr[11:8] = selectedRow[5:2];
					mem_addr[7:0] = offsetIncoming;
					mem_dout = selectedRow[21:6];
					rowToWrite[1] = 0;
				end
			end
			rowToWrite[21:6] = cpu_din;
			rowToWrite[5:2] = tag;
			rowToWrite[1] = 1;
			rowToWrite[0] = 1;
			cacheBank[offset] = rowToWrite;
		end
	end

	assign mem_wr = mem_wr_reg;
endmodule