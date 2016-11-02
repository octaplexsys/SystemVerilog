module spi_slave_tb;

	logic	rst;
	logic	clk;
	
	logic	mosi;
	tri		miso;
	logic	sck;
	logic	cs;
	
	logic	cpol; // polarity control
	logic	cpha; // phase control
	logic	msb_first; // when is 1, first bit on miso is shift[7]
						// else shift[0]
	
	logic[7:0] data_out;
	logic[7:0] data_in;
	
	logic	busy; 		// is 1 when data is transmitted
	logic	end_of_byte;
	
	spi_slave DUV(.*);
	
	initial begin
		rst		= 1;
		clk		= 0;
		
		mosi	= 0;
		sck		= 0;
		cs		= 1;
		
		#50ns
		rst		= 0;
		
		#250ns
		$stop;
	end
	
	always
	#10ns clk = ~clk;
	
endmodule
