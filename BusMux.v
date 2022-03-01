// 32 to 1 Multiplexer

module BusMux (BusMuxOut, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, HI, LO, Z_high, Z_low, PC, MDR, inPort, C_sign_extended, sel);
    output [31:0] BusMuxOut;
    input [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, HI, LO, Z_high, Z_low, PC, MDR, inPort, C_sign_extended;
    input [4:0] sel;

    assign BusMuxOut = (sel == 0) ? R0 :
                       (sel == 1) ? R1 :
                       (sel == 2) ? R2 :
                       (sel == 3) ? R3 :
                       (sel == 4) ? R4 :
                       (sel == 5) ? R5 :
                       (sel == 6) ? R6 :
                       (sel == 7) ? R7 :
                       (sel == 8) ? R8 :
                       (sel == 9) ? R9 :
                       (sel == 10) ? R10 :
                       (sel == 11) ? R11 :
                       (sel == 12) ? R12 :
                       (sel == 13) ? R13 :
                       (sel == 14) ? R14 :
                       (sel == 15) ? R15 :
                       (sel == 16) ? HI :
                       (sel == 17) ? LO :
                       (sel == 18) ? Z_high :
                       (sel == 19) ? Z_low :
                       (sel == 20) ? PC :
                       (sel == 21) ? MDR :
                       (sel == 22) ? inPort :
                       (sel == 23) ? C_sign_extended : 0;
endmodule // BusMux