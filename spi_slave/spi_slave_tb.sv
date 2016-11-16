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

    logic[7:0]  data_tx;
    logic[7:0]  data_rx;

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

        msb_first = 0;

        data_tx = 0;

        #40ns
        rst = ~rst;
        
        repeat (8) begin
            #63ns;
            transmit;
        end
        
        #77ns
        $stop;
    end
    
    always @(negedge neg or posedge pos)
        mosi <= $urandom() % 2;

    always
        #10ns clk = ~clk;
        
    task transmit;
        cpol      = $urandom() % 2;
        cpha      = $urandom() % 2;
        msb_first = $urandom() % 2;
        sck       = cpol;
        
        data_tx = $urandom() % 256;
        
        #20ns;
        cs  = ~cs;
        
        #10ns;
        repeat (16) begin
            #77ns
            sck = ~sck;
        end
        
        #77ns
        cs = ~cs;
    endtask
    
endmodule
