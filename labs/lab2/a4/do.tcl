transcript on

vlib work

vlog -sv            countdown_timer.sv
vlog -sv +incdir+./ fsm.sv
vlog -sv +incdir+./ lights_control.sv
vlog -sv +incdir+./ traffic_light.sv
vlog -sv +incdir+./ tb.sv

vsim -t 1ns -voptargs="+acc" tb

add wave                                 tb/rst_i
add wave                                 tb/clk_i
add wave -color Red    -itemcolor Red    tb/red_o
add wave -color Yellow -itemcolor Yellow tb/yellow_o
add wave                                 tb/green_o
radix -noshowbase
configure wave -timelineunits us
run -all
wave zoom full
