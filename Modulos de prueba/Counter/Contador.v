//Test funcionamiento del contador

module counter(input clk, reset, en, load, input [11:0] data, output reg [11:0] out);

    always @ (posedge reset, posedge clk) begin
        if(reset) out <= 12'b000000000000; //Flanco de reloj de reset lleva out a 0

        else if(load) out <= data; //Al activar load el valor de salida sera al valor que le carguemos

        else if(en) out <= out + 1; //Si en es 1 funcionamiento normal del contador
    end

endmodule
