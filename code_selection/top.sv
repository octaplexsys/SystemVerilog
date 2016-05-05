module top (
  input  logic            rst_i,
  input  logic            clk_1_i,
  input  logic            clk_2_i,
  input  logic [ 5 : 0 ]  data_i,
  input  logic            data_val_i,
  output logic [ 17 : 0 ] status_o
);
  
  logic busy;
  logic ser_data;
  
  serializer serial ( .*, .clk_i( clk_1_i ), .ser_data_o( ser_data ), .busy_o( busy ) );
  logic [ 4 : 0 ] address;
  logic           command;
  
  deserializer deserial ( rst_i, clk_2_i, busy, ser_data, address, command );
  
  object #( 1 )  obj_1  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[0]  ) );
  object #( 2 )  obj_2  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[1]  ) );
  object #( 3 )  obj_3  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[2]  ) );
  object #( 4 )  obj_4  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[3]  ) );
  object #( 5 )  obj_5  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[4]  ) );
  object #( 6 )  obj_6  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[5]  ) );
  object #( 7 )  obj_7  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[6]  ) );
  object #( 8 )  obj_8  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[7]  ) );
  object #( 9 )  obj_9  ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[8]  ) );
  object #( 10 ) obj_10 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[9]  ) );
  object #( 11 ) obj_11 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[10] ) );
  object #( 12 ) obj_12 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[11] ) );
  object #( 13 ) obj_13 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[12] ) );
  object #( 14 ) obj_14 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[13] ) );
  object #( 15 ) obj_15 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[14] ) );
  object #( 16 ) obj_16 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[15] ) );
  object #( 17 ) obj_17 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[16] ) );
  object #( 18 ) obj_18 ( .*, .clk_i( clk_2_i ), .address_i( address ), .command_i( command ), .status_o( status_o[17] ) );

endmodule
