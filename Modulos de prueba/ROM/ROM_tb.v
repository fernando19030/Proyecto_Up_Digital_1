module testbench();

    reg [11:0] l;
    wire [7:0] y;

    ROM a(l, y);

    initial begin
        $display("Memoria ROM");
        $display("-Localidad- |----Dato----");
        $monitor("%b | %b", l, y);

        #1 l = 12'b000000000000;
        #1 l = 12'b000000000001;
        #1 l = 12'b000000000010;
        #1 l = 12'b000000000011;
        #1 l = 12'b000000000100;
        #1 l = 12'b000000000101;
        #1 l = 12'b000000000110;
        #1 l = 12'b000000000111;
        #1 l = 12'b000000001000;
        #1 l = 12'b000000001001;

    end

    initial
    #500 $finish;

    initial begin
        $dumpfile("ROM_tb.vcd");
        $dumpvars(0, testbench);
    end


endmodule
