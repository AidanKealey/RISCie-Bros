// 32 to 5 Encoder

module ENCODER5 (out, inR0, inR1, inR2, inR3, inR4, inR5, inR6, inR7, inR8, inR9, inR10, inR11, inR12, inR13, inR14, inR15, HI, LOW, ZHI, ZLOW, inPC, inMDR, inPort, Cout);
  output [4:0] out;
  input inR0, inR1, inR2, inR3, inR4, inR5, inR6, inR7, inR8, inR9, inR10, inR11, inR12, inR13, inR14, inR15, HI, LOW, ZHI, ZLOW, inPC, inMDR, inPort, Cout;
  
  assign out = (inR0 == 1) ? 0:
               (inR1 == 1) ? 1:
               (inR2 == 1) ? 2:
               (inR3 == 1) ? 3:
               (inR4 == 1) ? 4:
               (inR5 == 1) ? 5:
               (inR6 == 1) ? 6:
               (inR7 == 1) ? 7:
               (inR8 == 1) ? 8:
               (inR9 == 1) ? 9:
               (inR10 == 1) ? 10:
               (inR11 == 1) ? 11:
               (inR12 == 1) ? 12:
               (inR13 == 1) ? 13:
               (inR14 == 1) ? 14:
               (inR15 == 1) ? 15:
               (HI == 1) ? 16:
               (LOW == 1) ? 17:
               (ZHI == 1) ? 18:
               (ZLOW == 1) ? 19:
               (inPC == 1) ? 20:
               (inMDR == 1) ? 21:
               (inPort == 1) ? 22:
               (Cout == 1) ? 23: 0;
endmodule   //ENCODER5