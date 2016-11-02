module spi_slave_tb;
	

	logic	rst;
	logic	clk;
	
	logic	mosi;
	tri		miso;
	logic	sck;
	logic	cs;
	
	logic	cpol;
	logic	cpha;
	
	logic	msb_first;
	
	logic[7:0] data_out;
	logic[7:0] data_in;
	
	logic	busy;
	logic	end_of_byte;
	
	spi_slave DUV(.*);
	
	initial begin
		rst	= 1;
		clk	= 0;
		
		mosi	= 0;
		sck		= 0;
		cs		= 1;
		
		cpol	= 0;
		cpha	= 0;
	
		msb_first	= 1;
	
		data_out	= 'b1001_0101;
		
		#40ns
		rst	= ~rst;
		#15ns
		cs	= ~cs;
		
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		sck = ~sck;
		#77ns
		cs = ~cs;
		
		#77ns
		$stop;
	end
	
	always
	#10ns clk = ~clk;
	
	always @(negedge sck)
		mosi <= $urandom() % 2;
	
endmodule
