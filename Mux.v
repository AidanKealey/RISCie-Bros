// 2 to 1 Multiplexer

module Mux (MuxOut, in0, in1, sel);
  output [31:0] MuxOut;
  input [31:0] in0, in1;
  input sel;
  
  assign MuxOut = (sel == 0) ? in0 : in1;
endmodule // Mux