// Rotate Right
module ROR(
    output reg [31:0] C,
    input [31:0] A, B
);

    reg [4:0] rotate;

    always @ (B) begin
        if(B[31] == 1)
            rotate = 4'd0;
        else
            rotate = B % 32'd32;
    end

    always @ (*) begin
        if(rotate == 4'd0)
            C = A;
        else if(rotate == 4'd1)
            C = {A[0], A[31:1]};
        else if(rotate == 4'd2)
            C = {A[1:0], A[31:2]};
        else if(rotate == 4'd3)
            C = {A[2:0], A[31:3]};
        else if(rotate == 4'd4)
            C = {A[3:0], A[31:4]};
        else if(rotate == 4'd5)
            C = {A[4:0], A[31:5]};
        else if(rotate == 4'd6)
            C = {A[5:0], A[31:6]};
        else if(rotate == 4'd7)
            C = {A[6:0], A[31:7]};
        else if(rotate == 4'd8)
            C = {A[7:0], A[31:8]};
        else if(rotate == 4'd9)
            C = {A[8:0], A[31:9]};
        else if(rotate == 4'd10)
            C = {A[9:0], A[31:10]};
        else if(rotate == 4'd11)
            C = {A[10:0], A[31:11]};
        else if(rotate == 4'd12)
            C = {A[11:0], A[31:12]};
        else if(rotate == 4'd13)
            C = {A[12:0], A[31:13]};
        else if(rotate == 4'd14)
            C = {A[13:0], A[31:14]};
        else if(rotate == 4'd15)
            C = {A[14:0], A[31:15]};
        else if(rotate == 4'd16)
            C = {A[15:0], A[31:16]};
        else if(rotate == 4'd17)
            C = {A[16:0], A[31:17]};
        else if(rotate == 4'd18)
            C = {A[17:0], A[31:18]};
        else if(rotate == 4'd19)
            C = {A[18:0], A[31:19]};
        else if(rotate == 4'd20)
            C = {A[19:0], A[31:20]};
        else if(rotate == 4'd21)
            C = {A[20:0], A[31:21]};
        else if(rotate == 4'd22)
            C = {A[21:0], A[31:22]};
        else if(rotate == 4'd23)
            C = {A[22:0], A[31:23]};
        else if(rotate == 4'd24)
            C = {A[23:0], A[31:24]};
        else if(rotate == 4'd25)
            C = {A[24:0], A[31:25]};
        else if(rotate == 4'd26)
            C = {A[25:0], A[31:26]};
        else if(rotate == 4'd27)
            C = {A[26:0], A[31:27]};
        else if(rotate == 4'd28)
            C = {A[27:0], A[31:28]};
        else if(rotate == 4'd29)
            C = {A[28:0], A[31:29]};
        else if(rotate == 4'd30)
            C = {A[29:0], A[31:30]};
        else if(rotate == 4'd31)
            C = {A[30:0], A[31]};
        else
            begin
            end
    end
endmodule // ROR