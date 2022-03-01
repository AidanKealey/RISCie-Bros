// Division Algorithm

module Divide (quotient, remainder, numerator, denominator);
    output reg [31:0] quotient, remainder;
    input [31:0] numerator, denominator;

    quotient = numerator/denominator;
    remainder = numerator%denominator;
endmodule