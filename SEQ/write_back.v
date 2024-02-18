module write_back(dstE, dstM, rA, rB, icode, clk)
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
endmodule