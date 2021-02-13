module testbench();

  reg clk, reset;
  wire q;

  fft a(clk, reset, q);

  initial begin

  #1
  clk = 0; reset = 0;
  $display("Flip FLop T (Phase)");
  $display("| Phase |");
  $monitor("| %b |", q);
  #1 reset = 1;
  #1 reset = 0;

  #20 $finish;
  end

  always
   #1 clk = ~clk;

   initial begin
     $dumpfile("FFT_tb.vcd");
     $dumpvars(0, testbench);
   end

endmodule
