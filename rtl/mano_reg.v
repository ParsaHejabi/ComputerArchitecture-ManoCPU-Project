//                MANO Computer RTL Model             
//  						      
//  By: 					      
//      Ali Jahanian,				     
//      Shahid Beheshti University, 2012	      
//						      
//--------------------------------------------------------
`include "rtl/basic_params.v"

module register #(parameter width = 8)(rst, clk, ld, inc, d, q);
	input rst, clk, ld, inc;
	input [width-1:0] d; 
	output [width-1:0]q;
	
	reg [width-1:0] temp;
	
	always @ ( posedge clk)
		if (rst) 
			temp = 0;
		else if (inc)
    		temp = temp + 1;
		else if (ld)
    		temp = d;
	
	assign q  = temp;
endmodule 