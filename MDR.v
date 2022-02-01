// Memory Data Register

module MDR (out, in0, in1, clr, clk, enable, sel);
  output [31:0] out;
  input [31:0] in0, in1;
  input clr, clk, enable, sel;
  
  wire [31:0] internal;
  
  MUX MDMux (.out (internal), .in0 (in0), .in1 (in1), .sel (sel));
  Register32 MDR (.q (out), .d (internal), .clr (clr), .clk (clk), .enable (enable));
endmodule   // MDR