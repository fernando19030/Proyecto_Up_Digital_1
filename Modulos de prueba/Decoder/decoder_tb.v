module testbench();

  reg [6:0] d;
  wire [12:0] q;

  Decode a1(d, q);

  initial begin

    #1
    d = 7'b0000000;
    $display("Decoder del Procesador");
    $display("D       |      Q");
    $monitor("%b | %b", d, q);
    #1 d = 7'b??????0;
    #1 d = 7'b00001?1;
    #1 d = 7'b00000?1;
    #1 d = 7'b00011?1;
    #1 d = 7'b00010?1;
    #1 d = 7'b0010??1;
    #1 d = 7'b0011??1;
    #1 d = 7'b0100??1;
    #1 d = 7'b0101??1;
    #1 d = 7'b0110??1;
    #1 d = 7'b0111??1;
    #1 d = 7'b1000?11;
    #1 d = 7'b1000?01;
    #1 d = 7'b1001?11;
    #1 d = 7'b1001?01;
    #1 d = 7'b1010??1;
    #1 d = 7'b1011??1;
    #1 d = 7'b1100??1;
    #1 d = 7'b1101??1;
    #1 d = 7'b1110??1;
    #1 d = 7'b1111??1;
    #1 d = 7'b0101010;
    #1 d = 7'b1110001;
    #1 d = 7'b0000000;
    #1 d = 7'b1100110;
    #1 d = 7'b1110000;

    #30 $finish;
    end

    initial begin
      $dumpfile("decoder_tb.vcd");
      $dumpvars(0, testbench);
    end


endmodule
