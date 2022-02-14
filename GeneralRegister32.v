// General 32-Bit Register

module GeneralRegister32 (
  output reg [31:0] Q,
  input [31:0] D,
  input clr, clk, enable
);
  
  always @ (posedge clk) begin
    if (clr == 0)
      Q = 0;
    else if (enable)
      Q = D;
   end
endmodule // GeneralRegister32