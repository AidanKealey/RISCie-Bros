// Division Algorithm

module Divide (quotient, remainder, numerator, denominator);
    output [31:0] quotient, remainder;
    input [31:0] numerator, denominator;

    assign quotient = numerator/denominator;
    assign remainder = numerator%denominator;
endmodule