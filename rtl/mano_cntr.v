//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------
`include "rtl/basic_params.v"

module cntr (rst, en, clk, t);
	input rst, clk, en;
	output 	[`seqwidth-1:0] t;
	reg 	[`seqwidth-1:0] cntr;
	
	always @(posedge clk)		
	begin
		if (rst)
			cntr = 0;
		else if (clk)
			if (en)
				cntr = cntr + 1;
				
	end
	assign t = cntr;
endmodule