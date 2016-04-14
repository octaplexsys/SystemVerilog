// Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 15.1.0 Build 185 10/21/2015 SJ Standard Edition"
// CREATED		"Thu Apr 14 02:38:26 2016"

module top(
	rst_i,
	preload_i,
	clk_i,
	inc_i,
	reverse_i,
	counter
);


input wire	rst_i;
input wire	preload_i;
input wire	clk_i;
input wire	inc_i;
input wire	reverse_i;
output reg	[3:0] counter;

wire	nrst;
wire	counter_3;
wire	counter_2;
wire	carry_0;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	carry_1;
wire	counter_33;
wire	counter_34;
wire	counter_35;
wire	counter_1;
wire	counter_38;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_21;
wire	counter_0;






always@(posedge clk_i or negedge nrst or negedge preload_i)
begin
if (!nrst)
	begin
	counter[3] <= 0;
	end
else
if (!preload_i)
	begin
	counter[3] <= 1;
	end
else
	begin
	counter[3] <= counter_3;
	end
end


always@(posedge clk_i or negedge nrst or negedge preload_i)
begin
if (!nrst)
	begin
	counter[2] <= 0;
	end
else
if (!preload_i)
	begin
	counter[2] <= 1;
	end
else
	begin
	counter[2] <= counter_2;
	end
end

assign	SYNTHESIZED_WIRE_8 = reverse_i & counter[1];

assign	SYNTHESIZED_WIRE_6 = reverse_i & carry_0;

assign	SYNTHESIZED_WIRE_7 = counter[1] & carry_0;

assign	carry_1 = SYNTHESIZED_WIRE_6 | SYNTHESIZED_WIRE_7 | SYNTHESIZED_WIRE_8;

assign	SYNTHESIZED_WIRE_9 = counter[1] ^ reverse_i;

assign	counter_1 = SYNTHESIZED_WIRE_9 ^ carry_0;

assign	counter_35 = counter[2] & reverse_i;

assign	counter_33 = counter[2] & carry_1;

assign	counter_34 = reverse_i & carry_1;

assign	SYNTHESIZED_WIRE_21 = counter_33 | counter_34 | counter_35;


always@(posedge clk_i or negedge nrst or negedge preload_i)
begin
if (!nrst)
	begin
	counter[1] <= 0;
	end
else
if (!preload_i)
	begin
	counter[1] <= 1;
	end
else
	begin
	counter[1] <= counter_1;
	end
end

assign	counter_38 = counter[2] ^ reverse_i;

assign	counter_2 = counter_38 ^ carry_1;

assign	SYNTHESIZED_WIRE_20 = counter[3] ^ reverse_i;

assign	counter_3 = SYNTHESIZED_WIRE_20 ^ SYNTHESIZED_WIRE_21;


always@(posedge clk_i or negedge nrst or negedge preload_i)
begin
if (!nrst)
	begin
	counter[0] <= 0;
	end
else
if (!preload_i)
	begin
	counter[0] <= 1;
	end
else
	begin
	counter[0] <= counter_0;
	end
end

assign	nrst =  ~rst_i;

assign	carry_0 = counter[0] & inc_i;

assign	counter_0 = counter[0] ^ inc_i;


endmodule
