// Single-Bus Mini SRC Datapath

module Datapath(

);

// General Purpose Registers
Register32 R0 (q, d, clr, clk, enable);
Register32 R1 (q, d, clr, clk, enable);
Register32 R2 (q, d, clr, clk, enable);
Register32 R3 (q, d, clr, clk, enable);
Register32 R4 (q, d, clr, clk, enable);
Register32 R5 (q, d, clr, clk, enable);
Register32 R6 (q, d, clr, clk, enable);
Register32 R7 (q, d, clr, clk, enable);
Register32 R8 (q, d, clr, clk, enable);
Register32 R9 (q, d, clr, clk, enable);
Register32 R10 (q, d, clr, clk, enable);
Register32 R11 (q, d, clr, clk, enable);
Register32 R12 (q, d, clr, clk, enable);
Register32 R13 (q, d, clr, clk, enable);
Register32 R14 (q, d, clr, clk, enable);
Register32 R15 (q, d, clr, clk, enable);

// Program Counter
RegisterPC PC (q, d, clr, clk, write, increment);

// Instruction Register
Register32 IR (q, d, clr, clk, enable);

// Memory Access Register

// Memory Data Register

// Arithmetic Logic Unit

// Bus


endmodule // Datapath