// Booth Algorithm for multiplication

module MUL(C, A, B);
    output [63:0] C;
    input signed [31:0] A, B;

    reg [2:0] XXX[15:0];
    reg [32:0] YYY[15:0];
    reg [31:0] ZZZ[15:0];

    reg [31:0] P;

    interger r, q;

    wire [32:0] a;
    assign a = {~A[31], ~A}+1;

    always @ (*) begin
        XXX[0] = {b[1], b[0], 1'b0};
        

endmodule   //MUL