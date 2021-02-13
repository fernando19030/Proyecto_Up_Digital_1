//Modulo para probar el funcionamiento del Phase del procedador
module ffd(input clk, input reset, input d, output reg q);

  always @ (posedge clk, posedge reset)
  if (reset) q <= 1'b0;
  else q <= d;

endmodule

module fft(input clk, reset, output q);

  wire w;
  assign w = ~q;

  ffd a(clk, reset, w, q);

endmodule
