//Proyecto final Electronica Digital 1: Procesadro uP
module busdriver(input wire en, input wire [3:0]in, output wire [3:0]out);

  assign out = (en) ? in : 4'bz;//Si en esta habilitado deja pasar.
                              //Si en esta apagado coloca la salida en alta impedancia.

endmodule

module Fetch (input clk, reset, en, input [7:0] d, output reg [7:0] q); //Flip flop tipo D de 8 bits

    always @ (posedge clk or posedge reset) begin
        if (reset) 
            q <= 8'b0;
        else if (en)
            q <= d;  
    end  
endmodule

module Accumulator (input clk, reset, en, input [3:0] d, output reg [3:0] q); //Flip flop tipo D de 4 bits

    always @ (posedge clk, posedge reset)
        if (reset) 
            q <= 4'b0000;
        else if (en)
            q <= d;    
endmodule

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

module counter(input clk, reset, en, load, input [11:0] data, output reg [11:0] out);

    always @ (posedge reset, posedge clk) begin
        if(reset) out <= 12'b000000000000; //Flanco de reloj de reset lleva out a 0

        else if(load) out <= data; //Al activar load el valor de salida sera al valor que le carguemos

        else if(en) out <= out + 1; //Si en es 1 funcionamiento normal del contador
    end

endmodule

//Fabricación de Phase por medio de un FFD
module ffd_T(input clk, reset, d, output reg q);

    always @ (posedge clk or posedge reset) begin
        if (reset) 
            q <= 1'b0;
        else 
            q <= d;
    end
endmodule
module Phase(input clk, reset, output phase);

    wire w;
    assign w = ~phase; //En cada flanco de reloj la salida cambiara de valor, oscilando entre 0 y 1

    ffd_T a(clk, reset, w, phase);

endmodule

module ALU(input [2:0] f, input [3:0] a, b, output carry, zero, output [3:0] s);

    reg [4:0] control; //variable que nos ayudara a realizar tanto las operaciones como verificar el estado de zero y carry

    always @ (a, b, f)
        case(f)
            3'b000: control = a; //out, jumps y st
            3'b001: control = a - b; //CMPI y CMPM
            3'b010: control = b; //LIT, in y ld
            3'b011: control = a + b; //ADDI y ADDM
            3'b100: control = {1'b0, ~(a & b)}; //NANDI y NANDM
            default: control = 5'b10101;//valor por defecto de controll si la instruccion no se encuentra
        endcase

    assign s = control[3:0];//salida de la ALU despues de operar
    assign carry = control[4]; //Bit si existe overflow en la operación
    assign zero = ~(control[3] | control[2] | control[1] | control[0]); //Bit que se enciende cuando la salida S es igual a 0

endmodule

module Decode(input [6:0] address, output [12:0] control_signals);

    reg [12:0] q;
    always @ (address) begin
        casez(address) //Implementación de la tabla de verdad del decoder por medio de casos
            7'b????_??0: q <= 13'b1000_000_001000; //any
            7'b0000_1?1: q <= 13'b0100_000_001000; //JC
            7'b0000_0?1: q <= 13'b1000_000_001000; //JC
            7'b0001_1?1: q <= 13'b1000_000_001000; //JNC
            7'b0001_0?1: q <= 13'b0100_000_001000; //JNC
            7'b0010_??1: q <= 13'b0001_001_000010; //CMPI
            7'b0011_??1: q <= 13'b1001_001_100000; //CMPM
            7'b0100_??1: q <= 13'b0011_010_000010; //LIT
            7'b0101_??1: q <= 13'b0011_010_000100; //IN
            7'b0110_??1: q <= 13'b1011_010_100000; //LD
            7'b0111_??1: q <= 13'b1000_000_111000; //ST
            7'b1000_?11: q <= 13'b0100_000_001000; //JZ
            7'b1000_?01: q <= 13'b1000_000_001000; //JZ
            7'b1001_?11: q <= 13'b1000_000_001000; //JNZ
            7'b1001_?01: q <= 13'b0100_000_001000; //JNZ
            7'b1010_??1: q <= 13'b0011_011_000010; //ADDI
            7'b1011_??1: q <= 13'b1011_011_100000; //ADDM
            7'b1100_??1: q <= 13'b0100_000_001000; //JMP
            7'b1101_??1: q <= 13'b0000_000_001001; //OUT
            7'b1110_??1: q <= 13'b0011_100_000010; //NANDI
            7'b1111_??1: q <= 13'b1011_100_100000; //NANDM
            default: q <= 13'b1111111111111;
        endcase
    end

    assign control_signals = q;
endmodule

module Outputs (input clk, reset, en, input [3:0] d, output reg [3:0] FF_out); //Flip flop tipo D de 4 bits

    always @ (posedge clk, posedge reset)
        if (reset) 
            FF_out <= 4'b0000;
        else if (en)
            FF_out <= d;    
endmodule

module Flags (input clk, reset, en, c, z, output c_flag, z_flag); //Flip flop tipo D de 2 bits separado en dos salidas para el carry y el zero.
    wire [1:0] d; 
    reg [1:0] q;
    assign d = {c, z};

    always @ (posedge clk, posedge reset)
        if (reset) 
            q <= 4'b0000;
        else if (en)
            q <= d;  

    assign c_flag = q[1];
    assign z_flag = q[0];  

endmodule

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

//Se juntan todos los módulos dentro de uno para interconectarlos entre si

module uP(input clock, reset, input [3:0] pushbuttons,
          output phase, c_flag, z_flag,
          output [3:0] instr, oprnd, data_bus, FF_out, accu,
          output [7:0] program_byte,
          output [11:0] PC, address_RAM); //Se declaran las entradas

    //Se llaman cables que se utilizaran para interconectar los modulos entre si.
    wire incPC, loadPC, loadA, loadFlags, csRAM, weRAM, oeALU, oeIN, oeOprnd, loadOut;
    wire phase, loadFetch, c, ze, cablez, cablec;
    wire [2:0] s;
    wire [3:0] bus_datos, opr, ins, cableAccu, cableALU;
    wire [6:0] signal;
    wire [7:0] cableFetch, cableROM;
    wire [11:0] cablePC, cableAddress;
    wire [12:0] control;

    assign bus_datos = data_bus; //data bus
    assign loadFetch = ~phase; //enable del fetch
    assign cableROM = program_byte; //salida de la ROM
    assign cablePC = PC; //salida del contador
    assign ins = cableFetch[7:4]; //los 4 bits mas significativos del Fetch
    assign opr = cableFetch[3:0]; //los 4 bits menos significativos del Fetch
    assign cableAddress = {opr, cableROM}; //concatenacion de la entrada del selector de la localidad de memoria de la RAM
    assign address_RAM = cableAddress; 
    assign instr = ins;
    assign oprnd = opr;
    assign accu = cableAccu;
    assign cablez = z_flag; 
    assign cablec = c_flag;

    //Bloque de los busdrivers que se encuentran en el procesador
    busdriver busin(oeIN, pushbuttons, data_bus);
    busdriver busALU(oeALU, cableALU ,data_bus);
    busdriver busOpr(oeOprnd, opr ,data_bus);

    //Bloque de los registros de Flip Flops D y del toggle FF que se encuentran en el procesador
    Phase toggleFF(clock, reset, phase); //FFT
    Fetch register1(clock, reset, loadFetch, cableROM, cableFetch); //FFD de 8 bits
    Flags register2(clock, reset, loadFlags, c, ze, c_flag, z_flag); //FFD de 2 bits
    Accumulator register3(clock, reset, loadA, cableALU, cableAccu); //FFD de 4 bits
    Outputs register4(clock, reset, loadOut, bus_datos, FF_out); //FFD de 4 bits

    //Bloques de logica combinacional que se encuentran en el procesador
    counter lc1(clock, reset, incPC, loadPC, cableAddress, PC); 
    ROM lc2(cablePC, program_byte);
    ALU lc3(s, cableAccu, bus_datos, c, ze, cableALU);
    RAM lc4(cableAddress, csRAM, weRAM, data_bus);

    //Llamada del cerebro del procesador
    assign signal = {ins, cablec, cablez, phase}; //Concatenacion de las entradas del decoder
    Decode master(signal, control);
    //Separación de la salida del decoder para llevar la señal a cada punto requerido.
    assign incPC = control[12];
    assign loadPC = control[11];
    assign loadA = control[10];
    assign loadFlags = control[9];
    assign s = control[8:6];
    assign csRAM = control[5];
    assign weRAM = control[4];
    assign oeALU = control[3];
    assign oeIN = control[2];
    assign oeOprnd = control[1];
    assign loadOut = control[0];

endmodule
