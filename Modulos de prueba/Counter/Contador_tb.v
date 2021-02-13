module testbench();

  reg clk, reset, en, load;
  reg [11:0] val;
  wire [11:0] q;

  counter e1(clk, reset, en, load, val, q);

  always
   #1 clk = ~clk;

  initial begin

  clk = 0;

  $display("Program Counter de 12 bits");
  $display("---Cuenta--- | ---Carga----");
  $monitor("%b | %b", q, val);

  reset = 0; en = 0; load = 0; val = 12'b0;
  #10 reset = 1;
  #2 reset = 0; val = 12'b000001100100;
  #2 load = 1;
  #20 load = 0; en = 1;


  #60 $finish;
  end

  initial begin
    $dumpfile("Contador_tb.vcd");
    $dumpvars(0, testbench);
  end

endmodule
