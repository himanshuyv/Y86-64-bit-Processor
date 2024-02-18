module decode(valA, valB, rA, rB, icode, clk)

    always @(*)
    begin
        if(icode == 2 || icode ==4 || icode == 6 || icode == 10)
        begin
            srcA <= rA;
        end
        if(icode == 3 || icode == 4 || icode == 5 || icode == 6)
        begin
            scrB <= rB;
        end
        if(icode == 10 || icode == 11 || icode == 8 || icode == 9)
        begin
            scrB <= b'0100;
        end
        if(icode == 11 || icode == 9)
        begin
            srcA <= b'0100;
        end
        if(icode == 0 || icode == 1 || icode == 3|| icode == 5 || icode == 7 || icode == 8)
        begin
            scrA <= 1111;
        end
        if(icode == 0 || icode == 1 || icode == 2 ||icode == 7 || icode == 8 || icode == 10)
        begin 
            srcB <=1111;
        end
    end


endmodule