// Single-Bus Mini SRC Datapath

module Datapath(
	output [31:0] BusMux_Out,
    input [31:0] MData_In,
    input [4:0] CONTROL,
    input Clock, Clear, IncPC, Read,
    input PC_Out, MDR_Out, ZHI_Out, ZLO_Out,
    input PC_In, MDR_In, MAR_In, IR_In, Y_In, Z_In, InPort_In,
    input R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out, R7_Out, R8_Out, R9_Out, R10_Out, R11_Out, R12_Out, R13_Out, R14_Out, R15_Out,
    input R0_In, R1_In, R2_In, R3_In, R4_In, R5_In, R6_In, R7_In, R8_In, R9_In, R10_In, R11_In, R12_In, R13_In, R14_In, R15_In
);

wire[31:0] BusMux_In_R0, BusMux_In_R1, BusMux_In_R2, BusMux_In_R3, BusMux_In_R4, BusMux_In_R5, BusMux_In_R6, BusMux_In_R7, BusMux_In_R8, BusMux_In_R9, BusMux_In_R10, BusMux_In_R11, BusMux_In_R12, BusMux_In_R13, BusMux_In_R14, BusMux_In_R15, BusMux_In_HI, BusMux_In_LO, BusMux_In_ZHI, BusMux_In_ZLO, BusMux_In_PC, BusMux_In_MDR, BusMux_In_InPort, BusMux_In_C;
wire[31:0] Y_Data;
wire[31:0] ZHI_Data, ZLO_Data;
wire IR_Out;
wire MAR_Out;

// General Purpose 32-Bit Registers
Register32 #(0) R0 (BusMux_In_R0, BusMux_Out, Clear, Clock, R0_In);
Register32 #(0) R1 (BusMux_In_R1, BusMux_Out, Clear, Clock, R1_In);
Register32 #(0) R2 (BusMux_In_R2, BusMux_Out, Clear, Clock, R2_In);
Register32 #(0) R3 (BusMux_In_R3, BusMux_Out, Clear, Clock, R3_In);
Register32 #(0) R4 (BusMux_In_R4, BusMux_Out, Clear, Clock, R4_In);
Register32 #(0) R5 (BusMux_In_R5, BusMux_Out, Clear, Clock, R5_In);
Register32 #(0) R6 (BusMux_In_R6, BusMux_Out, Clear, Clock, R6_In);
Register32 #(0) R7 (BusMux_In_R7, BusMux_Out, Clear, Clock, R7_In);
Register32 #(0) R8 (BusMux_In_R8, BusMux_Out, Clear, Clock, R8_In);
Register32 #(0) R9 (BusMux_In_R9, BusMux_Out, Clear, Clock, R9_In);
Register32 #(0) R10 (BusMux_In_R10, BusMux_Out, Clear, Clock, R10_In);
Register32 #(0) R11 (BusMux_In_R11, BusMux_Out, Clear, Clock, R11_In);
Register32 #(0) R12 (BusMux_In_R12, BusMux_Out, Clear, Clock, R12_In);
Register32 #(0) R13 (BusMux_In_R13, BusMux_Out, Clear, Clock, R13_In);
Register32 #(0) R14 (BusMux_In_R14, BusMux_Out, Clear, Clock, R14_In);
Register32 #(0) R15 (BusMux_In_R15, BusMux_Out, Clear, Clock, R15_In);

// 32-Bit Register HI
Register32 #(0) HI (BusMux_In_HI, BusMux_Out, Clear, Clock, HI_In);

// 32-Bit Register LO
Register32 #(0) LO (BusMux_In_LO, BusMux_Out, Clear, Clock, LO_In);

// 32-Bit Register Y
Register32 #(0) Y (Y_Data, BusMux_Out, Clear, Clock, Y_In);

// Program Counter
PCRegister #(0) PC (BusMux_In_PC, BusMux_Out, Clear, Clock, PC_In, IncPC);

// Instruction Register
Register32 #(0) IR (IR_Out, BusMux_Out, Clear, Clock, IR_In);

// Memory Data Register
MDRegister MDR (BusMux_In_MDR, BusMux_Out, MData_In, Read, Clear, Clock, MDR_In);

// Memory Access Register
Register32 #(0) MAR (MAR_Out, BusMux_Out, Clear, Clock, MAR_In);

// Arithmetic Logic Unit
ArithmeticLogicUnit ALU (ZHI_Data, ZLO_Data, Y_Data, BusMux_Out, CONTROL, Clear, Clock);

// 32-Bit Register ZHI
Register32 #(0) ZHI (BusMux_In_ZHI, ZHI_Data, Clear, Clock, Z_In);

// 32-Bit Register ZIN_LO
Register32 #(0) ZLO (BusMux_In_ZLO, ZLO_Data, Clear, Clock, Z_In);

// 32-Bit Bus
Bus32 Bus (BusMux_Out, 
         BusMux_In_R0, BusMux_In_R1, BusMux_In_R2, BusMux_In_R3, BusMux_In_R4, BusMux_In_R5, BusMux_In_R6, BusMux_In_R7, BusMux_In_R8, BusMux_In_R9, BusMux_In_R10, BusMux_In_R11, BusMux_In_R12, BusMux_In_R13, BusMux_In_R14, BusMux_In_R15, BusMux_In_HI, BusMux_In_LO, BusMux_In_ZHI, BusMux_In_ZLO, BusMux_In_PC, BusMux_In_MDR, BusMux_In_InPort, BusMux_In_C, 
         R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out, R7_Out, R8_Out, R9_Out, R10_Out, R11_Out, R12_Out, R13_Out, R14_Out, R15_Out, HI_Out, LO_Out, ZHI_Out, ZLO_Out, PC_Out, MDR_Out, InPort_Out, C_out
        );
endmodule // Datapath