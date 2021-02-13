module testbench();

  logic csRAM, weRAM;
  logic [3:0] datain;
  logic [11:0] address_RAM;
  wire [3:0] saved_data;

  RAM ram(address_RAM, csRAM, weRAM, saved_data);

  initial
  #200 $finish;

  assign data = weRAM ? datain: 4'bz;

  initial begin
  $display("Address | Data");
  $monitor("%b | %b", address_RAM, saved_data);
  csRAM = 1; weRAM = 0;
  $display("Leyendo...");
  #1 address_RAM = 12'h000;
  #1 address_RAM = 12'h001;
  #1 address_RAM = 12'h002;

  $display("Escribiendo...");
  #1 weRAM = 1; datain = 4'b1010; address_RAM = 12'h000;
  #1 datain = 4'b1011; address_RAM = 12'h001;
  #1 datain = 4'b1100; address_RAM = 12'h002;

  $display("Leyendo...");
  #1 address_RAM = 12'h000; weRAM = 0;
  #1 address_RAM = 12'h001;
  #1 address_RAM = 12'h002;

  end

  initial begin
    $dumpfile("RAM_tb.vcd");
    $dumpvars(0, testbench);
  end


endmodule
