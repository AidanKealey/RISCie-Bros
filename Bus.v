// Bus

module Bus (BusMuxOut, BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_ZHI, BusMuxIn_ZLO, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_InPort, BusMuxIn_C,
            R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out, R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, ZHI_out, ZLO_out, PC_out, MDR_out, InPort_out, C_out);
output reg [31:0] BusMuxOut;
input [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_ZHI, BusMuxIn_ZLO, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_InPort, BusMuxIn_C;
input R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, R8_out, R9_out, R10_out, R11_out, R12_out, R13_out, R14_out, R15_out, HI_out, LO_out, ZHI_out, ZLO_out, PC_out, MDR_out, InPort_out, C_out;

always @ (*) begin
    if (R0_out)
        BusMuxOut = BusMuxIn_R0;
    else if (R1_out) 
        BusMuxOut = BusMuxIn_R1;
    else if (R2_out)
        BusMuxOut = BusMuxIn_R2;
    else if (R3_out)
        BusMuxOut = BusMuxIn_R3;
    else if (R4_out)
        BusMuxOut = BusMuxIn_R4;
    else if (R5_out)
        BusMuxOut = BusMuxIn_R5;
    else if (R6_out)
        BusMuxOut = BusMuxIn_R6;    
    else if (R7_out)
        BusMuxOut = BusMuxIn_R7;  
    else if (R8_out)
        BusMuxOut = BusMuxIn_R8;  
    else if (R9_out)
        BusMuxOut = BusMuxIn_R9;
    else if (R10_out)
        BusMuxOut = BusMuxIn_R10;    
    else if (R11_out)
        BusMuxOut = BusMuxIn_R11;
    else if (R12_out)
        BusMuxOut = BusMuxIn_R12;
    else if (R13_out)
        BusMuxOut = BusMuxIn_R13;
    else if (R14_out)
        BusMuxOut = BusMuxIn_R14;
    else if (R15_out)
        BusMuxOut = BusMuxIn_R15;
    else if (HI_out)
        BusMuxOut = BusMuxIn_HI;
    else if (LO_out)
        BusMuxOut = BusMuxIn_LO;
    else if (ZHI_out)
        BusMuxOut = BusMuxIn_ZHI;
    else if (ZLO_out)
        BusMuxOut = BusMuxIn_ZLO;
    else if (PC_out)
        BusMuxOut = BusMuxIn_PC;
    else if (MDR_out)
        BusMuxOut = BusMuxIn_MDR;
    else if (InPort_out)
        BusMuxOut = BusMuxIn_InPort;
    else if (C_out)
        BusMuxOut = BusMuxIn_C;
    else
        begin end
    end
endmodule // Bus