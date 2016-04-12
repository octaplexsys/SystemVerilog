module top (
	input 	logic 				clk_i,
	input 	logic 				a_reset_i,
	input 	logic 				rx,
	input 	logic	[ 7 : 0 ]	tx_data,
	input	logic				tx_data_strobe,
	input	logic	[ 7 : 0 ]	settings,
	input	logic				settings_strobe,
	output 	logic 				tx,
	output	logic	[ 7 : 0 ]	rx_data,
	output	logic	[ 1 : 0 ]	irq
	);
	
	