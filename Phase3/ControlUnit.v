// Control Unit

module ControlUnit (
	output reg Run, Clear, Read, Write, IncPC,
   output reg PC_Out, MDR_Out, ZHI_Out, ZLO_Out, HI_Out, LO_Out, C_Out, InPort_Out,
   output reg PC_In, MDR_In, MAR_In, IR_In, Y_In, ZHI_In, ZLO_In, HI_In, LO_In, InPort_In, OutPort_In, ConFF_In,
   output reg G_RA, G_RB, G_RC, R_In, R_Out, BA_Out,
	input [31:0] IR,
	input Clock, Reset, Stop, ConFF_Out
	);
	
endmodule // ControlUnit