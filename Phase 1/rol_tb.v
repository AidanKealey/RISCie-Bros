// Rotate Left Test Bench
`timescale 1ns/10ps 
module rol_tb;
    reg [31:0] Mdatain;
    reg [4:0] ctrl;
    reg clk, clr, IncPC, Read;
    reg PCout, MDRout, ZLOout;
    reg PCin, MDRin, MARin, IRin, Yin, ZLOin;
    reg R2out, R4out;    
    reg R2in, R4in, R5in;  
 
    wire [31:0] BusMux_Out;
 
    parameter Default = 4'b0000, 
              Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,  
              T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;

    reg [3:0] Present_state = Default;

    Datapath DUT(.MData_In(Mdatain), 
                 .CONTROL(ctrl), 
                 .Clock(clk), .Clear(clr), .IncPC(IncPC), .Read(Read), 
                 .PC_Out(PCout), .MDR_Out(MDRout), .ZLO_Out(ZLOout), 
                 .PC_In(PCin), .MDR_In(MDRin), .MAR_In(MARin), .IR_In(IRin), .Y_In(Yin), .ZLO_In(ZLOin), 
                 .R2_Out(R2out), .R4_Out(R4out), 
                 .R2_In(R2in), .R4_In(R4in), .R5_In(R5in),
                 .BusMux_Out(BusMux_Out)
                );

    initial  
        begin 
        clk = 0; 
        forever #10 clk = ~ clk; 
    end 
 
    always @(posedge clk) // finite state machine 
        begin 
            case (Present_state) 
                Default     :   #40 Present_state = Reg_load1a; 
                Reg_load1a  :   #40 Present_state = Reg_load1b; 
                Reg_load1b  :   #40 Present_state = Reg_load2a; 
                Reg_load2a  :   #40 Present_state = Reg_load2b; 
                Reg_load2b  :   #40 Present_state = Reg_load3a; 
                Reg_load3a  :   #40 Present_state = Reg_load3b; 
                Reg_load3b  :   #40 Present_state = T0; 
                T0          :   #40 Present_state = T1; 
                T1          :   #40 Present_state = T2; 
                T2          :   #40 Present_state = T3; 
                T3          :   #40 Present_state = T4; 
                T4          :   #40 Present_state = T5; 
            endcase 
        end   
                                                          
    always @(Present_state) // execute each state
        begin 
            case (Present_state) // assert the required signals in each clk cycle 
                Default: begin // initialize the signals
                    Mdatain <= 32'd0;
                    ctrl <= 0; 
                    clr <= 0; IncPC <= 0; Read <= 0;
                    PCout <= 0; MDRout <= 0; ZLOout <= 0; 
                    PCin <=0; MDRin <= 0; MARin <= 0; IRin <= 0; Yin <= 0; ZLOin <= 0;
                    R2out <= 0; R4out <= 0;
                    R5in <= 0; R2in <= 0; R4in <= 0; 
                    #15 clr <= 1;
                end 
                Reg_load1a: begin   
                    Mdatain <= 32'd3758096384; 
                    Read = 0; MDRin = 0;
                    #10 Read <= 1; MDRin <= 1;   
                    #15 Read <= 0; MDRin <= 0;    
                end 
                Reg_load1b: begin  
                    #10 MDRout <= 1; R2in <= 1;   
                    #15 MDRout <= 0; R2in <= 0; // initialize R2 with the value 3758096384          
                end 
                Reg_load2a: begin   
                    Mdatain <= 32'd2; 
                    #10 Read <= 1; MDRin <= 1;   
                    #15 Read <= 0; MDRin <= 0;       
                end 
                Reg_load2b: begin  
                    #10 MDRout <= 1; R4in <= 1;   
                    #15 MDRout <= 0; R4in <= 0; // initialize R4 with the value 2          
                end 
                Reg_load3a: begin   
                    Mdatain <= 32'd32; 
                    #10 Read <= 1; MDRin <= 1;   
                    #15 Read <= 0; MDRin <= 0; 
                end 
                Reg_load3b: begin  
                    #10 MDRout <= 1; R5in <= 1;   
                    #15 MDRout <= 0; R5in <= 0; // initialize R5 with the value 32          
                end 
                T0: begin
                    #10 PCout <= 1; MARin <= 1; IncPC <= 1; ZLOin <= 1;   
                    #25 PCout <= 0; MARin <= 0; IncPC <= 0; ZLOin <= 0;
                end 
                T1: begin 
                    Mdatain <= 32'b01000000000000000000000000000000; // rol op-code
                    #10 ZLOout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;   
                    #25 ZLOout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
                end 
                T2: begin 
                    #10 MDRout <= 1; IRin <= 1;   
                    #15 MDRout <= 0; IRin <= 0;
                end 
                T3: begin 
                    #10 R2out <= 1; Yin <= 1;
                    #15 R2out <= 0; Yin <= 0;
                end 
                T4: begin 
                    #10 R4out <= 1; ctrl <= 5'b00111; ZLOin <= 1; // rotate left control signal
                    #25 R4out <= 0; ZLOin <= 0;
                end 
                T5: begin 
                    #10 ZLOout <= 1; R5in <= 1;
                    #25 ZLOout <= 0; R5in <= 0;
                end 
        endcase 
    end 
endmodule // rol_tb