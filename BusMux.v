// 32 to 1 Multiplexer

module BusMux (BusMuxOut, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, 
            HI, LO, Z_high, Z_low, PC, MDR, in.Port, C_sign_extended, sel);
  output [31:0] BusMuxOut;
  input [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, 
               HI, LO, Z_high, Z_low, PC, MDR, in.Port, C_sign_extended;
  input [4:0] sel;
  
  always @ (R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, 
            HI, LO, Z_high, Z_low, PC, MDR, in.Port, C_sign_extended, sel) begin
    case (sel)
        0 : out = R0;
        1 : out = R1;
        2 : out = R2;
        3 : out = R3;
        4 : out = R4;
        5 : out = R5;
        6 : out = R6;
        7 : out = R7;
        8 : out = R8;
        9 : out = R9;
        10 : out = R10;
        11 : out = R11;
        12 : out = R12;
        13 : out = R13;
        14 : out = R14;
        15 : out = R15;
        16 : out = HI;
        17 : out = LO;
        18 : out = Z_high;
        19 : out = Z_low;
        20 : out = MDR;
        21 : out = in.Port;
        22 : out = C_sign_extended;
        default : out = 0;
    endcase
  end
endmodule // BusMux