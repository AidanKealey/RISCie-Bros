// 32-Bit Register

module Register32 (q, d, clr, clk, enable);
  output reg [31:0] q;
  input [31:0] d;
  input clr, clk, enable;
  
  always @ (posedge clk or negedge clr) begin
    if (clr == 0)
      q <= 0;
    else if (enable)
      q <= d;
   end
endmodule // Register32