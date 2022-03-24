// Out Port Test Bench
// out	R1 -> 0xB0800000
`timescale 1ns/10ps
module out_tb;
   reg [4:0] ctrl;
   reg clk, clr, IncPC, Read;
   reg PCout, MDRout, OutPort_In;
   reg PCin, MDRin, MARin, IRin;   
   reg G_RA, R_Out;

   wire [31:0] BusMux_Out;

   parameter Default = 4'b0000, 
             T0 = 4'b0001, T1 = 4'b0010, T2 = 4'b0011, T3 = 4'b0100, T4 = 4'b0101;

   reg [3:0] Present_state = Default;

   Datapath DUT (.CONTROL(ctrl), 
                 .Clock(clk), .Clear(clr), .IncPC(IncPC), .Read(Read), 
                 .PC_Out(PCout), .MDR_Out(MDRout), .OutPort_In(OutPort_In),
                 .PC_In(PCin), .MDR_In(MDRin), .MAR_In(MARin), .IR_In(IRin),
                 .G_RA(G_RA), .R_Out(R_Out),
                 .BusMux_Out(BusMux_Out)
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
          endcase 
      end
	
   always @ (Present_state) // execute each state
      begin 
         case (Present_state)
            Default: begin
               ctrl <= 0; 
               clr <= 1; IncPC <= 0; Read <= 0;
               PCout <= 0; MDRout <= 0; OutPort_In <= 0;
               PCin <=0; MDRin <= 0; MARin <= 0; IRin <= 0;
               G_RA <= 0; R_Out <= 0;
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
			   	G_RA <= 1; R_Out <= 1; OutPort_In <= 1;
               end
            T4: begin
               G_RA <= 0; R_Out <= 0; OutPort_In <= 0;
               end
			endcase 
		end 
endmodule // out_tb