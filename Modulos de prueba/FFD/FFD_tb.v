module testbench();

  reg clk, reset, en, d;
  reg [1:0] d1;
  reg [3:0] d2;
  wire q;
  wire [1:0] q1;
  wire [3:0] q2;

  ffd a1(clk, reset, en, d, q);
  ffd2 a2(clk, reset, en, d1, q1);
  ffd4 a3(clk, reset, en, d2, q2);

  //FF de 1 bit
  initial begin

  #1
  clk = 0; en = 1; reset = 0; d = 0; d1 = 2'b00; d2 = 4'b0000;
  $display("Registros de FFD");
  $display("| D | Q | 1 bit | D  | Q  | 2 bits | D    | Q    | 4 bits ");
  $monitor("| %b | %b |       | %b | %b |        | %b | %b |", d, q, d1, q1, d2, q2);

  #1 reset = 1;
  #1 reset = 0;
  #1 d = 1; d1 = 2'b10; d2 = 4'b1010;
  #4 d = 0; d1 = 2'b11; d2 = 4'b1110;
  #2 en = 0;
  #4 d = 1; d1 = 2'b01; d2 = 4'b1001;

  #20 $finish;
  end

  always
  begin
    #1 clk = ~clk;
    end

  initial begin
    $dumpfile("FFD_tb.vcd");
    $dumpvars(0, testbench);
  end


endmodule
