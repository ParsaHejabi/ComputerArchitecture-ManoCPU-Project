//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------
`include "rtl/basic_params.v"

module mano_core_tb ();
	
	reg clk, rst;
	
	mano_core CORE (.mclk(clk), .mrst(rst));
	
	initial
	begin
		clk = 1'b0;
		rst = 1'b1;
		#120 rst = 1'b0;
	end
	
	always
		#10 clk = ~clk;

endmodule