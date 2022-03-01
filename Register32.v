// General 32-Bit Register

module Register32 #(parameter VAL = 0)(
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
	initial q = VAL; // assign initial value
endmodule // Register32