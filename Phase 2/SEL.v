// Select and Encode Logic

// DON'T Change the bus
// In the datapath replace R0_Out .... with RX_Out same for R0_In and RX_In
// in the register modules select the appropriate control bit eg. R0 RX[0]

// Too test the memory we need to put the instruction directily in memory AND some value to read
// You do this by putting some value directly in the RAM file

// We also still need to wire the memory

module SEL (
    output [31:0] C,
    output [15:0] RX_In, RX_Out,
    input [31:0] IR_Out,
    input G_RA, G_RB, G_RC, R_In, R_Out, BA_Out
);

    wire [3:0] Decoder_In

    always @ (*) begin
        RX_In = 0;
        RX_Out = 0;
        C = {17{IR_Out[14]}, IR_Out[14:0]};

        if(G_RA)
            Decoder_In <= IR_Out[26:23];
        else if(G_RB)
            Decoder_In <= IR_Out[22:19];
        else if(G_RC)
            Decoder_In <= IR_Out[18:14];

        if (R_In)
            RX_In[Decoder_In] = 1;
        else if (R_Out || BA_Out)
            RX_Out[Decoder_In] = 1;

    end
endmodule // SEL