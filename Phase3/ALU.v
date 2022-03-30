// Arithmetic Logic Unit

module ALU (
   output reg [31:0] ZHI, ZLO,
   input [31:0] A, B,
   input [11:0] ctrl,
   input clr, clk, enable
	);

	reg [63:0] C;

   always @ (*) begin
      case(ctrl)
         ctrl[11] : begin                		// not
            ZLO = ~ A; 
				end
         ctrl[10] : begin                		// negate
            ZLO = ~ A + 1; 
				end
         ctrl[9] : begin                		// divide
            ZLO = A / B;                		
            ZHI = A % B;                		
				end
         ctrl[8] : begin                		// multiply
            C = A * B;
            ZLO = C[31:0];
            ZHI = C[63:32];
				end
         ctrl[7] : begin                		// or
            ZLO = A | B; 
				end
         ctrl[6] : begin                		// and
            ZLO = A & B; 
				end 
         ctrl[5] : begin                		// rotate left
            ZLO = A << B | A >> (32 - B);
				end
         ctrl[4] : begin                		// rotate right
            ZLO = A >> B | A << (32 - B);
				end
         ctrl[3] : begin                		// shift left
            ZLO = A << B; 
				end
         ctrl[2] : begin                		// shift right
            ZLO = A >> B;
				end
         ctrl[1] : begin                		// subract
            ZLO = A - B; 
				end
         ctrl[0] : begin                		// add
            ZLO = A + B; 
				end
        endcase
    end
endmodule // ALU