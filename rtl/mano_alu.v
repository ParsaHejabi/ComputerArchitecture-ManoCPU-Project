//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------
`include "rtl/basic_params.v"

module alu (a, b, e_in, func, e_out, z);
	input [`datawidth-1:0] a;
	input [`datawidth-1:0] b;
	input e_in;	
	input [`funcwidth-1:0] 	func;
	output e_out;
	reg e_out;
	output [`datawidth-1:0] z;
	reg [`datawidth-1:0] z;
	
	reg temp_e;

	always @(a, b, func, e_in)		
	begin
		case (func)
			`CIL_FUNC : 
			begin
                z <= {b[`datawidth-2:0], e_in};
				e_out <= b[15];
			end
			`CIR_FUNC :
			begin
				z <= {e_in, b[`datawidth-1:1]};
				e_out <= b[0];
			end
			`CMA_FUNC :
				z <= ~b;
			`CME_FUNC :
				e_out <= ~e_in;
			`PASSB_FUNC :
				z <= b;
			`PASSDR_FUNC :
				z <= a;
			`AND_FUNC :
				z <= a & b;
			`ADD_FUNC :
				{e_out,z} <= a + b;
			default : // NO_FUNC
			begin
				z <= 0;
				e_out <= 0;
			end
		endcase
	end  // end of always
endmodule

	