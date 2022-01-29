// 2 to 1 Multiplexer

module MUX (out, in0, in1, sel);
  output [31:0] out;
  input [31:0] in0, in1;
  input sel;
  
  assign out = sel ? in1 : in0;
endmodule   // MUX
