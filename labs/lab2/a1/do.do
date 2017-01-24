transcript on

vlib work

vlog -sv +incdir+./ counter.sv
vlog -sv +incdir+./ top.sv
vlog -sv +incdir+./ tb.sv

vsim -t 1ns -voptargs="+acc" tb

add wave tb/rst_i
add wave tb/clk_i
add wave tb/preset_i
add wave -radix unsigned tb/msec_preset
add wave -radix unsigned tb/sec_preset
add wave -radix unsigned tb/min_preset
add wave -radix unsigned tb/hour_preset
add wave -radix unsigned tb/msec
add wave -radix unsigned tb/sec
add wave -radix unsigned tb/min
add wave -radix unsigned tb/hour

radix -noshowbase
run -all
wave zoom full
