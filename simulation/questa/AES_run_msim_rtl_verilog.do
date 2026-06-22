transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog  -work altera_ver {/home/kloub/altera_lite/25.1std/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog  -work lpm_ver {/home/kloub/altera_lite/25.1std/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog  -work sgate_ver {/home/kloub/altera_lite/25.1std/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog  -work altera_mf_ver {/home/kloub/altera_lite/25.1std/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {/home/kloub/altera_lite/25.1std/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/fiftyfivenm_ver
vmap fiftyfivenm_ver ./verilog_libs/fiftyfivenm_ver
vlog  -work fiftyfivenm_ver {/home/kloub/altera_lite/25.1std/quartus/eda/sim_lib/fiftyfivenm_atoms.v}
vlog  -work fiftyfivenm_ver {/home/kloub/altera_lite/25.1std/quartus/eda/sim_lib/mentor/fiftyfivenm_atoms_ncrypt.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/rtl {/home/kloub/Desktop/PersonalProject/AES/rtl/AES.sv}
vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/rtl {/home/kloub/Desktop/PersonalProject/AES/rtl/keyExpansion.sv}
vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/rtl {/home/kloub/Desktop/PersonalProject/AES/rtl/mixCol.sv}
vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/rtl {/home/kloub/Desktop/PersonalProject/AES/rtl/shiftRow.sv}
vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/rtl {/home/kloub/Desktop/PersonalProject/AES/rtl/subBytes.sv}
vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/rtl {/home/kloub/Desktop/PersonalProject/AES/rtl/aesRound.sv}
vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/rtl {/home/kloub/Desktop/PersonalProject/AES/rtl/aesFinalRound.sv}
vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/rtl {/home/kloub/Desktop/PersonalProject/AES/rtl/addRoundKey.sv}

vlog -sv -work work +incdir+/home/kloub/Desktop/PersonalProject/AES/dv {/home/kloub/Desktop/PersonalProject/AES/dv/tb_AES.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  tb_AES

add wave *
view structure
view signals
run -all
