// Single-Bus Mini SRC Datapath

module Datapath (
   output [31:0] BusMux_Out,
   output [31:0] OutData,
   output ConFF_Out,
   input [31:0] InData,
   input [4:0] CONTROL,
   input Clock, Clear, IncPC, Read, Write,
   input PC_Out, MDR_Out, ZHI_Out, ZLO_Out, HI_Out, LO_Out, InPort_Out,
   input PC_In, MDR_In, MAR_In, IR_In, Y_In, ZHI_In, ZLO_In, HI_In, LO_In, InPort_In, OutPort_In, Con_In,
   input G_RA, G_RB, G_RC, R_In, R_Out, BA_Out, C_Out
	);

	wire [31:0] BusMux_In_R0, BusMux_In_R1, BusMux_In_R2, BusMux_In_R3, BusMux_In_R4, BusMux_In_R5, BusMux_In_R6, BusMux_In_R7, BusMux_In_R8, BusMux_In_R9, BusMux_In_R10, BusMux_In_R11, BusMux_In_R12, BusMux_In_R13, BusMux_In_R14, BusMux_In_R15, BusMux_In_HI, BusMux_In_LO, BusMux_In_ZHI, BusMux_In_ZLO, BusMux_In_PC, BusMux_In_MDR, BusMux_In_InPort, BusMux_In_C;
	wire [31:0] Y_Data;
	wire [31:0] ZHI_Data, ZLO_Data;
	wire [31:0] IR_Out;
	wire [31:0] MData_In;
	wire [15:0] RX_Out;
	wire [15:0] RX_In;
	wire [8:0] MAR_Out;

	// General Purpose 32-Bit Registers
	ZeroRegister R0 (BusMux_In_R0, BusMux_Out, Clear, Clock, RX_In[0], BA_Out);
	Register #(0) R1 (BusMux_In_R1, BusMux_Out, Clear, Clock, RX_In[1]);
	Register #(1) R2 (BusMux_In_R2, BusMux_Out, Clear, Clock, RX_In[2]);
	Register #(0) R3 (BusMux_In_R3, BusMux_Out, Clear, Clock, RX_In[3]);
	Register #(0) R4 (BusMux_In_R4, BusMux_Out, Clear, Clock, RX_In[4]);
	Register #(0) R5 (BusMux_In_R5, BusMux_Out, Clear, Clock, RX_In[5]);
	Register #(0) R6 (BusMux_In_R6, BusMux_Out, Clear, Clock, RX_In[6]);
	Register #(0) R7 (BusMux_In_R7, BusMux_Out, Clear, Clock, RX_In[7]);
	Register #(0) R8 (BusMux_In_R8, BusMux_Out, Clear, Clock, RX_In[8]);
	Register #(0) R9 (BusMux_In_R9, BusMux_Out, Clear, Clock, RX_In[9]);
	Register #(0) R10 (BusMux_In_R10, BusMux_Out, Clear, Clock, RX_In[10]);
	Register #(0) R11 (BusMux_In_R11, BusMux_Out, Clear, Clock, RX_In[11]);
	Register #(0) R12 (BusMux_In_R12, BusMux_Out, Clear, Clock, RX_In[12]);
	Register #(0) R13 (BusMux_In_R13, BusMux_Out, Clear, Clock, RX_In[13]);
	Register #(0) R14 (BusMux_In_R14, BusMux_Out, Clear, Clock, RX_In[14]);
	Register #(0) R15 (BusMux_In_R15, BusMux_Out, Clear, Clock, RX_In[15]);

	// 32-Bit Register HI
	Register #(0) HI (BusMux_In_HI, BusMux_Out, Clear, Clock, HI_In);

	// 32-Bit Register LO
	Register #(0) LO (BusMux_In_LO, BusMux_Out, Clear, Clock, LO_In);

	// 32-Bit Register Y
	Register #(0) Y (Y_Data, BusMux_Out, Clear, Clock, Y_In);

	// Program Counter
	PCRegister PC (BusMux_In_PC, BusMux_Out, Clear, Clock, PC_In, IncPC);

	// Instruction Register
	Register #(0) IR (IR_Out, BusMux_Out, Clear, Clock, IR_In);

	// Memory Data Register
	MDRegister MDR (BusMux_In_MDR, BusMux_Out, MData_In, Read, Clear, Clock, MDR_In);

	// Memory Access Register
	MARegister MAR (MAR_Out, BusMux_Out, Clear, Clock, MAR_In);

	// Arithmetic Logic Unit
	ALU ALU (ZHI_Data, ZLO_Data, Y_Data, BusMux_Out, CONTROL, Clear, Clock);

	// 32-Bit Register ZHI
	Register #(0) ZHI (BusMux_In_ZHI, ZHI_Data, Clear, Clock, ZHI_In);

	// 32-Bit Register ZIN
	Register #(0) ZLO (BusMux_In_ZLO, ZLO_Data, Clear, Clock, ZLO_In);

	// Input Port Register
	Register #(0) InPort (BusMux_In_InPort, InData, Clear, Clock, InPort_In);

	// Output Port Register
	Register #(0) OutPort (OutData, BusMux_Out, Clear, Clock, OutPort_In);

	// Select and Encode Logic
	SEL SEL (BusMux_In_C, RX_In, RX_Out, IR_Out, G_RA, G_RB, G_RC, R_In, R_Out, BA_Out);

	// Conditional Branch Logic
	ConFF #(0) ConFF (ConFF_Out, BusMux_Out, IR_Out, Con_In);

	// Random Access Memory
	RAM RAM (.address(MAR_Out), .clock(Clock), .data(BusMux_In_MDR), .wren(Write), .q(MData_In));

	// 32-Bit Bus
	Bus Bus (BusMux_Out, 
				BusMux_In_R0, BusMux_In_R1, BusMux_In_R2, BusMux_In_R3, BusMux_In_R4, BusMux_In_R5, BusMux_In_R6, BusMux_In_R7, BusMux_In_R8, BusMux_In_R9, BusMux_In_R10, BusMux_In_R11, BusMux_In_R12, BusMux_In_R13, BusMux_In_R14, BusMux_In_R15, BusMux_In_HI, BusMux_In_LO, BusMux_In_ZHI, BusMux_In_ZLO, BusMux_In_PC, BusMux_In_MDR, BusMux_In_InPort, BusMux_In_C, 
				RX_Out[0], RX_Out[1], RX_Out[2], RX_Out[3], RX_Out[4], RX_Out[5], RX_Out[6], RX_Out[7], RX_Out[8], RX_Out[9], RX_Out[10], RX_Out[11], RX_Out[12], RX_Out[13], RX_Out[14], RX_Out[15], HI_Out, LO_Out, ZHI_Out, ZLO_Out, PC_Out, MDR_Out, InPort_Out, C_Out
				);
endmodule // Datapath