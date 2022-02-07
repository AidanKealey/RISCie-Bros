// Arithmetic Logic Unit

module ALU (outALU, A, B, ctrl, clr, clk, enable);
    output [63:0] outALU;
    input [63:0] A, B;
    input [4:0] ctrl;

    wire [63:0] C;
    Register64 Y (.q (outALU), .d (C), .clr (clr), .clk (clk), .enable (enable));

    always @ (*) begin
        case(ctrl)
            5'b0000 : C = A + B; // add
            5'b0001 : C = A - B; // subract
            5'b0010 : C = A * B; // multiply
            5'b0011 : C = A / B; // devide
            5'b0100 : C = A >> 1; // shift right
            5'b0101 : C = A << 1; // shift left
            5'b0110 : C = {A[0], A[31:1]}; // rotate right
            5'b0111 : C = {A[30:0], A[31]}; // rotate left
            5'b1000 : C = A & B; // and
            5'b1001 : C = A || B; // or
            5'b1010 : C = ~ A; // negate
            5'b1011 : C = ! A; // not
            default = x;
        endcase
    end
endmodule // ALU