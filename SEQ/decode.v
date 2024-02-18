module decode(valA, valB, rA, rB, icode, reg_file, clk)
    initial begin
        rsp<=4;
    end
    
    always @posedge clk
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
        valA <= reg_file[srcA];
        valB <= reg_file[srcB];
    end
endmodule