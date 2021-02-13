//Tester de los busdrivers del procesador
module busdriver(input wire en, input wire [3:0]in, output wire [3:0]out);

  assign out = (en) ? in : 4'bz;//Si en esta habilitado deja pasar.
                              //Si en esta apagado coloca la salida en alta impedancia.

endmodule
