// 32-Bit Bus

module Bus (
    output reg [31:0] BusMux_Out, 
    input [31:0] BusMux_In_R0, BusMux_In_R1, BusMux_In_R2, BusMux_In_R3, BusMux_In_R4, BusMux_In_R5, BusMux_In_R6, BusMux_In_R7, BusMux_In_R8, BusMux_In_R9, BusMux_In_R10, BusMux_In_R11, BusMux_In_R12, BusMux_In_R13, BusMux_In_R14, BusMux_In_R15, BusMux_In_HI, BusMux_In_LO, BusMux_In_ZHI, BusMux_In_ZLO, BusMux_In_PC, BusMux_In_MDR, BusMux_In_InPort, BusMux_In_C,
    //input R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out, R7_Out, R8_Out, R9_Out, R10_Out, R11_Out, R12_Out, R13_Out, R14_Out, R15_Out, 
    input HI_Out, LO_Out, ZHI_Out, ZLO_Out, PC_Out, MDR_Out, InPort_Out, C_Out,
    input [15:0] RX_Out
    );

always @ (*) begin
    if (RX_Out[0]) // AK
        BusMux_Out = BusMux_In_R0;
    else if (RX_Out[1]) // AK
        BusMux_Out = BusMux_In_R1;
    else if (RX_Out[2]) // AK
        BusMux_Out = BusMux_In_R2;
    else if (RX_Out[3]) // AK
        BusMux_Out = BusMux_In_R3;
    else if (RX_Out[4]) // AK
        BusMux_Out = BusMux_In_R4;
    else if (RX_Out[5]) // AK
        BusMux_Out = BusMux_In_R5;
    else if (RX_Out[6]) // AK
        BusMux_Out = BusMux_In_R6;    
    else if (RX_Out[7]) // AK
        BusMux_Out = BusMux_In_R7;  
    else if (RX_Out[8]) // AK
        BusMux_Out = BusMux_In_R8;  
    else if (RX_Out[9]) // AK
        BusMux_Out = BusMux_In_R9;
    else if (RX_Out[10]) // AK
        BusMux_Out = BusMux_In_R10;    
    else if (RX_Out[11]) // AK
        BusMux_Out = BusMux_In_R11;
    else if (RX_Out[12]) // AK
        BusMux_Out = BusMux_In_R12;
    else if (RX_Out[13]) // AK
        BusMux_Out = BusMux_In_R13;
    else if (RX_Out[14]) // AK
        BusMux_Out = BusMux_In_R14;
    else if (RX_Out[15]) // AK
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
    else
        begin 
        end
    end
endmodule // Bus