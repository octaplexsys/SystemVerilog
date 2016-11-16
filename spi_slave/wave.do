onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /spi_slave_tb/rst
add wave -noupdate /spi_slave_tb/clk
add wave -noupdate /spi_slave_tb/sck
add wave -noupdate /spi_slave_tb/cs
add wave -noupdate /spi_slave_tb/busy
add wave -noupdate /spi_slave_tb/cpol
add wave -noupdate /spi_slave_tb/cpha
add wave -noupdate /spi_slave_tb/msb_first
add wave -noupdate /spi_slave_tb/DUV/read_edge
add wave -noupdate /spi_slave_tb/mosi
add wave -noupdate /spi_slave_tb/DUV/i_buf
add wave -noupdate /spi_slave_tb/data_tx
add wave -noupdate /spi_slave_tb/DUV/shift_edge
add wave -noupdate /spi_slave_tb/miso
add wave -noupdate /spi_slave_tb/DUV/o_buf
add wave -noupdate /spi_slave_tb/data_rx
add wave -noupdate /spi_slave_tb/DUV/cs_negedge
add wave -noupdate /spi_slave_tb/DUV/cs_posedge
add wave -noupdate /spi_slave_tb/DUV/cs_sync_2
add wave -noupdate /spi_slave_tb/DUV/mosi_sync_2
add wave -noupdate -radix unsigned /spi_slave_tb/DUV/bit_counter
add wave -noupdate /spi_slave_tb/end_of_byte
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1572395 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 209
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {11647650 ps}
run -all
