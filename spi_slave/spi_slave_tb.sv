module spi_slave_tb;

    logic   rst;
    logic   clk;

    logic   mosi;
    tri     miso;
    logic   sck;
    logic   cs;

    logic   cpol;
    logic   cpha;

    logic   msb_first;

    logic[7:0]  data_out;
    logic[7:0]  data_in;

    logic   busy;
    logic   end_of_byte;
	
    spi_slave DUV(.*);
    
    logic pos;
    logic neg;
        
    assign pos = sck & (cpol & ~cpha | ~cpol & cpha);
    assign neg = sck & (cpol & cpha | ~cpol & ~cpha);

    initial begin
        rst = 1;
        clk = 0;

        mosi = 0;
        sck  = 0;
        cs   = 1;

        cpol = 0;
        cpha = 0;

        msb_first = 1;

        data_out = 0;

        #40ns
        rst = ~rst;
        
        #63ns
        transmit;
        #63ns
        transmit;
        #63ns
        transmit;
        #63ns
        transmit;

        #77ns
        $stop;
    end
    
    always @(negedge neg or posedge pos)
        mosi <= $urandom() % 2;

    always
    #10ns clk = ~clk;
        
    task transmit;
        cpol = $urandom() % 2;
        cpha = $urandom() % 2;
        sck  = cpol;
        
        data_out = $urandom() % 256;
        
        cs  = ~cs;

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
    endtask
    
endmodule
