//                MANO Computer RTL Model             
//  						      
//  By: 					      
//      Ali Jahanian,				     
//      Shahid Beheshti University, 2012	      
//						      
//--------------------------------------------------------
`include "rtl/basic_params.v"


module dff (rst, clk, ld, d, q);
	input rst, clk, ld, d; 
	output q;
	reg temp;
	
	always @ (posedge clk)
		if (rst) 
			temp = 1'b0;
		else if (ld)
    		temp = d;
	
	assign q = temp;
endmodule 