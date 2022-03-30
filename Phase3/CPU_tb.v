// CPU Testbench
`timescale 1ns/10ps 
module CPU_tb;
    output reg [31:0] Output_Data;
    output reg Run;
    input reg [31:0] Input_Data;
    input reg Clock, Reset, Stop;

    CPU DUT (
        OutData,
        Run, 
        Input_Data,
        Clock, Reset, Stop
        );

    initial begin
        Run = 0;
        Clock = 0; Reset = 0; Stop = 0;
        forever #10 Clock = ~ Clock; 
    end 