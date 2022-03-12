// Select and Encode Logic

module SEL (
    output reg [31:0] C,
    output reg [15:0] RX_In, RX_Out,
    input [31:0] IR_Out,
    input G_RA, G_RB, G_RC, R_In, R_Out, BA_Out
);

    reg [3:0] Decoder_In;

    always @ (*) begin
        RX_In = 0;
        RX_Out = 0;
        C = {{17{IR_Out[14]}}, IR_Out[14:0]};

        if(G_RA)
            Decoder_In = IR_Out[26:23];
        else if(G_RB)
            Decoder_In = IR_Out[22:19];
        else if(G_RC)
            Decoder_In = IR_Out[18:14];

        if (R_In)
            RX_In[Decoder_In] <= 1;
        else if (R_Out || BA_Out)
            RX_Out[Decoder_In] <= 1;
    end
endmodule // SEL