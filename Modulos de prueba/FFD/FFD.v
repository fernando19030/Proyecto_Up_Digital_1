//Modulo para probar el Accumulador, Fetch, Outputs y Flags
module ffd(input clk, input reset, input en, input d, output reg q); //se construyo un FFD de un bit

  always @ (posedge clk, posedge reset)
  if (reset) q <= 1'b0;
  else if (en == 1) q <= d;

endmodule

module ffd2(input clk, reset, en, input [1:0] d, output [1:0] q);
  //con ese mismo FFD se construyo un FFD de 2 bits
  ffd a0(clk, reset, en, d[0], q[0]);
  ffd a1(clk, reset, en, d[1], q[1]);

endmodule

module ffd4(input clk, reset, en, input [3:0] d, output [3:0] q);
 //Luego se construyo un FFD de 4 bits con el mismo modulo inicial
  ffd a0(clk, reset, en, d[0], q[0]);
  ffd a1(clk, reset, en, d[1], q[1]);
  ffd a2(clk, reset, en, d[2], q[2]);
  ffd a3(clk, reset, en, d[3], q[3]);

endmodule

/*Esto se hizo con el objetivo de probar que los registros de FF funcionaran,
  aunque en el modulo final se prefirio simplemente expandir el bitwidth
  del primer modulo ffd para ser mas eficiente con las lineas de código utilizadas
  en trabajo final*/
