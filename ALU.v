// Arithmetic Logic Unit

module ALU (ZHI, ZLO, A, B, ctrl, clr, clk);
    output reg [31:0] ZHI, ZLO;
    input [31:0] A, B;
	input [3:0] ctrl;
	input clr, clk;

    always @ (*) begin
        case(ctrl)
            4'b1011 : begin                 // Not
                ZLO <= ! A; 
                ZHI  <= 32'd0;
            end
            4'b1010 : begin                 // Negate
                ZLO <= ~ A; 
                zHI  <= 32'd0;
            end
            4'b1001 : begin                 // Or
                ZLO <= A || B; 
                ZHI  <= 32'd0;
            end
            4'b1000 : begin                 // And
                ZLO <= A & B; 
                ZHI  <= 32'd0;
            end 
            4'b0111 : begin                 // Rotate Left
                ZLO <= {A[30:0], A[31]}; 
                ZHI  <= 32'd0;
            end
            4'b0110 : begin                 // Rotate Right
                ZLO <= {A[0], A[31:1]}; 
                ZHI  <= 32'd0;
            end
            4'b0101 : begin                 // Shift Left
                ZLO <= A << 1; 
                ZHI  <= 32'd0;
            end
            4'b0100 : begin                 // Shift Right
                ZLO <= A >> 1;
                ZHI  <= 32'd0;
            end
            4'b0011 : begin                 // Divide
                DivisionAlgorithm Devide (ZLO, ZHI, A, B);
            end
            4'b0010 : begin                 // Multiply
                ZLO = A * B; 
                ZHI = {{32'd0, A} * B} >> 32;
            end
            4'b0001 : begin                 // Subract
                ZLO <= A - B; 
                ZHI  <= 32'd0;
            end
            4'b0000 : begin                 // Add
                ZLO <= A + B; 
                ZHI  <= 32'd0;
            end
            default : begin end             // Default (Do Nothing)
        endcase
    end
endmodule // ALU