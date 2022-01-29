// 64-Bit Register

module Register64 (q, d, clr, clk, enable);
   output reg [63:0] q;
   input [63:0] d;
  input clr, clk, enable;
  
  always @ (posedge clk or negedge clr) begin
    if (clr == 0)
      Q <= 0;
    else if (enable)
      Q <= D;
   end
endmodule // Register64
