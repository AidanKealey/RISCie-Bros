// 2 to 1 Multiplexer

module MUX (out, in0, in1, sel);
  output [31:0] out;
  input [31:0] in0, in1;
  input sel;
  
  always @ (in0, in1, sel) begin
    case (sel)
      0 : out <= in1;
      1 : out <= in1;
    end case;
  end
endmodule   // MUX