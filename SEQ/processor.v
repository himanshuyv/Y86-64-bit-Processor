`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "write_back.v"
`include "data_memory.v"
`include "PC_update.v"


module processor(clk);
    input clk;
    reg [63:0] reg_file[15:0];
    reg [63:0] PC;
    genvar i;
    generate
        for (i=0; i<16;i = i+1)begin
            initial begin
                reg_file[i] <= i;
            end
        end
    endgenerate
    initial
    begin
        PC <= 0;
    end
    wire [3:0] f_icode; 
    wire [3:0] f_ifun; 
    wire [3:0] f_rA; 
    wire [3:0] f_rB;
    wire [63:0] f_valC; 
    wire [63:0] f_valP; 
    wire f_instr_valid;
    wire f_imem_error;
    reg [3:0] icode;
    reg [3:0] ifun;
    reg [3:0] rA;
    reg [3:0] rB;
    reg [63:0] valC;
    reg [63:0] valP;
    reg instr_valid;
    reg imem_error;
    fetch X1(f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_instr_valid,f_imem_error,PC);
    wire [3:0] srcA;
    wire [3:0] srcB;
    decode X2(srcA, srcB, rA, rB, icode);
    wire [63:0] e_valE;
    wire e_Cnd;
    reg [63:0] valA;
    reg [63:0] valB;
    reg [63:0] valE;
    reg Cnd;
    execute X3(e_Cnd,e_valE,valA,valB,valC,icode,ifun);
    wire [63:0] dm_valM;
    wire [2:0] dm_stat;
    reg [63:0] valM;
    reg [2:0] stat;
    data_memory X4(dm_valM, dm_stat, valA, valP, valE, icode, instr_valid, imem_error);
    wire [3:0] wb_dstE;
    wire [3:0] wb_dstM;
    write_back X5(wb_dstE, wb_dstM, rA, rB, icode);
    wire [63:0] pu_PC;
    PC_update X6(pu_PC, icode, valP, valC, valM, Cnd, clk);
    always @(*)
    begin
        icode <= f_icode;
        ifun <= f_ifun;
        rA <= f_rA;
        rB <= f_rB;
        valC <= f_valC;
        valP <= f_valP;
        instr_valid <= f_instr_valid;
        imem_error <= f_imem_error;
        valA <= reg_file[srcA];
        valB <= reg_file[srcB];
        valE <= e_valE;
        Cnd <= e_Cnd;
        valM <= dm_valM;
        stat <= dm_stat;
        reg_file[wb_dstE] <= valE;
        reg_file[wb_dstM] <= valM;
        PC <= pu_PC;
    end
endmodule