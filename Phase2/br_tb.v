// Branch Test Bench 
// brzr	R2, 35 -> 0x91000023
// brnz	R2, 35 -> 0x91080023
// brpl	R2, 35 -> 0x91100023
// brmi	R2, 35 -> 0x91180023
`timescale 1ns/10ps 
module br_tb;
   reg [4:0] ctrl;
   reg clk, clr, IncPC, Read;
   reg PCout, MDRout, ZLOout, C_Out;
   reg PCin, MDRin, MARin, IRin, Yin, ZLOin, Con_In;   
   reg G_RA, R_In, R_Out; 

   wire [31:0] BusMux_Out;
	wire ConFF_Out;

   parameter Default = 4'b0000, 
             T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, T3 = 4'b0100, T4 = 4'b0101, T5 = 4'b0110, T6 = 4'b0111, T7 = 4'b1000;

   reg [3:0] Present_state = Default;

   Datapath DUT (.CONTROL(ctrl), 
                 .Clock(clk), .Clear(clr), .IncPC(IncPC), .Read(Read), 
                 .PC_Out(PCout), .MDR_Out(MDRout), .ZLO_Out(ZLOout), .C_Out(C_Out),
                 .PC_In(PCin), .MDR_In(MDRin), .MAR_In(MARin), .IR_In(IRin), .Y_In(Yin), .ZLO_In(ZLOin), .Con_In(Con_In),
                 .G_RA(G_RA), .R_In(R_In), .R_Out(R_Out),
                 .BusMux_Out(BusMux_Out), .ConFF_Out(ConFF_Out)
                );

   initial
		begin 
      clk = 0; 
      forever #10 clk = ~ clk; 
   end 
 
   always @ (posedge clk) // finite state machine 
      begin 
         case (Present_state) 
            Default     :   #40 Present_state = T0;
            T0          :   #40 Present_state = T1;
            T1          :   #40 Present_state = T2;
            T2          :   #40 Present_state = T3;
            T3          :   #40 Present_state = T4;
				T4          :   #40 Present_state = T5;
            T5          :   #40 Present_state = T6;
            T6          :   #40 Present_state = T7;
         endcase 
      end

	always @ (Present_state) // execute each state
      begin 
         case (Present_state)
            Default: begin
					ctrl <= 0; 
               clr <= 1; IncPC <= 0; Read <= 0;
               PCout <= 0; MDRout <= 0; ZLOout <= 0; C_Out <= 0;
               PCin <=0; MDRin <= 0; MARin <= 0; IRin <= 0; Yin <= 0; ZLOin <= 0; Con_In <= 0;
               G_RA <= 0; R_In <= 0; R_Out <= 0;
               end 
            T0: begin
               IncPC <= 1; PCout <= 1; MARin <= 1;
               #20 IncPC <= 0;
               end 
            T1: begin
               PCout <= 0; MARin <= 0;
               Read <= 1; MDRin <= 1;
					end 
            T2: begin
               Read <= 0; MDRin <= 0;
               MDRout <= 1; IRin <= 1;
               end 
            T3: begin
               MDRout <= 0; IRin <= 0;
               G_RA <= 1; R_Out <= 1; Con_In <= 1;
               end
            T4: begin
               G_RA <= 0; R_Out <= 0; Con_In <= 0;
					PCout <= 1; Yin <= 1;
               end
            T5: begin
					PCout <= 0; Yin <= 0;
					C_Out <= 1; ctrl <= 5'b00000; ZLOin <= 1;
               end
            T6: begin
				   C_Out <= 0; ZLOin <= 0;
					ZLOout <= 1;
						  
					if (ConFF_Out) begin
						PCin <= 1;
						#20 PCin <= 0;
						IncPC <= 1;
						#20 IncPC <= 0;
						end
					end
				T7: begin
					ZLOout <= 0;
               end
			endcase 
		end 
endmodule // br_tb