// Booth Algorithm for multiplication

module MUL(cHI, cLow, a, b, clk);
    output reg [31:0] cHI, cLOW;
    input signed [31:0] a, b;
    input clk;

    wire [31:0] neg_a, pos_two_a, neg_two_a;
    wire [2:0] boi; // bits of interest

    // hold the output value
    wire reg [63:0] C;

    // keep count
    interger i = 0;

    // Multiplicand selected at position i
    assign twos_a = ~a + 1; // -M (or a)
    assign double_a = a + a; // +2*M ( or 2*a)
    assign twos_double_a = ~double_a + 1; // -2*M ( or -2*a)

    // output
    assign cHI = C >> 32; // top 32-bits
    assign cLOW = C; // bottom 32-bits

    always @ (posedge clk) begin
        // determine the bits of interest at position i
        if (i == 0) begin
            boi = {b[i+1], b[i], 0};
        end
        else begin
            boi = {b[i+1], b[i], b[i-1]};
        end
        
        // preform the math
        case (boi) 
            3'b111 : begin
                C = C + 0;
            end
            3'b110 : begin
                C = C + tows_a;
            end
            3'b101 : begin
                C = C + tows_a;
            end
            3b'100 : begin
                C = C + tows_double_a;
            end
            3'b011 : begin
                C = C + double_a;
            end
            3'b010 : begin
                C  = C + a;
            end
            3'b001 : begin
                C = C + a;
            end
            3'b000 : begin
                C = C + 0;
            end
            default : begin end
        endcase
        i = i + 2;
    end
endmodule   //MUL