// Single-Bus Mini SRC Datapath

module Datapath(
	output [31:0] BusMux_Out,
    output branch, // AK
    input [31:0] MData_In,
    input [4:0] CONTROL,
    input Clock, Clear, IncPC, Read,
    input PC_Out, MDR_Out, ZHI_Out, ZLO_Out, HI_Out, LO_Out,
    input PC_In, MDR_In, MAR_In, IR_In, Y_In, ZHI_In, ZLO_In, HI_In, LO_In, InPort_In,
    input R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out, R7_Out, R8_Out, R9_Out, R10_Out, R11_Out, R12_OFut, R13_Out, R14_Out, R15_Out,
    //input R0_In, R1_In, R2_In, R3_In, R4_In, R5_In, R6_In, R7_In, R8_In, R9_In, R10_In, R11_In, R12_In, R13_In, R14_In, R15_In

    input G_RA, G_RB, G_RC, R_In, R_Out, BA_Out, // AK
    input conIn
);

wire[31:0] BusMux_In_R0, BusMux_In_R1, BusMux_In_R2, BusMux_In_R3, BusMux_In_R4, BusMux_In_R5, BusMux_In_R6, BusMux_In_R7, BusMux_In_R8, BusMux_In_R9, BusMux_In_R10, BusMux_In_R11, BusMux_In_R12, BusMux_In_R13, BusMux_In_R14, BusMux_In_R15, BusMux_In_HI, BusMux_In_LO, BusMux_In_ZHI, BusMux_In_ZLO, BusMux_In_PC, BusMux_In_MDR, BusMux_In_InPort, BusMux_In_C;
wire[31:0] Y_Data;
wire[31:0] ZHI_Data, ZLO_Data;
wire [31:0] IR_Out;  // AK
wire MAR_Out;

wire [15:0] RX_In; // AK
wire [31:0] BusMux_In_SEL; // AK

// --AK--
// Select and Encode Logic
SEL select(BusMux_In_SEL, RX_In, RX_Out, IR_Out, G_RA, G_RB, G_RC, R_In, R_Out, BA_Out);

// Conditional Branch Instruction 
ConFF con(branch, IR_Out[22:19], BusMux_Out, conIn);
// ------

// General Purpose 32-Bit Registers
Register R0 (BusMux_In_R0, BusMux_Out, Clear, Clock, RX_In[0]); // AK
Register R1 (BusMux_In_R1, BusMux_Out, Clear, Clock, RX_In[1]); // AK
Register R2 (BusMux_In_R2, BusMux_Out, Clear, Clock, RX_In[2]); // AK
Register R3 (BusMux_In_R3, BusMux_Out, Clear, Clock, RX_In[3]); // AK
Register R4 (BusMux_In_R4, BusMux_Out, Clear, Clock, RX_In[4]); // AK
Register R5 (BusMux_In_R5, BusMux_Out, Clear, Clock, RX_In[5]); // AK
Register R6 (BusMux_In_R6, BusMux_Out, Clear, Clock, RX_In[6]); // AK
Register R7 (BusMux_In_R7, BusMux_Out, Clear, Clock, RX_In[7]); // AK
Register R8 (BusMux_In_R8, BusMux_Out, Clear, Clock, RX_In[8]); // AK
Register R9 (BusMux_In_R9, BusMux_Out, Clear, Clock, RX_In[9]); // AK
Register R10 (BusMux_In_R10, BusMux_Out, Clear, Clock, RX_In[10]); // AK
Register R11 (BusMux_In_R11, BusMux_Out, Clear, Clock, RX_In[11]); // AK
Register R12 (BusMux_In_R12, BusMux_Out, Clear, Clock, RX_In[12]); // AK
Register R13 (BusMux_In_R13, BusMux_Out, Clear, Clock, RX_In[13]); // AK
Register R14 (BusMux_In_R14, BusMux_Out, Clear, Clock, RX_In[14]); // AK
Register R15 (BusMux_In_R15, BusMux_Out, Clear, Clock, RX_In[15]); // AK

// 32-Bit Register HI
Register HI (BusMux_In_HI, BusMux_Out, Clear, Clock, HI_In);

// 32-Bit Register LO
Register LO (BusMux_In_LO, BusMux_Out, Clear, Clock, LO_In);

// 32-Bit Register Y
Register Y (Y_Data, BusMux_Out, Clear, Clock, Y_In);

// Program Counter
PCRegister PC (BusMux_In_PC, BusMux_Out, Clear, Clock, PC_In, IncPC);

// Instruction Register
Register IR (IR_Out, BusMux_Out, Clear, Clock, IR_In);

// Memory Data Register
MDRegister MDR (BusMux_In_MDR, BusMux_Out, MData_In, Read, Clear, Clock, MDR_In);

// Memory Access Register
Register MAR (MAR_Out, BusMux_Out, Clear, Clock, MAR_In);

// Arithmetic Logic Unit
ALU ALU (ZHI_Data, ZLO_Data, Y_Data, BusMux_Out, CONTROL, Clear, Clock);

// 32-Bit Register ZHI
Register ZHI (BusMux_In_ZHI, ZHI_Data, Clear, Clock, ZHI_In);

// 32-Bit Register ZIN
Register ZLO (BusMux_In_ZLO, ZLO_Data, Clear, Clock, ZLO_In);


// 32-Bit Bus
Bus Bus (BusMux_Out, 
         BusMux_In_SEL, // AK
         BusMux_In_R0, BusMux_In_R1, BusMux_In_R2, BusMux_In_R3, BusMux_In_R4, BusMux_In_R5, BusMux_In_R6, BusMux_In_R7, BusMux_In_R8, BusMux_In_R9, BusMux_In_R10, BusMux_In_R11, BusMux_In_R12, BusMux_In_R13, BusMux_In_R14, BusMux_In_R15, BusMux_In_HI, BusMux_In_LO, BusMux_In_ZHI, BusMux_In_ZLO, BusMux_In_PC, BusMux_In_MDR, BusMux_In_InPort, BusMux_In_C, 
         // R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out, R7_Out, R8_Out, R9_Out, R10_Out, R11_Out, R12_Out, R13_Out, R14_Out, R15_Out, 
         HI_Out, LO_Out, ZHI_Out, ZLO_Out, PC_Out, MDR_Out, InPort_Out, C_out, // AK
         RX_Out // AK
        );
endmodule // Datapath