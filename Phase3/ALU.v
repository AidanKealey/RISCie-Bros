// Arithmetic Logic Unit

module ALU (
   output reg [31:0] ZHI, ZLO,
   input [31:0] A, B,
   input [11:0] ctrl
	);

	reg [63:0] C;
	
	initial begin // assign initial value
		C = 64'b0;
	end

   always @ (*) begin
      case(ctrl)
         12'b100000000000 : begin							// not
				ZHI = 32'b0;
            ZLO = ~ A; 
			end
         12'b010000000000 : begin                		// negate
				ZHI = 32'b0;
            ZLO = ~ A + 1; 
			end
         12'b001000000000 : begin                		// divide
				ZHI = A % B;  
            ZLO = A / B;                		              		
			end
         12'b000100000000 : begin                		// multiply
            C = A * B;
				ZHI = C[63:32];
            ZLO = C[31:0];
			end
         12'b000010000000 : begin                		// or
				ZHI = 32'b0;
            ZLO = A | B; 
			end
         12'b000001000000 : begin                		// and
				ZHI = 32'b0;
            ZLO = A & B; 
			end 
         12'b000000100000 : begin                		// rotate left
				ZHI = 32'b0;
            ZLO = A << B | A >> (32 - B);
			end
         12'b000000010000 : begin                		// rotate right
				ZHI = 32'b0;
            ZLO = A >> B | A << (32 - B);
			end
         12'b000000001000 : begin                		// shift left
				ZHI = 32'b0;
            ZLO = A << B; 
			end
         12'b000000000100 : begin                		// shift right
				ZHI = 32'b0;
            ZLO = A >> B;
			end
         12'b000000000010 : begin                		// subract
				ZHI = 32'b0;
            ZLO = A - B; 
			end
         12'b000000000001 : begin                		// add
				ZHI = 32'b0;
            ZLO = A + B;
			end
      endcase
   end
endmodule // ALU