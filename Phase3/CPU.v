// Mini SRC CPU

module CPU (output [31:0] Output_Data,
            output Run,
            input [31:0] Input_Data,
            input Clock, Reset, Stop
           );

    wire [31:0] RAM_Data;

    // Datapath
    Datapath Datapath (Output_Data,
				       IR_Data,
				       BusMux_In_MDR,
				       MAR_Data,
   				       ConFF_Out,
   				       Input_Data,
                       RAM_Data
   				       Clear, Clock, Read, Write, IncPC,
  				       PC_Out, MDR_Out, ZHI_Out, ZLO_Out, HI_Out, LO_Out, C_Out, InPort_Out,
   				       PC_In, MDR_In, MAR_In, IR_In, Y_In, ZHI_In, ZLO_In, HI_In, LO_In, InPort_In, OutPort_In, ConFF_In,
                       ADD, SUB, SHR, SHL, ROR, ROL, AND, OR, MUL, DIV, NEG, NOT,
   				       G_RA, G_RB, G_RC, R_In, R_Out, BA_Out   
                       );

    // Control Unit
    ControlUnit ControlUnit (Run, Clear, Read, Write, IncPC,
   	                         PC_Out, MDR_Out, ZHI_Out, ZLO_Out, HI_Out, LO_Out, InPort_Out,
                             PC_In, MDR_In, MAR_In, IR_In, Y_In, ZHI_In, ZLO_In, HI_In, LO_In, OutPort_In, ConFF_In,
                             ADD, SUB, SHR, SHL, ROR, ROL, AND, OR, MUL, DIV, NEG, NOT,
                             G_RA, G_RB, G_RC, R_In, R_Out, BA_Out, C_Out
	                         IR_Data,
	                         Clock, Reset, Stop, 
                             ConFF_Out
                            );

    // Random Access Memory
	RAM RAM (.address(MAR_Data), .clock(Clock), .data(BusMux_In_MDR), .wren(Write), .q(RAM_Data));

endmodule // CPU