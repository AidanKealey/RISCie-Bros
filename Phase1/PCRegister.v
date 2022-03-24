// 32-Bit Program Counter Register

module PCRegister #(parameter val = 0)(
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
   end
	initial q = val; // assign initial value
endmodule // PCRegister