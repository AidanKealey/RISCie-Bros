// CPU Testbench

`timescale 1ns/10ps
module CPU_tb;
   reg Clock, Reset, Stop;
	
	wire Run;
	wire [31:0] BusMux_Out;

   CPU DUT (
		.BusMux_Out(BusMux_Out),
		.Run(Run), 
      .Clock(Clock), .Reset(Reset), .Stop(Stop)
		);

   initial begin
		Clock = 1; Reset = 0; Stop = 0;
      forever #10 Clock = ~ Clock; 
   end
endmodule // CPU_tb