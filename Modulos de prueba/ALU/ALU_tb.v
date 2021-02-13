module testbench();

    wire carry, zero;
    reg [3:0] a, b;
    reg [2:0] f;
    wire [3:0] y;

    ALU m(f, a, b, carry, zero, y);


    initial begin
    $display("ALU");
    $display("A | B | F | Carry | Zero | Salida");
    $monitor("%b | %b | %b | %b | %b | %b", a, b, f, carry, zero, y);

       a = 4'b0000; b = 4'b0000; f = 3'b000;
    #1 a = 4'b0001; b = 4'b0000; f = 3'b000;
    #1 a = 4'b0001; b = 4'b0001; f = 3'b000;
    #1 a = 4'b0000; b = 4'b0000; f = 3'b001;
    #1 a = 4'b0000; b = 4'b0001; f = 3'b001;
    #1 a = 4'b0001; b = 4'b0001; f = 3'b001;
    #1 a = 4'b1000; b = 4'b0100; f = 3'b010;
    #1 a = 4'b1000; b = 4'b0100; f = 3'b010;
    #1 a = 4'b0000; b = 4'b0100; f = 3'b011;
    #1 a = 4'b0000; b = 4'b0100; f = 3'b011;
    #1 a = 4'b0010; b = 4'b0000; f = 3'b100;
    #1 a = 4'b0010; b = 4'b0000; f = 3'b100;

    end

    initial
        #30 $finish;

    initial begin
        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, testbench);
    end


endmodule
