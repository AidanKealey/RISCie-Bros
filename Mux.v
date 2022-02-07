// 2 to 1 Multiplexer

module Mux (outMux, in0, in1, sel);
  output [31:0] outMux;
  input [31:0] in0, in1;
  input sel;
  
  assign outMux = (sel == 0) ? in0 : in1;
endmodule // Mux
