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
// CREATED		"Thu Apr 14 01:52:13 2016"

module top(
	ext_carry,
	a,
	b,
	eq,
	smaller,
	greather
);


input wire	ext_carry;
input wire	[3:0] a;
input wire	[3:0] b;
output wire	eq;
output wire	smaller;
output wire	greather;

wire	SYNTHESIZED_WIRE_46;
wire	SYNTHESIZED_WIRE_47;
wire	SYNTHESIZED_WIRE_48;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_49;
wire	SYNTHESIZED_WIRE_50;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_51;
wire	SYNTHESIZED_WIRE_52;
wire	SYNTHESIZED_WIRE_53;
wire	SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_29;
wire	SYNTHESIZED_WIRE_31;
wire	SYNTHESIZED_WIRE_32;
wire	SYNTHESIZED_WIRE_33;
wire	SYNTHESIZED_WIRE_34;
wire	SYNTHESIZED_WIRE_35;
wire	SYNTHESIZED_WIRE_36;
wire	SYNTHESIZED_WIRE_37;
wire	SYNTHESIZED_WIRE_54;
wire	SYNTHESIZED_WIRE_41;
wire	SYNTHESIZED_WIRE_42;
wire	SYNTHESIZED_WIRE_43;
wire	SYNTHESIZED_WIRE_45;

assign	eq = SYNTHESIZED_WIRE_54;



assign	SYNTHESIZED_WIRE_43 = a[0] & SYNTHESIZED_WIRE_46;

assign	SYNTHESIZED_WIRE_41 = a[0] & ext_carry;

assign	SYNTHESIZED_WIRE_7 = a[1] & SYNTHESIZED_WIRE_47;

assign	SYNTHESIZED_WIRE_5 = a[1] & SYNTHESIZED_WIRE_48;

assign	SYNTHESIZED_WIRE_6 = SYNTHESIZED_WIRE_47 & SYNTHESIZED_WIRE_48;

assign	SYNTHESIZED_WIRE_50 = SYNTHESIZED_WIRE_5 | SYNTHESIZED_WIRE_6 | SYNTHESIZED_WIRE_7;

assign	SYNTHESIZED_WIRE_9 = a[1] ^ SYNTHESIZED_WIRE_47;

assign	SYNTHESIZED_WIRE_32 = SYNTHESIZED_WIRE_9 ^ SYNTHESIZED_WIRE_48;

assign	SYNTHESIZED_WIRE_17 = a[2] & SYNTHESIZED_WIRE_49;

assign	SYNTHESIZED_WIRE_15 = a[2] & SYNTHESIZED_WIRE_50;

assign	SYNTHESIZED_WIRE_16 = SYNTHESIZED_WIRE_49 & SYNTHESIZED_WIRE_50;

assign	SYNTHESIZED_WIRE_52 = SYNTHESIZED_WIRE_15 | SYNTHESIZED_WIRE_16 | SYNTHESIZED_WIRE_17;

assign	SYNTHESIZED_WIRE_42 = SYNTHESIZED_WIRE_46 & ext_carry;

assign	SYNTHESIZED_WIRE_20 = a[2] ^ SYNTHESIZED_WIRE_49;

assign	SYNTHESIZED_WIRE_33 = SYNTHESIZED_WIRE_20 ^ SYNTHESIZED_WIRE_50;

assign	SYNTHESIZED_WIRE_37 = a[3] & SYNTHESIZED_WIRE_51;

assign	SYNTHESIZED_WIRE_35 = a[3] & SYNTHESIZED_WIRE_52;

assign	greather = SYNTHESIZED_WIRE_53 & SYNTHESIZED_WIRE_25;

assign	SYNTHESIZED_WIRE_36 = SYNTHESIZED_WIRE_51 & SYNTHESIZED_WIRE_52;

assign	SYNTHESIZED_WIRE_29 = a[3] ^ SYNTHESIZED_WIRE_51;

assign	SYNTHESIZED_WIRE_31 = SYNTHESIZED_WIRE_29 ^ SYNTHESIZED_WIRE_52;

assign	SYNTHESIZED_WIRE_54 = ~(SYNTHESIZED_WIRE_31 | SYNTHESIZED_WIRE_32 | SYNTHESIZED_WIRE_33 | SYNTHESIZED_WIRE_34);

assign	SYNTHESIZED_WIRE_53 = SYNTHESIZED_WIRE_35 | SYNTHESIZED_WIRE_36 | SYNTHESIZED_WIRE_37;

assign	smaller = ~(SYNTHESIZED_WIRE_54 | SYNTHESIZED_WIRE_53);

assign	SYNTHESIZED_WIRE_51 =  ~b[3];

assign	SYNTHESIZED_WIRE_25 =  ~SYNTHESIZED_WIRE_54;

assign	SYNTHESIZED_WIRE_49 =  ~b[2];

assign	SYNTHESIZED_WIRE_47 =  ~b[1];

assign	SYNTHESIZED_WIRE_46 =  ~b[0];

assign	SYNTHESIZED_WIRE_48 = SYNTHESIZED_WIRE_41 | SYNTHESIZED_WIRE_42 | SYNTHESIZED_WIRE_43;

assign	SYNTHESIZED_WIRE_45 = a[0] ^ SYNTHESIZED_WIRE_46;

assign	SYNTHESIZED_WIRE_34 = SYNTHESIZED_WIRE_45 ^ ext_carry;


endmodule
