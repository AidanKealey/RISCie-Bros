// Control Unit

`timescale 1ns/10ps
module ControlUnit (
	output reg Run, Clear, Read, Write, IncPC,
   output reg PC_Out, MDR_Out, ZHI_Out, ZLO_Out, HI_Out, LO_Out, InPort_Out,
  	output reg PC_In, MDR_In, MAR_In, IR_In, Y_In, ZHI_In, ZLO_In, HI_In, LO_In, OutPort_In, ConFF_In,
	output reg ADD, SUB, SHR, SHL, ROR, ROL, AND, OR, MUL, DIV, NEG, NOT,
  	output reg G_RA, G_RB, G_RC, R_In, R_Out, BA_Out, C_Out,
	input [31:0] IR_Data,
	input Clock, Reset, Stop, 
	input ConFF_Out
	);

	parameter reset_state = 0, 
		fetch0 = 1, fetch1 = 2, fetch2 = 3,
		ld3 = 4, ld4 = 5, ld5 = 6, ld6 = 7, ld7 = 8,
		ldi3 = 9, ldi4 = 10, ldi5 = 11,
		st3 = 12, st4 = 13, st5 = 14, st6 = 15, st7 = 16,
		add3 = 17, add4 = 18, add5 = 19,
		sub3 = 20, sub4 = 21, sub5 = 22,
		shr3 = 23, shr4 = 24, shr5 = 25,
		shl3 = 26, shl4 = 27, shl5 = 28,
		ror3 = 29, ror4 = 30, ror5 = 31,
		rol3 = 32, rol4 = 33, rol5 = 34,
		and3 = 35, and4 = 36, and5 = 37,
		or3 = 38, or4 = 39, or5 = 40,
		addi3 = 41, addi4 = 42, addi5 = 43,
		andi3 = 44, andi4 = 45, andi5 = 46,
		ori3 = 47, ori4 = 48, ori5 = 49,
		mul3 = 50, mul4 = 51, mul5 = 52, mul6 = 53,
		div3 = 54, div4 = 55, div5 = 56, div6 = 57,
		neg3 = 58, neg4 = 59, neg5 = 60,
		not3 = 61, not4 = 62, not5 = 63,
		br3 = 64, br4 = 65, br5 = 66, br6 = 67,
		jr3 = 68,
		jal3 = 69, jal4 = 70,
		in3 = 71,
		out3 = 72,
		mfhi3 = 73,
		mflo3 = 74,
		nop3 = 75,
		halt3 = 76,
		stop_state = -1;

	reg [7:0] present_state = reset_state;

	always @ (posedge Clock, posedge Reset, posedge Stop) begin
		if (Reset == 1) 
			present_state = reset_state;
		else if (Stop == 1)
			present_state = halt3;
		else case (present_state)
			reset_state		:		#40 present_state = fetch0;
			fetch0			:		#40 present_state = fetch1; 
			fetch1			:		#40 present_state = fetch2;
			fetch2			:		#40 begin
												case (IR_Data[31:27])
													5'b11010		:		present_state = halt3;
													5'b11001		:		present_state = nop3;
													5'b11000		:		present_state = mflo3;
													5'b10111		:		present_state = mfhi3;
													5'b10110		:		present_state = out3;
													5'b10101		:		present_state = in3;
													5'b10100		:		present_state = jal3;
													5'b10011		:		present_state = jr3;
													5'b10010		:		present_state = br3;
													5'b10001		:		present_state = not3;
													5'b10000		:		present_state = neg3;
													5'b01111		:		present_state = div3;
													5'b01110		:		present_state = mul3;
													5'b01101		:		present_state = ori3;
													5'b01100		:		present_state = andi3;
													5'b01011		:		present_state = addi3;
													5'b01010		:		present_state = or3;
													5'b01001		:		present_state = and3;
													5'b01000		:		present_state = rol3;
													5'b00111		:		present_state = ror3;
													5'b00110		:	 	present_state = shl3;
													5'b00101		:		present_state = shr3;
													5'b00100		:		present_state = sub3;
													5'b00011		:		present_state = add3;
													5'b00010		:		present_state = st3;
													5'b00001		:		present_state = ldi3;
													5'b00000		:		present_state = ld3;
												endcase
											 end
			// --------------------------------------------------
			ld3				:		#40 present_state = ld4;
			ld4				:		#40 present_state = ld5;
			ld5				:		#40 present_state = ld6;
			ld6				:		#40 present_state = ld7;
			ld7				:		#40 present_state = fetch0;
			// --------------------------------------------------
			ldi3				:		#40 present_state = ldi4;
			ldi4				:		#40 present_state = ldi5;
			ldi5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			st3				:		#40 present_state = st4;
			st4				:		#40 present_state = st5;
			st5				:		#40 present_state = st6;
			st6				:		#40 present_state = st7;
			st7				:		#40 present_state = fetch0;
			// --------------------------------------------------
			add3				:		#40 present_state = add4;
			add4				:		#40 present_state = add5;
			add5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			sub3				:		#40 present_state = sub4;
			sub4				:		#40 present_state = sub5;
			sub5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			shr3				:		#40 present_state = shr4;
			shr4				:		#40 present_state = shr5;
			shr5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			shl3				:		#40 present_state = shl4;
			shl4				:		#40 present_state = shl5;
			shl5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			ror3				:		#40 present_state = ror4;
			ror4				:		#40 present_state = ror5;
			ror5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			rol3				:		#40 present_state = rol4;
			rol4				:		#40 present_state = rol5;
			rol5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			and3				:		#40 present_state = and4;
			and4				:		#40 present_state = and5;
			and5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			or3				:		#40 present_state = or4;
			or4				:		#40 present_state = or5;
			or5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			addi3				:		#40 present_state = addi4;
			addi4				:		#40 present_state = addi5;
			addi5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			andi3				:		#40 present_state = andi4;
			andi4				:		#40 present_state = andi5;
			andi5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			ori3				:		#40 present_state = ori4;
			ori4				:		#40 present_state = ori5;
			ori5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			mul3				:		#40 present_state = mul4;
			mul4				:		#40 present_state = mul5;
			mul5				:		#40 present_state = mul6;
			mul6				:		#40 present_state = fetch0;
			// --------------------------------------------------
			div3				:		#40 present_state = div4;
			div4				:		#40 present_state = div5;
			div5				:		#40 present_state = div6;
			div6				:		#40 present_state = fetch0;
			// --------------------------------------------------
			neg3				:		#40 present_state = neg4;
			neg4				:		#40 present_state = neg5;
			neg5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			not3				:		#40 present_state = not4;
			not4				:		#40 present_state = not5;
			not5				:		#40 present_state = fetch0;
			// --------------------------------------------------
			br3				:		#40 present_state = br4;
			br4				:		#40 present_state = br5;
			br5				:		#40 present_state = br6;
			br6				:		#40 present_state = fetch0;
			// --------------------------------------------------
			jr3				:		#40 present_state = fetch0;
			// --------------------------------------------------
			jal3				:		#40 present_state = jal4;
			jal4				:		#40 present_state = fetch0;
			// --------------------------------------------------
			in3				:		#40 present_state = fetch0;
			// --------------------------------------------------
			out3				:		#40 present_state = fetch0;
			// --------------------------------------------------
			mfhi3				:		#40 present_state = fetch0;
			// --------------------------------------------------
			mflo3				:		#40 present_state = fetch0;
			// --------------------------------------------------
			nop3				:		#40 present_state = fetch0;
			// --------------------------------------------------
			halt3				:		#40 present_state = stop_state;
			// --------------------------------------------------
		endcase
	end

	always @ (present_state) begin
		case (present_state)
			reset_state	: begin
				Run <= 1; Clear <= 0; Read <= 0; Write <= 0; IncPC <= 0;
   			PC_Out <= 0; MDR_Out <= 0; ZHI_Out <= 0; ZLO_Out <= 0; HI_Out <= 0; LO_Out <= 0; InPort_Out <= 0;
   			PC_In <= 0; MDR_In <= 0; MAR_In <= 0; IR_In <= 0; Y_In <= 0; ZHI_In <= 0; ZLO_In <= 0; HI_In <= 0; LO_In <= 0; OutPort_In <= 0; ConFF_In <= 0;
   			G_RA <= 0; G_RB <= 0; G_RC <= 0; R_In <= 0; R_Out <= 0; BA_Out <= 0; C_Out <= 0;
				ADD <= 0; SUB <= 0; SHR <= 0; SHL <= 0; ROR <= 0; ROL <= 0; AND <= 0; OR <= 0; MUL <= 0; DIV <= 0; NEG <= 0; NOT <= 0;
				#20 Clear <= 1;
			end
			fetch0 : begin
				PC_Out <= 1; MAR_In <= 1;
				#20 PC_Out <= 0; MAR_In <= 0;
         end 
         fetch1 : begin
            Read <= 1; MDR_In <= 1;
				#20 Read <= 0; MDR_In <= 0;
			end 
        	fetch2 : begin
            MDR_Out <= 1; IR_In <= 1; IncPC <= 1;
				#20 MDR_Out <= 0; IR_In <= 0; IncPC <= 0;
			end
			// --------------------------------------------------
			ld3, ldi3, st3 : begin
				G_RB <= 1; BA_Out <= 1; Y_In <= 1;
				#20 G_RB <= 0; BA_Out <= 0; Y_In <= 0;
			end
			ld4, ldi4, st4, addi4, br5 : begin
				C_Out <= 1; ADD <= 1; ZLO_In <= 1;
				#20 C_Out <= 0; ADD <= 0; ZLO_In <= 0;
			end
			ld5, st5 : begin
				ZLO_Out <= 1; MAR_In <= 1;
				#20 ZLO_Out <= 0; MAR_In <= 0;
			end
			ld6 : begin
				Read <= 1; MDR_In <= 1;
				#20 Read <= 0; MDR_In <= 0;
			end
			ld7 : begin
				MDR_Out <= 1; G_RA <= 1; R_In <= 1;
				#20 MDR_Out <= 0; G_RA <= 0; R_In <= 0; 
			end
			// --------------------------------------------------
         ldi5, addi5, andi5, ori5 : begin
            ZLO_Out <= 1; G_RA <= 1; R_In <= 1;
			   #20 ZLO_Out <= 0; G_RA <= 0; R_In <= 0;
         end
			// --------------------------------------------------
         st6 : begin
            G_RA <= 1; BA_Out <= 1; MDR_In <= 1;
			   #20 G_RA <= 0; BA_Out <= 0; MDR_In <= 0;
         end
         st7: begin
            Write <= 1; MDR_Out <= 1;
				#20 Write <= 0; MDR_Out <= 0;
         end
			// --------------------------------------------------
			add3, sub3, shr3, shl3, ror3, rol3, and3, or3, addi3, andi3, ori3, neg3, not3 : begin
				G_RB <= 1; R_Out <= 1; Y_In <= 1;
				#20 G_RB <= 0; R_Out <= 0; Y_In <= 0;
			end
			add4 : begin
				G_RC <= 1; R_Out <= 1; ADD <= 1; ZLO_In <= 1;
				#20 G_RC <= 0; R_Out <= 0; ADD <= 0; ZLO_In <= 0;
			end
			add5, sub5, shr5, shl5, ror5, rol5, and5, or5, neg5, not5 : begin
				G_RA <= 1; R_In <= 1; ZLO_Out <= 1;
				#20 G_RA <= 0; R_In <= 0; ZLO_Out <= 0;
			end
			// --------------------------------------------------
			sub4 : begin
				G_RC <= 1; R_Out <= 1; SUB <= 1; ZLO_In <= 1;
				#20 G_RC <= 0; R_Out <= 0; SUB <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			shr4 : begin
				G_RC <= 1; R_Out <= 1; SHR <= 1; ZLO_In <= 1;
				#20 G_RC <= 0; R_Out <= 0; SHR <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			shl4 : begin
				G_RC <= 1; R_Out <= 1; SHL <= 1; ZLO_In <= 1;
				#20 G_RC <= 0; R_Out <= 0; SHL <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			ror4 : begin
				G_RC <= 1; R_Out <= 1; ROR <= 1; ZLO_In <= 1;
				#20 G_RC <= 0; R_Out <= 0; ROR <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			rol4 : begin
				G_RC <= 1; R_Out <= 1; ROL <= 1; ZLO_In <= 1;
				#20 G_RC <= 0; R_Out <= 0; ROL <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			and4 : begin
				G_RC <= 1; R_Out <= 1; AND <= 1; ZLO_In <= 1;
				#20 G_RC <= 0; R_Out <= 0; AND <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			or4 : begin
				G_RC <= 1; R_Out <= 1; OR <= 1; ZLO_In <= 1;
				#20 G_RC <= 0; R_Out <= 0; OR <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
         andi4 : begin
            	C_Out <= 1; AND <= 1; ZLO_In <= 1;
				#20 C_Out <= 0; AND <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			ori4 : begin
            	C_Out <= 1; OR <= 1; ZLO_In <= 1;
				#20 C_Out <= 0; OR <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			mul3, div3 : begin
				G_RA <= 1; R_Out <= 1; Y_In <= 1;
				#20 G_RA <= 0; R_Out <= 0; Y_In <= 0;
			end
			mul4 : begin
				G_RB <= 1; R_Out <= 1; MUL <= 1; ZHI_In <= 1; ZLO_In <= 1;
				#20 G_RB <= 0; R_Out <= 0; MUL <= 0; ZHI_In <= 0; ZLO_In <= 0;
			end
			mul5, div5 : begin
				ZHI_Out <= 1; HI_In <= 1;
				#20 ZHI_Out <= 0; HI_In <= 0;
			end
			mul6, div6 : begin
				ZLO_Out <= 1; LO_In <= 1;
				#20 ZLO_Out <= 0; LO_In <= 0;
			end
			// --------------------------------------------------
			div4 : begin
				G_RB <= 1; R_Out <= 1; DIV <= 1; ZHI_In <= 1; ZLO_In <= 1;
				#20 G_RB <= 0; R_Out <= 0; DIV <= 0; ZHI_In <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			neg4 : begin
				NEG <= 1; ZLO_In <= 1;
				#20 NEG <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			not4 : begin
				NOT <= 1; ZLO_In <= 1;
				#20 NOT <= 0; ZLO_In <= 0;
			end
			// --------------------------------------------------
			br3 : begin
				G_RA <= 1; R_Out <= 1; ConFF_In <= 1;
				#20 G_RA <= 0; R_Out <= 0; ConFF_In <= 0;
			end
			br4 : begin
				PC_Out <= 1; Y_In <= 1;
				#20 PC_Out <= 0; Y_In <= 0;
			end
			br6 : begin		  
				if (ConFF_Out) begin
					ZLO_Out <= 1; PC_In <= 1;
					#20 ZLO_Out <= 0; PC_In <= 0;
				end
			end
			// --------------------------------------------------
			jr3, jal4 : begin
				G_RA <= 1; R_Out <= 1; PC_In <= 1;
				#20 G_RA <= 0; R_Out <= 0; PC_In <= 0;
			end
			// --------------------------------------------------
         jal3 : begin
				G_RB <= 1; R_In <= 1; PC_Out <= 1;
				#20 G_RB <= 0; R_In <= 0; PC_Out <= 0;
         end
			// --------------------------------------------------
			in3 : begin
				G_RA <= 1; R_In <= 1; InPort_Out <= 1;
				#20 G_RA <= 0; R_In <= 0; InPort_Out <= 0;
			end
			// --------------------------------------------------
			out3 : begin
				G_RA <= 1; R_Out <= 1; OutPort_In <= 1;
				#20 G_RA <= 0; R_Out <= 0; OutPort_In <= 0;
			end
			// --------------------------------------------------
			mfhi3 : begin
				G_RA <= 1; R_In <= 1; HI_Out <= 1;
				#20 G_RA <= 0; R_In <= 0; HI_Out <= 0;
			end
			// --------------------------------------------------
			mflo3 : begin
				G_RA <= 1; R_In <= 1; LO_Out <= 1;
				#20 G_RA <= 0; R_In <= 0; LO_Out <= 0;
			end
			// --------------------------------------------------
			nop3, stop_state: begin
				// no operation
			end
			// --------------------------------------------------
			halt3 : begin
				Run <= 0;
			end
		endcase
	end
endmodule // ControlUnit