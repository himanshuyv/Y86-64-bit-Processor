`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "write_back.v"


module processor()
    reg [63:0] reg_file[15:0];
    genvar i;
        generate
            for (i=0;i16; i = i+1)begin
                initial registers[i] <= i;
            end
        endgenerate
    wire PC, icode, ifun, rA, rB, valC, valP, stat;
    fetch X1(icode,ifun,rA,rB,valC,valP,stat,PC)
    wire srcA, srcB, valA, valB;
    decode X2(srcA, srcB, rA, rB, icode);
    valA <= reg_file[srcA];
    valB <= reg_file[srcB];
    wire OF, ZF, SF, valE;
    execute X3(OF,ZF,SF,valE,valA,valB,valC,icode,ifun);
    memory X4(valM, valA, valP, valE);
    wire dstE, dstM;
    write_back X5(dstE, dstM, rA, rB, icode);
    reg_file[dstE] <= valE;
    reg_file[dstM] <= valM;
    PC_update X6(icode, valP, valC, valM, OF, ZF, SF, PC);
endmodule