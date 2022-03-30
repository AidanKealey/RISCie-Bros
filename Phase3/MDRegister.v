// 32-Bit Memory Data Register

module MDRegister (
	output [31:0] BusMux_In_MDR,
	input [31:0] BusMux_Out, RAM_Data,
	input Read, Clear, Clock, MDR_In
	);
  
	wire [31:0] MDMux_Out;
  
	Multiplexer MDMux (MDMux_Out, BusMux_Out, RAM_Data, Read);
	Register #(0) MDR (BusMux_In_MDR, MDMux_Out, Clear, Clock, MDR_In);
endmodule // MDRegister