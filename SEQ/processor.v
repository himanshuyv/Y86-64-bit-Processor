`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "write_back.v"
`include "data_memory.v"
`include "PC_update.v"


module processor;
    reg clk;
    reg [63:0] reg_file[15:0];
    reg [63:0] PC;
    genvar i;
    generate
        for (i=0; i<16;i = i+1)begin
            initial begin
                reg_file[i] = i;
            end
        end
    endgenerate
    
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
    fetch X1(icode,ifun,rA,rB,valC,valP,instr_valid,imem_error,clk,PC);
    wire [3:0] srcA;
    wire [3:0] srcB;
    decode X2(srcA, srcB, rA, rB, icode);
    wire [63:0] valE;
    reg [63:0] valA;
    reg [63:0] valB;
    wire Cnd;
    execute X3(Cnd,valE,valA,valB,valC,icode,ifun);
    wire [63:0] valM;
    wire [2:0] dm_stat;
    data_memory X4(valM, dm_stat, valA, valP, valE, icode, instr_valid, imem_error);
    wire [3:0] dstE;
    wire [3:0] dstM;
    write_back X5(dstE, dstM, rA, rB, icode, Cnd);
    wire [63:0] pu_PC;
    PC_update X6(pu_PC, icode, valP, valC, valM, Cnd, clk);
    always @(*)
    begin
        valA = reg_file[srcA];
        valB = reg_file[srcB];
        reg_file[dstE] = valE;
        reg_file[dstM] = valM;
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

    initial
    begin
        $monitor("PC = %d, rax = %d ,rcx = %d, rdx = %d, rbx = %d, rsp = %d, rbp = %d, rsi = %d, rdi = %d, r8 = %d, r9 = %d, r10 = %d, r11 = %d, r12 = %d, r13 = %d, r14 = %d",PC,reg_file[0],reg_file[1],reg_file[2],reg_file[3],reg_file[4],reg_file[5],reg_file[6],reg_file[7],reg_file[8],reg_file[9],reg_file[10],reg_file[11],reg_file[12],reg_file[13],reg_file[14]);
    end
endmodule