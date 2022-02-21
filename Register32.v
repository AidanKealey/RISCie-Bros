// General 32-Bit Register

module Register32 (
  output reg [31:0] q,
  input [31:0] d,
  input clr, clk, enable
);
  
  always @ (posedge clk) begin
    if (clr == 0)
      q = 0;
    else if (enable)
      q = d;
   end
endmodule // Register32