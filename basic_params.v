//  MANO Computer RTL Model             
//  Ali Jahanian,				     
//  Shahid Beheshti University, 2017	      
//--------------------------------------------------------

// main parameters
`define datawidth 	16
`define addrwidth 	12
`define iowidth 	8
`define funcwidth 	4
`define memcap		4096
`define buswidth	3
`define seqwidth	3

// cache
// NEW!!
`define cachecap    256
`define cachewidth  22

// ALU functions
`define NO_FUNC		4'b0000
`define CIL_FUNC 	4'b0001
`define CIR_FUNC 	4'b0010
`define CMA_FUNC 	4'b0011
`define CME_FUNC 	4'b0100
`define PASSB_FUNC 	4'b0101
`define PASSDR_FUNC 4'b0110
`define AND_FUNC 	4'b0111
`define ADD_FUNC 	4'b1000

// BUS Selector
`define BUS_MEM		3'b000
`define BUS_AR  	3'b001
`define BUS_PC  	3'b010
`define BUS_DR		3'b011
`define BUS_AC 	 	3'b100
`define BUS_INP 	3'b101
`define BUS_IR 		3'b110
`define BUS_TR 		3'b111

// Instruction Cycles
`define T0			3'b000
`define T1  		3'b001
`define T2  		3'b010
`define T3			3'b011
`define T4 	 		3'b100
`define T5	 		3'b101
`define T6 			3'b110
`define T7 			3'b111