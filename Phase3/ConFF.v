// Conditional Branch Logic

module ConFF (
	output reg q,
	input [31:0] d,
	input [31:0] IR_Data,
	input ConFF_In
	);
	
	initial begin // assign initial value
		q = 0;
	end

	always @ (*) begin
		if(ConFF_In) begin
			case(IR_Data[22:19]) 
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
			endcase
		end
   end
endmodule // ConFF