// Memory Data Register

module MDR (outMDR, in0, in1, clr, clk, enable, sel);
  output [31:0] outMDR;
  input [31:0] in0, in1;
  input clr, clk, enable, sel;
  
  wire [31:0] outMux;
  
  MUX MDMux (.out (outMux), .in0 (in0), .in1 (in1), .sel (sel));
  Register32 MDR (.q (outMDR), .d (muxMux), .clr (clr), .clk (clk), .enable (enable));
endmodule // MDR