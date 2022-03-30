// Memory Address Register

module MARegister #(parameter val = 0) (
	output reg [8:0] q,
   	input [31:0] d,
  	input clr, clk, enable
	);
  
	always @ (posedge clk) begin
		if (clr == 0)
			q = 0;
		else if (enable)
			q = d[8:0];
		end
   initial q = val; // assign initial value
endmodule // MARegister