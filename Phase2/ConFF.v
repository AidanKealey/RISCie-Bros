// Conditional Branch Logic

module ConFF #(parameter val) (
  	output reg q,
 	input [31:0] d,
   	input [31:0] IR_Out,
	input ConFF_In
	);

	always @ (*) begin
		if(ConFF_In)
			case(IR_Out[22:19]) 
				4'b0011 : begin   // brmi (branch if negative)
					if (d < 0)
						q = 1;
					else
						q = 0;
					end
				4'b0010 : begin   // brpl (branch if positive)
					if (d > 0)
						q = 1;
					else
						q =0;
					end
				4'b0001 : begin   // brnz (branch if nonzero)
					if (d != 0)
						q = 1;
					else
						q = 0;
					end
				4'b0000 : begin   // brzr (branch if zero)
					if (d == 0)
						q = 1;
					else
						q = 0;
					end
				default : begin	// default case (do nothing)
					end
			endcase
   end
	initial q = val; // assign initial value
endmodule // ConFF