module write_back(dstE, dstM, rA, rB, icode, Cnd);
    output reg [3:0] dstE;
    output reg [3:0] dstM;
    input Cnd;
    input [3:0] icode;
    input [3:0] rA;
    input [3:0] rB;

    always @(*) begin
        if(icode == 6 || icode == 3)
        begin
            dstE = rB;
        end
        else if(icode == 2)
        begin
            if(Cnd)
            begin
                dstE = rB;
            end
        end
        else if(icode == 10 || icode == 11 || icode == 8 || icode == 9)
        begin
            dstE = 4;
        end
        else
        begin
            dstE = 15;
        end
        if(icode == 5 || icode == 11)
        begin
            dstM = rA;
        end
        else
        begin
            dstM = 15;
        end
    end
endmodule