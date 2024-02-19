module write_back(dstE, dstM, rA, rB, icode);
    output reg [3:0] dstE;
    output reg [3:0] dstM;
    input [3:0] icode;
    input [3:0] rA;
    input [3:0] rB;

    always @(*) begin
        if(icode == 6 || icode == 2 || icode == 3)
        begin
            dstE <= rB;
        end
        if(icode == 5 || icode == 11)
        begin
            dstM <= rA;
        end
        if(icode == 10 || icode == 11 || icode == 8 || icode == 9)
        begin
            dstE <= rA;
        end
        if(icode == 0 || icode == 1 || icode == 4 || icode == 5 || icode == 6 || icode == 7)
        begin
            dstE <= 15;
        end
        if(icode == 0 || icode == 1 || icode == 2 || icode == 3 || icode == 4 || icode == 6 || icode == 7 || icode == 8 || icode == 9 || icode == 10)
        begin
            dstM <= 15;
        end
    end
endmodule