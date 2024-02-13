module memory(dmemError,valueRead,clk,memAddress,readEN,writeEn,valueWrite);
    output reg dmemError;
    output reg [63:0] valueRead;
    input clk;
    input [63:0] memAddress;
    input readEN;
    input writeEn;
    input [63:0] valueWrite;
    reg [63:0] memReg[0:8191];

    genvar i;
    generate
        for (i=0;i<8192; i = i+1)begin
            initial memReg[i] <= 0;
        end
    endgenerate

    always @(posedge clk) begin
        dmemError <=0;
        valueRead <= 0;
        if ((readEN==1 && writeEn==1) || (memAddress>8191))begin
            dmemError <= 1;
        end
        else if (readEN == 1)begin
            valueRead <= memReg[memAddress];
        end
        else if (writeEn == 1)begin
            memReg[memAddress] = valueWrite;
        end
    end
endmodule