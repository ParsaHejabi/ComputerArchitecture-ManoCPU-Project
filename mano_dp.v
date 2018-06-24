//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------
`include "rtl/basic_params.v"


module datapath (	mrst, mclk, 
					// control signals of registers
					cs_ar_clr, cs_ir_clr, cs_pc_clr, cs_dr_clr, cs_ac_clr, cs_tr_clr, cs_inpr_clr, cs_outr_clr,
					cs_ar_inc, cs_ir_inc, cs_pc_inc, cs_dr_inc, cs_ac_inc, cs_tr_inc, cs_inpr_inc, cs_outr_inc,
					cs_ar_ld, cs_ir_ld,   cs_pc_ld,  cs_dr_ld,  cs_ac_ld,  cs_tr_ld,  cs_inpr_ld,  cs_outr_ld,
					// control signals of flags
					cs_s_ld, cs_s_clr, cs_e_ld, cs_e_clr, cs_i_ld, cs_i_clr, 
					cs_fgi_ld, cs_fgi_clr, cs_fgo_ld, cs_fgo_clr, cs_r_ld, cs_r_clr, cs_ien_ld, cs_ien_clr,
					// control signals of memory
					cs_mem_rd, cs_mem_wr,
					// control signals of bus
					cs_bus_sel, 
					// control signals of ALU
					cs_alu_func, cs_alub_sel,
					// Data input of flags
					s_in, ien_in, fgi_in, fgo_in, r_in,
					// cache hit signal
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
					IEN
					);
	input mclk, mrst;
	input cs_ar_clr, cs_ir_clr, cs_pc_clr, cs_dr_clr, cs_ac_clr, cs_tr_clr, cs_inpr_clr, cs_outr_clr;
	input cs_ar_inc, cs_ir_inc, cs_pc_inc, cs_dr_inc, cs_ac_inc, cs_tr_inc, cs_inpr_inc, cs_outr_inc;
	input cs_ar_ld,  cs_ir_ld,  cs_pc_ld,  cs_dr_ld,  cs_ac_ld,  cs_tr_ld,  cs_inpr_ld,  cs_outr_ld;
	input cs_s_ld, cs_s_clr, cs_e_ld, cs_e_clr,  cs_i_ld,  cs_i_clr;
	input cs_fgi_ld, cs_fgi_clr,cs_fgo_ld, cs_fgo_clr, cs_r_ld, cs_r_clr, cs_ien_ld, cs_ien_clr;
	input cs_mem_rd, cs_mem_wr;
	input s_in, ien_in, fgi_in, fgo_in, r_in;
	input [`buswidth-1:0] cs_bus_sel;
	input [`funcwidth-1:0] cs_alu_func;
	input cs_alub_sel;
	output cache_hit;
	output [`datawidth-1:0] IR;
	output [`datawidth-1:0] AC;
	output [`datawidth-1:0] DR;
	output E;
	output I;
	output FGI;
	output FGO;
	output S;
	output R;
	output IEN;
	// Registers and flags
	wire [`datawidth-1:0] alua, alub, aluout;
	wire [`iowidth-1:0] inprin;

	wire [`datawidth-1:0] TR;
	wire [`addrwidth-1:0] AR, PC;
	wire [`iowidth-1:0] INPR, OUTR;
	wire [`datawidth-1:0] memout, cache_cpu_dout, cache_mem_dout;
	reg [`datawidth-1:0] busout;
	wire [`addrwidth-1:0]  cache_mem_addr;

	assign cs_ar_clr_t   = cs_ar_clr   | mrst;
	assign cs_ir_clr_t   = cs_ir_clr   | mrst;
	assign cs_pc_clr_t   = cs_pc_clr   | mrst;
	assign cs_dr_clr_t   = cs_dr_clr   | mrst;
	assign cs_ac_clr_t   = cs_ac_clr   | mrst;
	assign cs_tr_clr_t   = cs_tr_clr   | mrst;
	assign cs_inpr_clr_t = cs_inpr_clr | mrst;
	assign cs_outr_clr_t = cs_outr_clr | mrst;
	assign cs_e_clr_t    = cs_e_clr    | mrst;
	assign cs_i_clr_t    = cs_i_clr    | mrst;
	assign cs_fgi_clr_t  = cs_fgi_clr  | mrst;
	assign cs_fgo_clr_t  = cs_fgo_clr  | mrst;
	assign cs_s_clr_t    = cs_s_clr    | mrst;
	
	// Components
	register 	   #(.width(`addrwidth)) AR_R   (.clk(mclk), .rst(cs_ar_clr_t),   .ld(cs_ar_ld),   .inc(cs_ar_inc),   .d(busout[11:0]), .q(AR) );	
	register 	   #(.width(`datawidth)) IR_R   (.clk(mclk), .rst(cs_ir_clr_t),   .ld(cs_ir_ld),   .inc(cs_ir_inc),   .d(busout),       .q(IR) );
	register 	   #(.width(`addrwidth)) PC_R   (.clk(mclk), .rst(cs_pc_clr_t),   .ld(cs_pc_ld),   .inc(cs_pc_inc),   .d(busout[11:0]), .q(PC) );
	register 	   #(.width(`datawidth)) DR_R   (.clk(mclk), .rst(cs_dr_clr_t),   .ld(cs_dr_ld),   .inc(cs_dr_inc),   .d(busout),       .q(DR) );
	register 	   #(.width(`datawidth)) AC_R   (.clk(mclk), .rst(cs_ac_clr_t),   .ld(cs_ac_ld),   .inc(cs_ac_inc),   .d(aluout),       .q(AC) );
	register 	   #(.width(`datawidth)) TR_R   (.clk(mclk), .rst(cs_tr_clr_t),   .ld(cs_tr_ld),   .inc(cs_tr_inc),   .d(busout),       .q(TR) );
	register 	   #(.width(`iowidth))   INPR_R (.clk(mclk), .rst(cs_inpr_clr_t), .ld(cs_inpr_ld), .inc(cs_inpr_inc), .d(inprin),       .q(INPR) );
	register 	   #(.width(`iowidth))   OUTR_R (.clk(mclk), .rst(cs_outr_clr_t), .ld(cs_outr_ld), .inc(cs_outr_inc), .d(busout[7:0]),  .q(OUTR) );
	dff E_F   		(.clk(mclk), .rst(cs_e_clr_t),   .ld(cs_e_ld),   .d(alu_e_out), .q(E) );
	dff I_F   		(.clk(mclk), .rst(cs_i_clr_t),   .ld(cs_i_ld),   .d(IR[15]),    .q(I) );
	dff FGI_F 		(.clk(mclk), .rst(cs_fgi_clr_t), .ld(cs_fgi_ld), .d(fgi_in),    .q(FGI) );
	dff FGO_F 		(.clk(mclk), .rst(cs_fgo_clr_t), .ld(cs_fgo_ld), .d(fgo_in),    .q(FGO) );
	dff R_F   		(.clk(mclk), .rst(cs_r_clr_t),   .ld(cs_r_ld),   .d(r_in),      .q(R) );
	dff S_F   		(.clk(mclk), .rst(cs_s_clr_t),   .ld(cs_s_ld),   .d(s_in),      .q(S) );
	dff IEN_F 		(.clk(mclk), .rst(cs_ien_clr_t), .ld(cs_ien_ld), .d(ien_in),    .q(IEN) );
	dmc256x16 CACHE (	.clk(mclk), 
						.clr(mrst), 
						.cpu_addr(AR), 
						.cpu_rd(cs_mem_rd), 
						.cpu_wr(cs_mem_wr), 
						.cpu_din(busout), 
						.cpu_dout(cache_cpu_dout), 
						.cache_hit(cache_hit),
						.mem_addr(cache_mem_addr), 
						.mem_rd(cache_mem_rd), 
						.mem_wr(cache_mem_wr), 
						.mem_din(memout), 
						.mem_dout(cache_mem_dout)
					);

	mem4096x16 MEM  (	.clk(mclk), 
						.addr(cache_mem_addr), 
						.rd(cache_mem_rd), 
						.wr(cache_mem_wr), 
						.din(cache_mem_dout), 
						.dout(memout)
					);
	alu ALU (.a(alua), .b(alub), .e_in(E), .func(cs_alu_func), .e_out(alu_e_out), .z(aluout));
	                                                                      
	// BUS Multiplexer                                                    
	always @(cs_bus_sel)                                                  
		case(cs_bus_sel)                                                  
			`BUS_MEM : busout <= memout;                                  
			`BUS_AR  : busout <= AR;                                      
			`BUS_PC  : busout <= PC;                                      
			`BUS_DR  : busout <= DR;                                      
			`BUS_AC  : busout <= AC;                                      
			`BUS_INP : busout <= INPR;                                    
			`BUS_IR  : busout <= IR;                                      
			default  : busout <= TR;                                      
		endcase                                                           
		                                                                  
	assign alua = DR;                                                     
	assign alub = (cs_alub_sel) ? {8'b00000000,INPR} : AC;                
endmodule                                                                 