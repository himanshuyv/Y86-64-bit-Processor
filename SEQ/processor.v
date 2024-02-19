`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "write_back.v"
`include "data_memory.v"
`include "PC_update.v"


module processor(PC, clk);
input wire [63:0] PC;
input clk;
    reg [63:0] reg_file[15:0];
    genvar i;
        generate
            for (i=0;i16; i = i+1)begin
                initial registers[i] <= i;
            end
        endgenerate
    wire [63:0] var_valM;
    wire var_dmemError;
    wire [3:0] var_icode;
    wire [63:0] var_valA;
    wire [2:0] var_stat;
    wire [63:0] var_valP;
    wire [63:0] var_valE;
    data_memory X5(var_valM, var_dmemError, var_stat, var_valA, var_valP, var_valE, var_icode);
    wire [63:0] PC; 
    wire [3:0] icode; 
    wire [3:0] ifun; 
    wire [3:0] rA; 
    wire [3:0] rB, 
    wire [63:0] valC, 
    wire [63:0] valP; 
    wire [3:0] stat;
    wire [3:0]srcA;
    wire [3:0]srcB;
    wire [63:0] valA;
    wire [63:0] valB;
    wire OF, ZF, SF, Cnd;
    wire [63:0] valE;
    wire [63:0] dstE
    wire [63:0] dstM;
    wire instr_valid;
    wire imem_error;
    wire dmemError;
    always @(*)
    begin
        fetch X1(icode,ifun,rA,rB,valC,valP,instr_valid,imem_error,PC);
        decode X2(srcA, srcB, rA, rB, icode);
        valA <= reg_file[srcA];
        valB <= reg_file[srcB];
        var_valA <= valA;
        var_valP <= valP;
        var_icode <= icode;
        execute X3(OF,ZF,SF,valE,valA,valB,valC,icode,ifun, Cnd);
        valM <= var_valM;
        var_valE <= varE;
        dmemError <= var_dmemError;
        write_back X5(dstE, dstM, rA, rB, icode);
        reg_file[dstE] <= valE;
        reg_file[dstM] <= valM;
        PC_update X6(icode, valP, valC, valM, Cnd, PC, clk);
    end
endmodule