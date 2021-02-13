//Probar modulo ROM del procesador

module ROM(input wire [11:0] PC, output wire [7:0] program_byte);
        //Definimos las variables de entrada y salida.

    reg [7:0] memoria[0:4095]; //Asignamos el tamaño de la memoria
                              //la cual es de 4k con 8 bits de ancho

    initial begin
        $readmemh("memory.list", memoria); //guardamos un valor 
                                          //Hexadeximal en la memoria
    end

    assign program_byte = memoria[PC]; //Con PC se busca la localidad de memoria que se mostrara en la salida

endmodule
