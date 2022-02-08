// Arithmetic Logic Unit

module ALU (zHI, zLOW, A, B, ctrl, clr, clk, enable);
    output reg [31:0] zHI, zLOW;
    input [31:0] A, B;
	input [4:0] ctrl;
	input clr, clk, enable;

    always @ (*) begin
        case(ctrl)
            4'b1011 : begin                 // not
                zLOW <= ! A; 
                zHI  <= 32'd0;
            end
            4'b1010 : begin                 // negate
                zLOW <= ~ A; 
                zHI  <= 32'd0;
            end
            4'b1001 : begin                 // or
                zLOW <= A || B; 
                zHI  <= 32'd0;
            end
            4'b1000 : begin                 // and
                zLOW <= A & B; 
                zHI  <= 32'd0;
            end 
            4'b0111 : begin                 // rotate left
                zLOW <= {A[30:0], A[31]}; 
                zHI  <= 32'd0;
            end
            4'b0110 : begin                 // rotate right
                zLOW <= {A[0], A[31:1]}; 
                zHI  <= 32'd0;
            end
            4'b0101 : begin                 // shift left
                zLOW <= A << 1; 
                zHI  <= 32'd0;
            end
            4'b0100 : begin                 // shift right
                zLOW <= A >> 1;
                zHI  <= 32'd0;
            end
            4'b0011 : begin                 // divide
                zLOW <= A / B;              // quotient
                zHI  <= B - (A*(A/B));      // remainder
            end
            4'b0010 : begin                 // multiply
                zLOW = A * B; 
                zHI = {{32'd0, A}*B} >> 32;
            end
            4'b0001 : begin                 // subract
                zLOW <= A - B; 
                zHI  <= 32'd0;
            end
            4'b0000 : begin                 // add
                zLOW <= A + B; 
                zHI  <= 32'd0;
            end
            default : begin end             // default case (do nothing)
        endcase
    end
endmodule // ALU
