//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------
`include "rtl/basic_params.v"

module dcd3x8 (a, D0, D1, D2, D3, D4, D5, D6, D7);
	input [2:0] a;
	output D0, D1, D2, D3, D4, D5, D6, D7;
	reg    D0, D1, D2, D3, D4, D5, D6, D7;

	always @(a)
	case (a)
		3'b000 : 
			begin
				D0 = 1; D1 = 0; D2 = 0; D3 = 0; D4 = 0; D5 = 0; D6 = 0; D7 = 0;
			end
		3'b001 : 
			begin
				D0 = 0; D1 = 1; D2 = 0; D3 = 0; D4 = 0; D5 = 0; D6 = 0; D7 = 0;
			end
		3'b010 : 
			begin
				D0 = 0; D1 = 0; D2 = 1; D3 = 0; D4 = 0; D5 = 0; D6 = 0; D7 = 0;
			end
		3'b011 : 
			begin
				D0 = 0; D1 = 0; D2 = 0; D3 = 1; D4 = 0; D5 = 0; D6 = 0; D7 = 0;
			end
		3'b100 : 
			begin
				D0 = 0; D1 = 0; D2 = 0; D3 = 0; D4 = 1; D5 = 0; D6 = 0; D7 = 0;
			end
		3'b101 : 
			begin
				D0 = 0; D1 = 0; D2 = 0; D3 = 0; D4 = 0; D5 = 1; D6 = 0; D7 = 0;
			end
		3'b110 : 
			begin
				D0 = 0; D1 = 0; D2 = 0; D3 = 0; D4 = 0; D5 = 0; D6 = 1; D7 = 0;
			end
		default : 
			begin
				D0 = 0; D1 = 0; D2 = 0; D3 = 0; D4 = 0; D5 = 0; D6 = 0; D7 = 1;
			end
	endcase
endmodule

	