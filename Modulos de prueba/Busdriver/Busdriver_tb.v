module testbench();

  reg en;
  reg [3:0] in;
  wire [3:0] out;

  busdriver a1(en, in, out);

  initial begin

    #1

    en = 0; in = 4'b0000;
    $display("Buffer tri estado de de 4 bits");
    $display("EN | In | OUT");
    $monitor("%b | %b | %b", en, in, out);
    #1 in = 4'b0101;
    #4 en = 1;
    #4 in = 4'b1111;
    #4 en = 0; in = 4'b0011;

    #20 $finish;
    end

    initial begin
      $dumpfile("Busdriver_tb.vcd");
      $dumpvars(0, testbench);
    end

endmodule
