//Tester Decoder del procesador
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
