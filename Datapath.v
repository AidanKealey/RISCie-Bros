// Single-Bus Mini SRC Datapath

module Datapath(
output
input R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out, R7_Out, R8_Out, R9_Out, R10_Out, R11_Out, R12_Out, R13_Out, R14_Out, R15_Out,
input R0_In, R1_In, R2_In, R3_In, R4_In, R5_In, R6_In, R7_In, R8_In, R9_In, R10_In, R11_In, R12_In, R13_In, R14_In, R15_In,
input PC_Out, HI_Out, LO_Out, Y_Out, Z_Out, MDR_Out, InPort_Out,
input PC_In, IR_In, HI_In, LO_In, Y_In, Z_In, MDR_In, MAR_In
);


input HIin, LOin, PCin, IRin, Yin,, ZIn, MDRin, MARin

input HIout, LOout, PCout, MDRout, MDRread, Cout, clk, IncPC, ZLowout, ZHighout,

// General Purpose Registers

// Program Counter

// Instruction Register

// Memory Access Register

// Memory Data Register

// Arithmetic Logic Unit

// Bus

input HIin, LOin, PCin, IRin, Yin, InPortout, ZIn,
input HIout, LOout, PCout, MDRout, MDRin, MARin, MDRread, Cout, clk, IncPC, ZLowout, ZHighout,
input [3:0] ALUselect, input [31:0] Mdatain,
output R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, output [63:0] ZReg
);
wire [31:0] bus;
wire clr;
wire IROut;
wire [31:0] YData, XData;
wire [31:0] ZLowData, ZHighData;
//General Registers
wire [31:0] busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8,
busInPC, busInMAR,
busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15, busInMDR, busInHI, busInLO, busInZHI, busInZLO, busInInPort, busInC;
gen_reg r0(busInR0, bus, R0in, clr, clk); gen_reg r1(busInR1, bus, R1in, clr, clk); gen_reg r2(busInR2, bus, R2in, clr, clk); gen_reg r3(busInR3, bus, R3in, clr, clk); gen_reg r4(busInR4, bus, R4in, clr, clk); gen_reg r5(busInR5, bus, R5in, clr, clk); gen_reg r6(busInR6, bus, R6in, clr, clk); gen_reg r7(busInR7, bus, R7in, clr, clk); gen_reg r8(busInR8, bus, R8in, clr, clk); gen_reg r9(busInR9, bus, R9in, clr, clk); gen_reg r10(busInR10, bus, R10in, clr, clk); gen_reg r11(busInR11, bus, R11in, clr, clk); gen_reg r12(busInR12, bus, R12in, clr, clk); gen_reg r13(busInR13, bus, R13in, clr, clk); gen_reg r14(busInR14, bus, R14in, clr, clk); gen_reg r15(busInR15, bus, R15in, clr, clk);
4
//PC and IR
gen_reg ir(IRout, bus, IRin, clr, clk);
pc_reg pc(busInPC, bus, PCin, IncPC, clr, clk);
// MAR and MDR
gen_reg mar(busInMAR, bus, MARin, clr, clk);
mdr_reg mdr(busInMDR, Mdatain, bus, MDRin, MDRread, clr, clk);
//Special Registers
gen_reg hi(busInHI, bus, HIin, clr, clk);
gen_reg lo(busInLO, bus, LOin, clr, clk);
gen_reg y(YData, bus, Yin, clr, clk);
z_reg_64 z(ZHighData, ZLowData, ZReg, ZIn, ZLowout, ZHighout, clr, clk);
//ALU
alu alu(ALUselect, bus, Ydata, ZLowData, ZHighData, carry); assign busInZHI = ZReg[63:0];
assign busInZLO = ZReg[31:0];
//Bus
bus bus_inst(
bus,
busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10, busInR11, busInR12, busInR13, busInR14, busInR15, busInHI, busInLO, busInZHI, busInZLO, busInPC, busInMDR, busInInPort, busInC,
R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, HIout, LOout, ZHighout, ZLowout, PCout, MDRout, InPortout, Cout
);
endmodule // Datapath
