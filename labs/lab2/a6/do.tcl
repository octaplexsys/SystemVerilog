transcript on

vlib work

vlog -sv zeros_ones_count.sv
vlog -sv tb.sv

vsim -t 1ns -voptargs="+acc" tb

add wave -radix binary   tb/data_i
add wave -radix unsigned tb/zeros_o
add wave -radix unsigned tb/ones_o
radix -noshowbase
configure wave -timelineunits us
run -all
wave zoom full
