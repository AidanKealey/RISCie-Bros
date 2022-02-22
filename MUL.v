// Booth Algorithm for multiplication

module MUL(cHI, cLOW, a, b, clk);
    output [31:0] cHI, cLOW;
    input signed [31:0] a, b;
    input clk;

    wire [31:0] twos_a, double_a, twos_double__a;
    reg [2:0] boi; // bits of interest

    // hold the output value
    reg [63:0] C;

    // keep count
    integer i = 0;
	 reg [0:0] j, k, p;

    // Multiplicand selected at position i
    assign twos_a = ~a + 1; // -M (or a)
    assign double_a = a + a; // +2*M ( or 2*a)
    assign twos_double_a = ~double_a + 1; // -2*M ( or -2*a)

    always @ (posedge clk) begin
		  if (b[i] == 0) begin
				j = 1'b0;
		  end
		  else begin
				j = 1'b1;
		  end
		  if (b[i+1] == 0) begin
				k = 1'b0;
		  end
		  else begin
				k = 1'b1;
		  end
        // determine the bits of interest at position i
        if (i == 0) begin
            boi = {k, j, 1'b0};
        end
        else begin
            boi = {k, j, p};
        end
        
        // preform the math
        case (boi) 
            3'b111 : begin
                C = C + 0;
            end
            3'b110 : begin
                C = C + twos_a;
            end
            3'b101 : begin
                C = C + twos_a;
            end
            3'b100 : begin
                C = C + twos_double_a;
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
	p <= k;
    end
	 // output
	 assign cLOW = C; // bottom 32-bits
    assign cHI = C >> 32; // top 32-bits
endmodule   //MUL
