//Tester ALU del procesador
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
