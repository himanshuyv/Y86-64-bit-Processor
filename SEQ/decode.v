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
            scrB <= rsp;
        end
        if(icode == 11 || icode == 9)
        begin
            srcA <= rsp;
        end
    end


endmodule