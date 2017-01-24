transcript on

vlib work

vlog -sv corner_ones.sv
vlog -sv tb.sv

vsim -t 1ns -voptargs="+acc" tb

add wave -radix binary tb/data_i
add wave -radix binary tb/left_o
add wave -radix binary tb/right_o
radix -noshowbase
configure wave -timelineunits us
run -all
wave zoom full
