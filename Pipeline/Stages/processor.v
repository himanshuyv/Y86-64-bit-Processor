`include "./../Pipeline_Registers/F_Reg.v"
`include "fetch.v"
`include "./../Pipeline_Registers/D_Reg.v"
`include "decode_writeBack.v"
`include "./../Pipeline_Registers/E_Reg.v"
`include "execute.v"
`include "./../Pipeline_Registers/M_Reg.v"
`include "data_memory.v"
`include "./../Pipeline_Registers/W_Reg.v"

`define IHALT 0
`define INOP 1
`define IRRMOVQ 2
`define IIRMOVQ 3
`define IRMMOVQ 4
`define IMRMOVQ 5
`define IOPQ 6
`define IJXX 7
`define ICALL 8
`define IRET 9
`define IPUSHQ 10 
`define IPOPQ 11
`define FNONE 0
`define RESP 4
`define RNONE 15
`define ALUADD 0
`define SAOK 1
`define SADR 2
`define SINS 3
`define SHLT 4

module processor;
    reg clk;
    reg [63:0] PC;
    
    initial
    begin
        $dumpfile("processor.vcd");
        $dumpvars(0,processor);
    end

    
    always
    begin
        #5
        clk = ~clk;
    end

    reg [63:0] f_predPC;
    reg [2:0] stat;

    initial
    begin
        clk = 1;
        f_predPC = 0;
    end
    wire [63:0] F_predPC;
    wire [63:0] predPC;
    F_reg inst_F_Reg(F_predPC,f_predPC,clk);
    wire [2:0] f_stat;
    wire [3:0] f_icode;
    wire [3:0] f_ifun;
    wire [3:0] f_rA;
    wire [3:0] f_rB;
    wire [63:0] f_valC;
    wire [63:0] f_valP;
    wire [3:0] M_icode;
    wire M_Cnd;
    wire [63:0] M_valA;
    wire [3:0] W_icode;
    wire [63:0] W_valM;
    fetch inst_fetch(f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,predPC,F_predPC,M_icode,M_Cnd,M_valA,W_icode,W_valM,clk);
    wire [2:0] D_stat;
    wire [3:0] D_icode;
    wire [3:0] D_ifun;
    wire [3:0] D_rA;
    wire [3:0] D_rB;
    wire [63:0] D_valC;
    wire [63:0] D_valP;
    D_Reg inst_D_Reg(D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,clk);
    wire [2:0] d_stat;
    wire [3:0] d_icode;
    wire [3:0] d_ifun;
    wire [63:0] d_valC;
    wire [63:0] d_valA;
    wire [63:0] d_valB;
    wire [3:0] d_dstE;
    wire [3:0] d_dstM;
    wire [3:0] d_srcA;
    wire [3:0] d_srcB;
    wire [3:0] e_dstE;
    wire [63:0] e_valE;
    wire [3:0] M_dstE;
    wire [63:0] M_valE;
    wire [3:0] M_dstM;
    wire [63:0] m_valM;
    wire [3:0] W_dstM;
    wire [3:0] W_dstE;
    wire [63:0] W_valE;
    decode_writeBack inst_decode_wb(d_stat, d_icode, d_ifun, d_valC, d_valA, d_valB ,d_dstE, d_dstM, d_srcA, d_srcB, D_stat, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP, e_dstE, e_valE, M_dstE, M_valE, M_dstM, m_valM, W_dstM, W_valM, W_dstE, W_valE, clk);
    wire [2:0] E_stat;
    wire [3:0] E_icode;
    wire [3:0] E_ifun;
    wire [63:0] E_valC;
    wire [63:0] E_valA;
    wire [63:0] E_valB;
    wire [3:0] E_dstE;
    wire [3:0] E_dstM;
    wire [3:0] E_srcA;
    wire [3:0] E_srcB;
    E_Reg inst_E_Reg(E_stat, E_icode, E_ifun, E_valC, E_valA, E_valB, E_dstE, E_dstM, E_srcA, E_srcB, d_stat, d_icode, d_ifun, d_valC, d_valA, d_valB, d_dstE, d_dstM, d_srcA, d_srcB, clk);
    wire [2:0] e_stat;
    wire [3:0] e_icode;
    wire e_Cnd;
    wire [63:0] e_valA;
    wire [3:0] e_dstM;
    wire [2:0] m_stat;
    wire [2:0] W_stat;
    execute inst_execute(e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,E_srcA,E_srcB,m_stat,W_stat,clk);
    wire [2:0] M_stat;
    M_Reg inst_M_Reg(M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,clk);
    wire [3:0] m_icode;
    wire [63:0] m_valE;
    wire [3:0] m_dstE;
    wire [3:0] m_dstM;
    data_memory inst_data_mem(m_stat, m_icode, m_dstE, m_dstM, m_valE, m_valM, M_stat, M_icode, M_Cnd, M_valE, M_valA, M_dstE, M_dstM, clk);
    W_Reg inst_W_Reg(W_stat, W_icode, W_valE, W_valM, W_dstE, W_dstM, m_stat ,m_icode ,m_valE ,m_valM ,m_dstE ,m_dstM, clk);
    always @(*)
    begin
        stat = W_stat;
        f_predPC = predPC; 
    end

    always @(*)
    begin
        if (stat  != `SAOK)
        begin
            $finish;
        end
    end
endmodule