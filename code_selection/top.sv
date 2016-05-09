module top (
  input  logic            rst_i,
  input  logic            clk_i,
  input  logic [ 5 : 0 ]  data_i,
  input  logic            data_val_i,
  output logic [ 17 : 0 ] status_o
);
  
  logic busy;
  logic ser_data;
  
  serializer serial ( .*, .ser_data_o( ser_data ), .busy_o( busy ) );
  logic [ 4 : 0 ] address;
  logic           command;
  
  deserializer deserial ( rst_i, clk_i, busy, ser_data, address, command );
  
  object #( 1 )  obj_1  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[0]  ) );
  object #( 2 )  obj_2  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[1]  ) );
  object #( 3 )  obj_3  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[2]  ) );
  object #( 4 )  obj_4  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[3]  ) );
  object #( 5 )  obj_5  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[4]  ) );
  object #( 6 )  obj_6  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[5]  ) );
  object #( 7 )  obj_7  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[6]  ) );
  object #( 8 )  obj_8  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[7]  ) );
  object #( 9 )  obj_9  ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[8]  ) );
  object #( 10 ) obj_10 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[9]  ) );
  object #( 11 ) obj_11 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[10] ) );
  object #( 12 ) obj_12 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[11] ) );
  object #( 13 ) obj_13 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[12] ) );
  object #( 14 ) obj_14 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[13] ) );
  object #( 15 ) obj_15 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[14] ) );
  object #( 16 ) obj_16 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[15] ) );
  object #( 17 ) obj_17 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[16] ) );
  object #( 18 ) obj_18 ( .*, .address_i( address ), .command_i( command ), .status_o( status_o[17] ) );

endmodule
