//Tester Ram del procesador
module RAM (input[11:0] address_RAM, input csRAM, weRAM, output [3:0] saved_data);

    reg [3:0] memoria[0:4095]; //Localidades de memoria de la RAM
    reg [3:0] salida_datos;

    assign saved_data = (csRAM && ! weRAM) ? salida_datos : 4'bzzzz; //Control del bufer triestado
                                                                     //Sale cuando weRAM es 0 y cuando csRAM es igual a 1

    //Escritura dentro de la memoria
    always @ (address_RAM or saved_data or csRAM or weRAM) begin: MEM_WRITE
        if (csRAM && weRAM)
            memoria[address_RAM] = saved_data;
    end

    //Lectura de lo que esta en la memoria RAM
    always @ (address_RAM or csRAM or weRAM) begin: MEM_READ
        if (csRAM && ! weRAM)
            salida_datos = memoria[address_RAM];
    end

endmodule
