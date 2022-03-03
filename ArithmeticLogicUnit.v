// Arithmetic Logic Unit

module ArithmeticLogicUnit (zHI, zLOW, A, B, ctrl, clr, clk, enable);
    output reg [31:0] zHI, zLOW;
    input [31:0] A, B;
	input [4:0] ctrl;
	input clr, clk, enable;

    wire [31:0] moutHI, moutLOW, doutHI, doutLOW;

    always @ (*) begin
        case(ctrl)
            5'b01011 : begin                 // not
                zLOW <= ~ A; 
                zHI  <= 32'd0;
            end
            5'b01010 : begin                 // negate
                zLOW <= ~ A + 1; 
                zHI  <= 32'd0;
            end
            5'b01001 : begin                 // or
                zLOW <= A | B; 
                zHI  <= 32'd0;
            end
            5'b01000 : begin                 // and
                zLOW <= A & B; 
                zHI  <= 32'd0;
            end 
            5'b00111 : begin                 // rotate left
                zLOW <= {A[30:0], A[31]}; 
                zHI  <= 32'd0;
            end
            5'b00110 : begin                 // rotate right
                zLOW <= {A[0], A[31:1]}; 
                zHI  <= 32'd0;
            end
            5'b00101 : begin                 // shift left
                zLOW <= A << 1; 
                zHI  <= 32'd0;
            end
            5'b00100 : begin                 // shift right
                zLOW <= A >> 1;
                zHI  <= 32'd0;
            end
            5'b00011 : begin                 // divide
                zLOW <= doutLOW[31:0];              // quotient
                zHI  <= doutHI[31:0];      // remainder
            end
            5'b00010 : begin                 // multiply
                zLOW <= moutLOW[31:0];
                zHI <= moutHI[31:0];
            end
            5'b00001 : begin                 // subract
                zLOW <= A - B; 
                zHI  <= 32'd0;
            end
            5'b00000 : begin                 // add
                zLOW <= A + B; 
                zHI  <= 32'd0;
            end
            default : begin end             // default case (do nothing)
        endcase
    end

    // operations
    MUL mul(moutHI, moutLOW, A, B, clk);
    Division div(doutHI, doutLOW, A, B);
endmodule // ALU