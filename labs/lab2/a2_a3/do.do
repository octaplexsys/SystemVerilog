transcript on

if {[file exists work]} {
    vdel -lib work -all
}
vlib work

vlog -sv serial.sv
vlog -sv deserial.sv
vlog -sv tb.sv

vsim -t 1ns -voptargs="+acc" tb

add wave                    tb/rst_i
add wave                    tb/clk_i
add wave -radix hexadecimal tb/data_i
add wave -radix unsigned    tb/data_mod_i
add wave                    tb/data_val_i
add wave                    tb/ser_data
add wave                    tb/ser_data_val
add wave                    tb/busy
add wave -radix binary      tb/DUT_serial/data
add wave -radix unsigned    tb/DUT_serial/data_mod
add wave                    tb/DUT_deserial/status
add wave -radix unsigned    tb/DUT_deserial/current_bit
add wave -radix hexadecimal tb/data_o
add wave -radix unsigned    tb/data_mod_o
add wave                    tb/data_val_o
radix -noshowbase
configure wave -timelineunits us
run -all
wave zoom full
