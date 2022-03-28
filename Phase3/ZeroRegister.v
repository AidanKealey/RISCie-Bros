// Zero Register

module ZeroRegister (
   output [31:0] BusMux_In_R0,
   input [31:0] BusMux_Out,
   input Clear, Clock, R0_In, BA_Out
	);

   wire [31:0] R0_Out;

   Register #(0) R0 (R0_Out, BusMux_Out, Clear, Clock, R0_In);
   assign BusMux_In_R0 = (BA_Out == 0) ? R0_Out : 32'd0;
endmodule // ZeroRegister