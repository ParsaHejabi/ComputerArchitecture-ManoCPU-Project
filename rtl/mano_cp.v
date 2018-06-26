//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------
`include "rtl/basic_params.v"

module ctrlpath (	mrst, mclk, 
					// control signals of registers
					cs_ar_clr, cs_ir_clr, cs_pc_clr, cs_dr_clr, cs_ac_clr, cs_tr_clr, cs_inpr_clr, cs_outr_clr,
					cs_ar_inc, cs_ir_inc, cs_pc_inc, cs_dr_inc, cs_ac_inc, cs_tr_inc, cs_inpr_inc, cs_outr_inc,
					cs_ar_ld, cs_ir_ld,   cs_pc_ld,  cs_dr_ld,  cs_ac_ld,  cs_tr_ld,  cs_inpr_ld,  cs_outr_ld,
					// Control signals of flags
					cs_s_ld, cs_s_clr, cs_e_ld, cs_e_clr, cs_i_ld, cs_i_clr, 
					cs_fgi_ld, cs_fgi_clr, cs_fgo_ld, cs_fgo_clr, cs_r_ld, cs_r_clr, cs_ien_ld, cs_ien_clr,
					// Control signals of memory
					cs_mem_rd, cs_mem_wr,
					// Control signals of bus
					cs_bus_sel, 
					// Control signals of alu
					cs_alu_func, cs_alub_sel,
					// Data input of flags
					s_in, ien_in, fgi_in, fgo_in, r_in,
					// Cache hit signal
					cache_hit,
					// Registers & Flags to control path
					IR, 
					AC,
					DR,
					E,
					I,
					FGI,
					FGO,
					S,
					R,
					IEN,
					b_signal
					);
	input mclk, mrst;
	output cs_ar_clr, cs_ir_clr, cs_pc_clr, cs_dr_clr, cs_ac_clr, cs_tr_clr, cs_inpr_clr, cs_outr_clr;
	output cs_ar_inc, cs_ir_inc, cs_pc_inc, cs_dr_inc, cs_ac_inc, cs_tr_inc, cs_inpr_inc, cs_outr_inc;
	output cs_ar_ld,  cs_ir_ld,  cs_pc_ld,  cs_dr_ld,  cs_ac_ld,  cs_tr_ld,  cs_inpr_ld,  cs_outr_ld;
	output cs_s_ld, cs_s_clr, cs_e_ld,   cs_e_clr,   cs_i_ld,   cs_i_clr;
	output cs_fgi_ld, cs_fgi_clr, cs_fgo_ld, cs_fgo_clr, cs_r_ld, cs_r_clr, cs_ien_ld, cs_ien_clr;
	output cs_mem_rd, cs_mem_wr;
	output 	[`buswidth-1:0] cs_bus_sel;
	output 	[`funcwidth-1:0] cs_alu_func;
	output cs_alub_sel;
	output s_in, ien_in, fgi_in, fgo_in, r_in;
	reg    s_in, ien_in, fgi_in, fgo_in, r_in;
	input cache_hit;
	input [`datawidth-1:0] IR;
	input [`datawidth-1:0] AC;
	input [`datawidth-1:0] DR;
	input  E;
	input  I;
	input  FGI;
	input  FGO;
	input  S;
	input  R;
	input  IEN;
	reg [`buswidth-1:0] cs_bus_sel;
	reg [`funcwidth-1:0] cs_alu_func;
	reg cs_ar_clr, cs_ir_clr, cs_pc_clr, cs_dr_clr, cs_ac_clr, cs_tr_clr, cs_inpr_clr, cs_outr_clr;
	reg cs_ar_inc, cs_ir_inc, cs_pc_inc, cs_dr_inc, cs_ac_inc, cs_tr_inc, cs_inpr_inc, cs_outr_inc;
	reg cs_ar_ld,  cs_ir_ld,  cs_pc_ld,  cs_dr_ld,  cs_ac_ld,  cs_tr_ld,  cs_inpr_ld,  cs_outr_ld;
	reg cs_e_ld,   cs_e_clr,   cs_i_ld,   cs_i_clr,  cs_fgi_ld, cs_fgi_clr,cs_fgo_ld, cs_fgo_clr,cs_s_ld, cs_s_clr, cs_r_ld, cs_r_clr, cs_ien_ld, cs_ien_clr;
	reg cs_mem_rd, cs_mem_wr;
	reg cs_alub_sel;

	wire seq_clr;
	reg  seq_clr_t;
	wire [`seqwidth-1:0] T;
	wire [11:0] op;
	
	wire D0, D1, D2, D3, D4, D5, D6, D7;
	reg VDD = 1'b1;

	//NEW!!
	input b_signal;
	
	initial s_in = 1'b1;
	
	cntr   SEQ  (.rst(seq_clr), .en(VDD), .clk(mclk), .t(T));
	dcd3x8 DCD  (.a(IR[14:12]), .D0(D0),    .D1(D1), .D2(D2), .D3(D3), .D4(D4), .D5(D5), .D6(D6), .D7(D7));
	// Decoder multiplexer
	
	assign seq_clr = seq_clr_t | mrst;
	assign op = IR[11:0];
	// State machine
	always @(T, D0, D1, D2, D3, D4, D5, D6, D7, op, E, I, AC, DR, FGI, FGO, cache_hit)
	begin
		
			cs_ar_clr = 0;
			cs_ir_clr = 0;
			cs_pc_clr = 0;
			cs_dr_clr = 0;
			cs_ac_clr = 0;
			cs_tr_clr = 0;
			cs_inpr_clr = 0;
			cs_outr_clr = 0;
			cs_ar_inc = 0;
			cs_ir_inc = 0;
			cs_pc_inc = 0;
			cs_dr_inc = 0;
			cs_ac_inc = 0;
			cs_tr_inc = 0;
			cs_inpr_inc = 0;
			cs_outr_inc = 0;
			cs_ar_ld = 0;
			cs_pc_ld = 0;
			cs_dr_ld = 0;
			cs_ac_ld = 0;
			cs_tr_ld = 0;
			cs_tr_ld = 0;
			cs_tr_clr = 0;
			cs_inpr_ld = 0;
			cs_outr_ld = 0;
			cs_i_ld = 0;
			cs_i_clr = 0;
			cs_fgi_ld = 0;
			cs_fgi_clr = 0;
			cs_fgo_ld = 0;
			cs_fgo_clr = 0;
			cs_s_ld = 0;
			cs_s_clr = 0;
			cs_mem_wr = 0;
			cs_bus_sel = 3'b000;
			cs_alu_func = 3'b000;
			cs_alub_sel = 0;
			seq_clr_t = 0;
			r_in = 0;
			cs_r_ld = 0;
			cs_r_clr = 0;
			if (cache_hit == 1) begin
			VDD = 1'b1;
			cs_mem_rd = 0;
			cs_ir_ld = 0;
			case (T)
				`T0:  // AR <-- PC
				begin 
					if (s_in == 1)
						begin 
							cs_bus_sel = `BUS_PC; 
							cs_ar_ld = 1;
						end
					else
						seq_clr_t = 1;
				end
				`T1:  // IR <-- M[AR] , PC <-- PC + 1
				begin
				cs_mem_rd = 1; cs_ir_ld = 1; cs_bus_sel = `BUS_MEM; cs_pc_inc = 1; end
				`T2:  // AR <-- IR[12:0], I <-- IR[15]
				begin
				if (b_signal == 0) begin
					cs_ir_ld = 1;
				end
				cs_bus_sel = `BUS_IR; cs_i_ld = 1; cs_ar_ld = 1;
				end
				`T3:
				begin
					if (D7 == 0) // D7'.I.T3  Direct/Indirect
					begin
						if (I == 1 )
						begin
							cs_ar_ld = 1;
							cs_mem_rd = 1;
							cs_bus_sel = `BUS_MEM;
						end
					end
					else // if (D7 == 1)
					begin
						if (I == 0 ) // D7.I'.T3  : REGISTER instructions
						begin
							case (op)
								12'b100000000000 : begin cs_ac_clr = 1;  seq_clr_t = 1; end   // CLA
								12'b010000000000 : begin cs_e_clr = 1;  seq_clr_t = 1; end   // CLE
								12'b001000000000 : begin cs_alu_func = `CMA_FUNC; cs_ac_ld = 1;  seq_clr_t = 1; end   // CMA
								12'b000100000000 : begin cs_alu_func = `CME_FUNC; cs_e_ld = 1;  seq_clr_t = 1; end   // CME
								12'b000010000000 : begin cs_alu_func = `CIR_FUNC;  seq_clr_t = 1; end   // CIR
								12'b000001000000 : begin cs_alu_func = `CIL_FUNC;  seq_clr_t = 1; end   // CIL
								12'b000000100000 : begin cs_ac_inc = 1;  seq_clr_t = 1; end   // INC
								12'b000000010000 : begin if(AC[15] == 0) begin cs_pc_inc = 1; end seq_clr_t = 1; end   // SPA
								12'b000000001000 : begin if(AC[15] == 1) begin cs_pc_inc = 1; end seq_clr_t = 1; end   // SNA
								12'b000000000100 : begin if(AC == 0) begin cs_pc_inc = 1; end seq_clr_t = 1; end   // SZA
								12'b000000000010 : begin if(E == 0) begin cs_pc_inc = 1; end seq_clr_t = 1; end   // SZE
								12'b000000000001 : begin s_in = 1'b0; cs_s_ld=1; seq_clr_t = 1; end   // HLT
								default  		 : begin  end
							endcase
						end
						else          // D7.I.T3  : I/O instructions
						begin
							case (op)
								12'b000000000001 : begin cs_ac_ld = 1; cs_bus_sel = `BUS_INP; cs_fgi_clr = 1; seq_clr_t = 1; end   // INP
								12'b000000000010 : begin cs_outr_ld = 1; cs_bus_sel = `BUS_AC; cs_fgo_clr = 1; seq_clr_t = 1; end   // OUT
								12'b000000000100 : begin if (FGI == 1) begin cs_pc_inc = 1; end seq_clr_t = 1; end   // SKI
								12'b000000001000 : begin if (FGO == 1) begin cs_pc_inc = 1; end seq_clr_t = 1; end   // SKO
								12'b000000010000 : begin ien_in = 1'b1; cs_ien_ld = 1; seq_clr_t = 1; end   // ION
								12'b000000100000 : begin cs_ien_clr = 1; seq_clr_t = 1; end   // IOF
								default  		 : begin  end
							endcase                
						end
					end
				end
				`T4:
					if      (D0 == 1) begin  cs_dr_ld = 1; cs_bus_sel = `BUS_MEM; end  // DR <-- M[AR]  // AND
					else if (D1 == 1) begin  cs_dr_ld = 1; cs_bus_sel = `BUS_MEM; end  // DR <-- M[AR]  // ADD
					else if (D2 == 1) begin  cs_dr_ld = 1; cs_bus_sel = `BUS_MEM; end  // DR <-- M[AR]  // LDA
					else if (D3 == 1) begin  cs_mem_wr = 1; cs_bus_sel = `BUS_AC; seq_clr_t = 1; end  // M[AR] <-- AC , SC <-- 0  // STA
					else if (D4 == 1) begin  cs_pc_ld = 1; cs_bus_sel = `BUS_AR; seq_clr_t = 1; end  // PC <-- AR , SC <-- 0  // BUN
					else if (D5 == 1) begin  cs_mem_wr = 1; cs_bus_sel = `BUS_PC; cs_ar_inc = 1; end  // M[AR] <-- PC , AR <-- AR + 1  // BSA
					else if (D6 == 1) begin  cs_dr_ld = 1; cs_bus_sel = `BUS_MEM; end  // DR <-- M[AR]  // ISZ
				`T5:
					if      (D0 == 1) begin  cs_ac_ld = 1; cs_alu_func = `AND_FUNC; seq_clr_t = 1; end  // AC <-- DR  // AND
					else if (D1 == 1) begin  cs_ac_ld = 1; cs_alu_func = `ADD_FUNC; seq_clr_t = 1; end  // AC <-- AC + DR  // ADD
					else if (D2 == 1) begin  cs_ac_ld = 1; cs_alu_func = `PASSDR_FUNC; seq_clr_t = 1; end  // AC <-- DR , SC <-- 0  // LDA
					else if (D3 == 1) begin  end  // STA
					else if (D4 == 1) begin  end  // BUN
					else if (D5 == 1) begin  cs_pc_ld = 1; cs_bus_sel = `BUS_AR; seq_clr_t = 1; end  // PC <-- AR , SC <-- 0  // BSA
					else if (D6 == 1) begin  cs_dr_inc = 1; end // DR <-- DR + 1  // ISZ 
				`T6:		// M[AR] <-- DR , if(DR == 0) then PC <-- PC + 1 , SC <-- 0  // ISZ
				begin
					cs_mem_wr = 1;
					cs_bus_sel = `BUS_DR;
					if (DR == 0)
					begin
						cs_pc_inc = 1;
					end
					seq_clr_t = 1;
				end
				`T7:
				begin
					seq_clr_t = 1;
				end
				default:
				cs_ir_ld = 1;
			endcase
		end
		else 
		begin
			VDD = 1'b0;
			//cs_pc_inc=0;
		end
	end
endmodule