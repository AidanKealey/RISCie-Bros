// Arithmetic Logic Unit

module ALU (
   output reg [31:0] ZHI, ZLO,
   input [31:0] A, B,
   input [11:0] CONTROL,
   input clr, clk, enable
	);

	reg [63:0] C;

   always @ (*) begin
      case(CONTROL)
         CONTROL[11] : begin                		// not
            ZLO <= ~ A; 
            ZHI <= 32'd0;
				end
         CONTROL[10] : begin                		// negate
            ZLO <= ~ A + 1; 
            ZHI <= 32'd0;
				end
         CONTROL[9] : begin                		// or
            ZLO <= A | B; 
            ZHI <= 32'd0;
				end
         CONTROL[8] : begin                		// and
            ZLO <= A & B; 
            ZHI  <= 32'd0;
				end 
         CONTROL[7] : begin                		// rotate left
            ZLO <= A << B | A >> (32 - B);
            ZHI <= 32'd0;
				end
         CONTROL[6] : begin                		// rotate right
            ZLO <= A >> B | A << (32 - B);
            ZHI <= 32'd0;
				end
         CONTROL[5] : begin                		// shift left
            ZLO <= A << B; 
            ZHI <= 32'd0;
				end
         CONTROL[4] : begin                		// shift right
            ZLO <= A >> B;
            ZHI <= 32'd0;
				end
         CONTROL[3] : begin                		// divide
            ZLO = A / B;                		
            ZHI = A % B;                		
				end
         CONTROL[2] : begin                		// multiply
            C = A * B;
            ZLO <= C[31:0];
            ZHI <= C[63:32];
				end
         CONTROL[1] : begin                		// subract
            ZLO <= A - B; 
            ZHI <= 32'd0;
				end
         CONTROL[0] : begin                		// add
            ZLO <= A + B; 
            ZHI <= 32'd0;
				end
         default : begin 
				end             						// default case (do nothing)
        endcase
    end
endmodule // ALU