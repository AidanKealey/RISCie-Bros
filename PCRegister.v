// General 32-Bit Register

module PCRegister (
  output reg [31:0] q,
  input [31:0] d,
  input clr, clk, write, increment
);
  
  always @ (posedge clk) begin
    if (clr == 0)
        q = 0;
    else if (write)
        q = d;
    else if (increment)
        q = q + 1;
    else 
      q = 32;
   end
endmodule // PCRegister