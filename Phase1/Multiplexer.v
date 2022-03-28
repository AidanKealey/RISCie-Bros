// 2 to 1 Multiplexer

module Multiplexer (
  output [31:0] out,
  input [31:0] in0, in1,
  input sel
  );
  
  assign out = (sel == 0) ? in0 : in1;
endmodule // Multiplexer