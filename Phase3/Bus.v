// 32-Bit Bus

module Bus (
   output reg [31:0] BusMux_Out, 
   input [31:0] BusMux_In_R0, BusMux_In_R1, BusMux_In_R2, BusMux_In_R3, BusMux_In_R4, BusMux_In_R5, BusMux_In_R6, BusMux_In_R7, BusMux_In_R8, BusMux_In_R9, BusMux_In_R10, BusMux_In_R11, BusMux_In_R12, BusMux_In_R13, BusMux_In_R14, BusMux_In_R15, BusMux_In_HI, BusMux_In_LO, BusMux_In_ZHI, BusMux_In_ZLO, BusMux_In_PC, BusMux_In_MDR, BusMux_In_InPort, BusMux_In_C,
   input R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out, R7_Out, R8_Out, R9_Out, R10_Out, R11_Out, R12_Out, R13_Out, R14_Out, R15_Out, HI_Out, LO_Out, ZHI_Out, ZLO_Out, PC_Out, MDR_Out, InPort_Out, C_Out
   );

	always @ (*) begin
		if (R0_Out)
			BusMux_Out = BusMux_In_R0;
		else if (R1_Out) 
			BusMux_Out = BusMux_In_R1;
		else if (R2_Out)
			BusMux_Out = BusMux_In_R2;
		else if (R3_Out)
			BusMux_Out = BusMux_In_R3;
		else if (R4_Out)
			BusMux_Out = BusMux_In_R4;
		else if (R5_Out)
			BusMux_Out = BusMux_In_R5;
		else if (R6_Out)
			BusMux_Out = BusMux_In_R6;    
		else if (R7_Out)
			BusMux_Out = BusMux_In_R7;  
		else if (R8_Out)
			BusMux_Out = BusMux_In_R8;  
		else if (R9_Out)
			BusMux_Out = BusMux_In_R9;
		else if (R10_Out)
			BusMux_Out = BusMux_In_R10;    
		else if (R11_Out)
			BusMux_Out = BusMux_In_R11;
		else if (R12_Out)
			BusMux_Out = BusMux_In_R12;
		else if (R13_Out)
			BusMux_Out = BusMux_In_R13;
		else if (R14_Out)
			BusMux_Out = BusMux_In_R14;
		else if (R15_Out)
			BusMux_Out = BusMux_In_R15;
		else if (HI_Out)
			BusMux_Out = BusMux_In_HI;
		else if (LO_Out)
			BusMux_Out = BusMux_In_LO;
		else if (ZHI_Out)
			BusMux_Out = BusMux_In_ZHI;
		else if (ZLO_Out)
			BusMux_Out = BusMux_In_ZLO;
		else if (PC_Out)
			BusMux_Out = BusMux_In_PC;
		else if (MDR_Out)
			BusMux_Out = BusMux_In_MDR;
		else if (InPort_Out)
			BusMux_Out = BusMux_In_InPort;
		else if (C_Out)
			BusMux_Out = BusMux_In_C;
	end
endmodule // Bus