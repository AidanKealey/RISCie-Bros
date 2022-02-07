// 32 to 1 Multiplexer

module BusMux (outBusMux, inR0, inR1, inR2, inR3, inR4, inR5, inR6, inR7, inR8, inR9, inR10, inR11, inR12, inR13, inR14, inR15, inHigh, inHow, inZHigh, inZLow, inPC, inMDR, inPort, cSignExtended, sel);
    output [31:0] outBusMux;
    input [31:0] inR0, inR1, inR2, inR3, inR4, inR5, inR6, inR7, inR8, inR9, inR10, inR11, inR12, inR13, inR14, inR15, inHigh, inHow, inZHigh, inZLow, inPC, inMDR, inPort, cSignExtended;
    input [4:0] sel;

    assign outBusMux = (sel == 0) ? inR0 :
                       (sel == 1) ? inR1 :
                       (sel == 2) ? inR2 :
                       (sel == 3) ? inR3 :
                       (sel == 4) ? inR4 :
                       (sel == 5) ? inR5 :
                       (sel == 6) ? inR6 :
                       (sel == 7) ? inR7 :
                       (sel == 8) ? inR8 :
                       (sel == 9) ? inR9 :
                       (sel == 10) ? inR10 :
                       (sel == 11) ? inR11 :
                       (sel == 12) ? inR12 :
                       (sel == 13) ? inR13 :
                       (sel == 14) ? inR14 :
                       (sel == 15) ? inR15 :
                       (sel == 16) ? inHigh :
                       (sel == 17) ? inLow :
                       (sel == 18) ? inZHigh :
                       (sel == 19) ? inZLow :
                       (sel == 20) ? inPC :
                       (sel == 21) ? inMDR :
                       (sel == 22) ? inPort :
                       (sel == 23) ? cSignExtended : x;
endmodule // BusMux