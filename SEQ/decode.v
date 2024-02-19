module decode(srcA, srcB, rA, rB, icode);
    output reg [3:0] srcA;
    output reg [3:0] srcB;
    input [3:0] icode;
    input [3:0] rA;
    input [3:0] rB;

    always @(*)
    begin
        if(icode == 2 || icode ==4 || icode == 6 || icode == 10)
        begin
            srcA <= rA;
        end
        if(icode == 3 || icode == 4 || icode == 5 || icode == 6)
        begin
            srcB <= rB;
        end
        if(icode == 10 || icode == 11 || icode == 8 || icode == 9)
        begin
            srcB <= 4;
        end
        if(icode == 11 || icode == 9)
        begin
            srcA <= 4;
        end
        if(icode == 0 || icode == 1 || icode == 3|| icode == 5 || icode == 7 || icode == 8)
        begin
            srcA <= 15;
        end
        if(icode == 0 || icode == 1 || icode == 2 ||icode == 7 || icode == 8 || icode == 10)
        begin 
            srcB <= 15;
        end
    end


endmodule