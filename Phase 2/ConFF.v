// Conditional Branch Instruction 

module ConFF(
    output q,
    input [3:0] IR,
    input [31:0] d,
    input conIn
);

always @ (conIn) begin
    case(IR[1:0]) 
        2'b00 : begin   // brzr -> branch if zero
            if (d == 0)
                q = 1;
            else
                q = 0;
        end
        2'b01 : begin   // brnz -> branch if nonzero
            if (d == 1)
                q = 1;
            else
                q = 0;
        end
        2'b10 : begin   // brpl -> branch if positive
            if (d > 0)
                q = 1;
            else
                q =0;
        end
        2'b11 : begin   // brmi -> branch if negative
            if (d < 0)
                q = 1;
            else
                q = 0;
        end
end
endmodule   // CONFF