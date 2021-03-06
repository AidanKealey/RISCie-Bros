// Arithmetic Logic Unit

module ALU (ZHI, ZLO, A, B, ctrl, clr, clk, enable);
    output reg [31:0] ZHI, ZLO;
    input [31:0] A, B;
    input [4:0] ctrl;
    input clr, clk, enable;

    reg [63:0] C;
    wire [31:0] ROL_Out;
    wire [31:0] ROR_Out;

    ROL ROL (.C(ROL_Out), .A(A), .B(B));
    ROR ROR (.C(ROR_Out), .A(A), .B(B));

    always @ (*) begin
        case(ctrl)
            5'b01011 : begin                // not
                ZLO <= ~ A; 
                ZHI <= 32'd0;
            end
            5'b01010 : begin                // negate
                ZLO <= ~ A + 1; 
                ZHI <= 32'd0;
            end
            5'b01001 : begin                // or
                ZLO <= A | B; 
                ZHI <= 32'd0;
            end
            5'b01000 : begin                // and
                ZLO <= A & B; 
                ZHI  <= 32'd0;
            end 
            5'b00111 : begin                // rotate left
                ZLO <= ROL_Out; 
                ZHI <= 32'd0;
            end
            5'b00110 : begin                // rotate right
                ZLO <= ROR_Out; 
                ZHI <= 32'd0;
            end
            5'b00101 : begin                // shift left
                ZLO <= A << B; 
                ZHI <= 32'd0;
            end
            5'b00100 : begin                // shift right
                ZLO <= A >> B;
                ZHI <= 32'd0;
            end
            5'b00011 : begin                // divide
                ZLO = A / B;                // quotient
                ZHI = A % B;                // remainder
            end
            5'b00010 : begin                // multiply
                C = A * B;
                ZLO <= C[31:0];
                ZHI <= C[63:32];
            end
            5'b00001 : begin                // subract
                ZLO <= A - B; 
                ZHI <= 32'd0;
            end
            5'b00000 : begin                // add
                ZLO <= A + B; 
                ZHI <= 32'd0;
            end
            default : begin end             // default case (do nothing)
        endcase
    end
endmodule // ALU