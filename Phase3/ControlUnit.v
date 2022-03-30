// Control Unit

module ControlUnit (
	output reg Run, Clear, Read, Write, IncPC,
   	output reg PC_Out, MDR_Out, ZHI_Out, ZLO_Out, HI_Out, LO_Out, InPort_Out,
   	output reg PC_In, MDR_In, MAR_In, IR_In, Y_In, ZHI_In, ZLO_In, HI_In, LO_In, OutPort_In, ConFF_In,
	output reg ADD, SUB, SHR, SHL, ROR, ROL, AND, OR, MUL, DIV, NEG, NOT,
   	output reg G_RA, G_RB, G_RC, R_In, R_Out, BA_Out, C_Out
	input [31:0] IR_Data,
	input Clock, Reset, Stop, 
	input ConFF_Out,
	);

	parameter reset_state = 8'b00000000, 
			  fetch0 = 8'b00000001, fetch1 = 8'b00000010, fetch2 = 8'b00000011,
			  ld3 = 8'b00000100, ld4 = 8'b00000101, ld5 = 8'b00000110, ld6 = 8'b00000111, ld7 = 8'b00001000,
			  ldi3 = 8'b00001001, ldi4 = 8'b00001010, ldi5 = 8'b00001011,
			  st3 = 8'b00001100, st4 = 8'b00001101, st5 = 8'b00001110, st6 = 8'b00001111, st7 = 8'b00010000,
			  add3 = 8'b00010001, add4 = 8'b00010010, add5 = 8'b00010011,
			  sub3 = 8'b00010100, sub4 = 8'b00010101, sub5 = 8'b00010110,
			  shr3 = 8'b00010111, shr4 = 8'b00011000, shr5 = 8'b00011001,
			  shl3 = 8'b00011010, shl4 = 8'b00011011, shl5 = 8'b00011100,
			  ror3 = 8'b00011101, ror4 = 8'b00011110, ror5 = 8'b00011111,
			  rol3 = 8'b00100000, rol4 = 8'b00100001, rol5 = 8'b00100010,
			  and3 = 8'b00100011, and4 = 8'b00100100, and5 = 8'b00100101,
			  or3 = 8'b00100110, or4 = 8'b00100111, or5 = 8'b00101000,
			  addi3 = 8'b00101001, addi4 = 8'b00101010, addi5 = 8'b00101011,
			  andi3 = 8'b00101100, andi4 = 8'b00101101, andi5 = 8'b00101110,
			  ori3 = 8'b00101111, ori4 = 8'b00110000, ori5 = 8'b00110001,
			  mul3 = 8'b00110010, mul4 = 8'b00110011, mul5 = 8'b00110100, mul6 = 8'b00110101,
			  div3 = 8'b00110110, div4 = 8'b00110111, div5 = 8'b00111000, div6 = 8'b00111001,
			  neg3 = 8'b00111010, neg4 = 8'b00111011, neg5 = 8'b00111100,
			  not3 = 8'b00111101, not4 = 8'b00111110, not5 = 8'b00111111,
			  br3 = 8'b01000000, br4 = 8'b01000001, br5 = 8'b01000010, br6 = 8'b01000011,
			  jr3 = 8'b01000100,
			  jal3 = 8'b01000101, jal4 = 8'b01000110,
			  in3 = 8'b01000111,
			  out3 = 8'b01001000,
			  mfhi3 = 8'b01001001,
			  mflo3 = 8'b01001010,
			  nop3 = 8'b01001011,
			  halt3 = 8'b01001100,
			  stop_state = 8'b11111111;

	reg [7:0] present_state = reset_state;

	always @ (posedge Clock, posedge Reset, posedge Stop) begin
		if (Reset == 1) 
			present_state = reset_state;
		else if (Stop == 1)
			present_state = halt3;
		else case (present_state)
			reset_state		:		present_state = fetch0;
			fetch0			:		present_state = fetch1; 
			fetch1			:		present_state = fetch2;
			fetch2			:		begin
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
											5'b00110		:		present_state = shl3;
											5'b00101		:		present_state = shr3;
											5'b00100		:		present_state = sub3;
											5'b00011		:		present_state = add3;
											5'b00010		:		present_state = st3;
											5'b00001		:		present_state = ldi3;
											5'b00000		:		present_state = ld3;
										endcase
									end
			// --------------------------------------------------
			ld3				:		present_state = ld4;
			ld4				:		present_state = ld5;
			ld5				:		present_state = ld6;
			ld6				:		present_state = ld7;
			ld7				:		present_state = fetch0;
			// --------------------------------------------------
			ldi3			:		present_state = ldi4;
			ldi4			:		present_state = ldi5;
			ldi5			:		present_state = fetch0;
			// --------------------------------------------------
			st3				:		present_state = st4;
			st4				:		present_state = st5;
			st5				:		present_state = st6;
			st6				:		present_state = st7;
			ld7				:		present_state = fetch0;
			// --------------------------------------------------
			add3			:		present_state = add4;
			add4			:		present_state = add5;
			add5			:		present_state = fetch0;
			// --------------------------------------------------
			sub3			:		present_state = sub4;
			sub4			:		present_state = sub5;
			sub5			:		present_state = fetch0;
			// --------------------------------------------------
			shr3			:		present_state = shr4;
			shr4			:		present_state = shr5;
			shr5			:		present_state = fetch0;
			// --------------------------------------------------
			shl3			:		present_state = shl4;
			shl4			:		present_state = shl5;
			shl5			:		present_state = fetch0;
			// --------------------------------------------------
			ror3			:		present_state = ror4;
			ror4			:		present_state = ror5;
			ror5			:		present_state = fetch0;
			// --------------------------------------------------
			rol3			:		present_state = rol4;
			rol4			:		present_state = rol5;
			rol5			:		present_state = fetch0;
			// --------------------------------------------------
			and3			:		present_state = and4;
			and4			:		present_state = and5;
			and5			:		present_state = fetch0;
			// --------------------------------------------------
			or3				:		present_state = or4;
			or4				:		present_state = or5;
			or5				:		present_state = fetch0;
			// --------------------------------------------------
			addi3			:		present_state = addi4;
			addi4			:		present_state = addi5;
			addi5			:		present_state = fetch0;
			// --------------------------------------------------
			andi3			:		present_state = andi4;
			andi4			:		present_state = andi5;
			andi5			:		present_state = fetch0;
			// --------------------------------------------------
			ori3			:		present_state = ori4;
			ori4			:		present_state = ori5;
			ori5			:		present_state = fetch0;
			// --------------------------------------------------
			mul3			:		present_state = mul4;
			mul4			:		present_state = mul5;
			mul5			:		present_state = mul6;
			mul6			:		present_state = fetch0;
			// --------------------------------------------------
			div3			:		present_state = div4;
			div4			:		present_state = div5;
			div5			:		present_state = div6;
			div6			:		present_state = fetch0;
			// --------------------------------------------------
			neg3			:		present_state = neg4;
			neg4			:		present_state = neg5;
			neg5			:		present_state = fetch0;
			// --------------------------------------------------
			not3			:		present_state = not4;
			not4			:		present_state = not5;
			not5			:		present_state = fetch0;
			// --------------------------------------------------
			br3				:		present_state = br4;
			br4				:		present_state = br5;
			br5				:		present_state = br6;
			br6				:		present_state = fetch0;
			// --------------------------------------------------
			jr3				:		present_state = fetch0;
			// --------------------------------------------------
			jal3			:		present_state = jal4;
			jal4			:		present_state = fetch0;
			// --------------------------------------------------
			in3				:		present_state = fetch0;
			// --------------------------------------------------
			out3			:		present_state = fetch0;
			// --------------------------------------------------
			mfhi3			:		present_state = fetch0;
			// --------------------------------------------------
			mflo3			:		present_state = fetch0;
			// --------------------------------------------------
			nop3			:		present_state = fetch0;
			// --------------------------------------------------
			halt3			:		present_state = stop_state;
			// --------------------------------------------------
		endcase
	end

	always @ (present_state) begin
		case (present_state)
			reset_state	: begin
				Run <= 1; Clear <= 0; Read <= 0; Write <= 0; IncPC <= 0;
   				PC_Out <= 0; MDR_Out <= 0; ZHI_Out <= 0; ZLO_Out <= 0; HI_Out <= 0; LO_Out <= 0; InPort_Out <= 0; ConFF_Out <= 0;
   				PC_In <= 0; MDR_In <= 0; MAR_In <= 0; IR_In <= 0; Y_In <= 0; ZHI_In <= 0; ZLO_In <= 0; HI_In <= 0; LO_In <= 0; InPort_In <= 0; OutPort_In <= 0; ConFF_In <= 0;
   				G_RA <= 0; G_RB <= 0; G_RC <= 0; R_In <= 0; R_Out <= 0; BA_Out <= 0; C_Out <= 0;
				ADD <= 0; SUB <= 0; SHR <= 0; SHL <= 0; ROR <= 0; ROL <= 0; AND <= 0; OR <= 0; MUL <= 0; DIV <= 0; NEG <= 0; NOT <= 0;
				Reset <= 0; Stop <= 0;
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
            ldi5, addi5, andi5, ori : begin
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
			mul6, div6 : begin
				ZLO_Out <= 1; LO_In <= 1;
				#20 ZLO_Out <= 0; LO_In <= 0;
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
			end
			br4 : begin
				PC_Out <= 1; Y_In <= 1; ConFF_In <= 0;
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