`include "fetch.v"
`include "decode_WriteBack.v"
`include "execute.v"
`include "data_memory.v"
`include "PC_update.v"


module processor;
    reg clk;
    reg [63:0] PC;
    
    initial
    begin
        $dumpfile("processor.vcd");
        $dumpvars(0,processor);
    end

    reg [2:0] stat;
    
    always
    begin
        #5
        clk = ~clk;
    end

    initial
    begin
        PC = 0;
        stat = 1;
        clk = 0;
    end

    wire [3:0] icode; 
    wire [3:0] ifun; 
    wire [3:0] rA; 
    wire [3:0] rB;
    wire [63:0] valC; 
    wire [63:0] valP; 
    wire instr_valid;
    wire imem_error;
    wire [63:0] valE;
    wire [63:0] valM;
    wire [63:0] valA;
    wire [63:0] valB;
    fetch X1(icode,ifun,rA,rB,valC,valP,instr_valid,imem_error,clk,PC);
    decode_WriteBack X2(valA, valB, rA, rB, valE, valM, icode, Cnd, clk);
    wire Cnd;
    execute X3(Cnd,valE,valA,valB,valC,icode,ifun,clk);
    wire [2:0] dm_stat;
    data_memory X4(valM, dm_stat, valA, valP, valE, icode, instr_valid, imem_error, clk);
    wire [63:0] pu_PC;
    PC_update X6(pu_PC, icode, valP, valC, valM, Cnd, clk);
    always @(posedge clk)
    begin
        if (stat!=1)
        begin
            $finish;
        end
    end
    always @(negedge clk)
    begin
        PC = pu_PC;
        stat = dm_stat;
    end

endmodule