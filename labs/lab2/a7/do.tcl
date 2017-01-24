transcript on

vlib work

vlog -sv debounce.sv
vlog -sv tb.sv

vsim -t 1ns -voptargs="+acc" tb

add wave tb/clk_i
add wave tb/key_i
add wave tb/key_pressed_stb_o
radix -noshowbase
configure wave -timelineunits us
run -all
wave zoom full
