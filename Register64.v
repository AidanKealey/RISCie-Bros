
   
// 64-bit typical register 

module register64 (Q, D, clr, clk, enable);
  output reg [63:0] Q;
  input [63:0] D;
  input clr, clk, enable;
  
  always @(posedge clk or negedge clr)
  begin
    if (clr == 0)
      Q <= 0;
    else if (enable)
      Q <= D;
   end
endmodule   //register64
