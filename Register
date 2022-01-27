// 32-bit typical register 

module register32 (Q, D, clr, clk, enable);
  output reg [31:0] Q;
  input [31:0] D;
  input clr, clk, enable;
  
  always @(posedge clk or negedge clr)
  begin
    if (clr == 0)
      Q <= 0;
    else if (enable)
      Q <= D;
   end
endmodule   //register32
