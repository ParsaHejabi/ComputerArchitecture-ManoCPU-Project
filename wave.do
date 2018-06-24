onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/mclk
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/mrst
add wave -noupdate -divider REGS
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/DP/PC
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/CP/IR
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/DP/AR
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/DP/DR
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/DP/AC
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/DP/TR
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/DP/INPR
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/DP/OUTR
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/DP/IR
add wave -noupdate -divider FLAGS
add wave -noupdate -format Logic /mano_core_tb/CORE/DP/E
add wave -noupdate -format Logic /mano_core_tb/CORE/DP/I
add wave -noupdate -format Logic /mano_core_tb/CORE/DP/FGI
add wave -noupdate -format Logic /mano_core_tb/CORE/DP/FGO
add wave -noupdate -format Logic /mano_core_tb/CORE/DP/S
add wave -noupdate -divider {CNTRL SIGNALS}
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/CP/T
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/CP/cs_bus_sel
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/CP/cs_alu_func
add wave -noupdate -format Literal -radix hexadecimal /mano_core_tb/CORE/CP/op
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/D0
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/D1
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/D2
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/D3
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/D4
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/D5
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/D6
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/D7
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ar_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ir_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_pc_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_dr_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ac_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_tr_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_inpr_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_outr_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ar_inc
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ir_inc
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_pc_inc
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_dr_inc
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ac_inc
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_tr_inc
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_inpr_inc
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_outr_inc
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ar_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ir_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_pc_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_dr_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_ac_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_tr_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_inpr_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_outr_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_i_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_i_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_fgi_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_fgi_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_fgo_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_fgo_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_s_ld
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_s_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_mem_rd
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_mem_wr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/cs_alub_sel
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/seq_clr
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/seq_clr_t
add wave -noupdate -format Literal /mano_core_tb/CORE/DP/alua
add wave -noupdate -format Literal /mano_core_tb/CORE/DP/alub
add wave -noupdate -format Literal /mano_core_tb/CORE/DP/aluout
add wave -noupdate -format Logic /mano_core_tb/CORE/s_flag
add wave -noupdate -format Logic /mano_core_tb/CORE/CP/s_in
add wave -noupdate -divider CACHE
add wave -noupdate -format Logic /mano_core_tb/CORE/DP/cache_hit
add wave -noupdate -format Logic /mano_core_tb/CORE/DP/CACHE/mem_rd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {425 ns} 0}
configure wave -namecolwidth 221
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {3150 ns}
