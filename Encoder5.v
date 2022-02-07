// 32-bit to 5-bit Encoder

module Encoder5 (outEncoder5, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, high, low, zHigh, zLow, PC, MDR, inPort, c);
  output [4:0] outEncoder5;
  input R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, high, low, zHigh, zLow, PC, MDR, inPort, c;
  
  assign outEncoder5 = (R0 == 1) ? 0:
               (R1 == 1) ? 1:
               (R2 == 1) ? 2:
               (R3 == 1) ? 3:
               (R4 == 1) ? 4:
               (R5 == 1) ? 5:
               (R6 == 1) ? 6:
               (R7 == 1) ? 7:
               (R8 == 1) ? 8:
               (R9 == 1) ? 9:
               (R10 == 1) ? 10:
               (R11 == 1) ? 11:
               (R12 == 1) ? 12:
               (R13 == 1) ? 13:
               (R14 == 1) ? 14:
               (R15 == 1) ? 15:
               (high == 1) ? 16:
               (low == 1) ? 17:
               (zHigh == 1) ? 18:
               (zLow == 1) ? 19:
               (PC == 1) ? 20:
               (MDR == 1) ? 21:
               (inPort == 1) ? 22:
               (c == 1) ? 23: x;
endmodule // Encoder5
