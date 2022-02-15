// Memory Data Register

module MDR (
  output [31:0] MDR_Out,
  input [31:0] BusMux_Out, MData_In,
  input Read, Clear, Clock, MDR_In
);
  
  wire [31:0] MDMux_Out;
  
  Mux MDMux (MDMux_Out, BusMux_Out, MData_In, Read);
  Register32 MDR (MDR_Out, MDMux_Out, Clear, Clock, MDR_In);
endmodule // MDR