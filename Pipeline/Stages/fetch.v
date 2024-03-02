`include "instructionMemory.v"
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


module fetch(f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,f_predPC,F_predPC,M_icode,M_Cnd,M_valA,W_icode,W_valM,clk);
    output reg [2:0] f_stat;
    output reg [3:0] f_icode;
    output reg [3:0] f_ifun;
    output reg [3:0] f_rA;
    output reg [3:0] f_rB;
    output reg [63:0] f_valC;
    output reg [63:0] f_valP;
    output reg [63:0] f_predPC;
    input [63:0] F_predPC;
    input [3:0] M_icode;
    input M_Cnd;
    input [63:0] M_valA;
    input [3:0] W_icode;
    input [63:0] W_valM;
    input clk;
    reg need_regids;
    reg need_valC;
    wire [7:0] im_out [0:9];
    wire imem_errorw;
    reg [63:0] f_PC;
    initial
    begin
        f_valP = 0;
        f_PC = 0;
        f_stat = 1;
    end

    instructionMemory X1(im_out[0],im_out[1],im_out[2],im_out[3],im_out[4],im_out[5],im_out[6],im_out[7],im_out[8],im_out[9],imem_errorw,f_PC);

    // Select PC Logic
    always @(*)
    begin
        if (M_icode == `IJXX && M_Cnd == 0)
        begin
            f_PC = M_valA;
        end
        else if (W_icode == `IRET)
        begin
            f_PC = W_valM;
        end
        else
        begin
            f_PC = F_predPC;
        end
    end

    always @(*)
    begin
        f_icode = im_out[0][7:4];
        f_ifun = im_out[0][3:0];   

        if (f_icode == `IRRMOVQ || f_icode == `IIRMOVQ || f_icode == `IRMMOVQ || f_icode == `IMRMOVQ || f_icode == `IOPQ || f_icode == `IPUSHQ || f_icode == `IPOPQ) 
        begin
            need_regids = 1; 
            f_rA = im_out[1][7:4];
            f_rB = im_out[1][3:0];
        end
        else
        begin
            need_regids = 0;
            f_rA = `RNONE;
            f_rB = `RNONE;
        end

        if (f_icode == `IIRMOVQ || f_icode == `IRMMOVQ || f_icode == `IMRMOVQ || f_icode == `IJXX || f_icode == `ICALL)
        begin
            need_valC = 1;
            f_valC[7:0] = im_out[need_regids+1];
            f_valC[15:8] = im_out[need_regids+2];
            f_valC[23:16] = im_out[need_regids+3];
            f_valC[31:24] = im_out[need_regids+4];
            f_valC[39:32] = im_out[need_regids+5];
            f_valC[47:40] = im_out[need_regids+6];
            f_valC[55:48] = im_out[need_regids+7];
            f_valC[63:56] = im_out[need_regids+8];
        end
        else
        begin
            need_valC = 0;
        end

        // PC Increment
        f_valP = f_PC + 1 + need_regids + 8*need_valC;
        
        // Predict PC logic
        if (f_icode == `IJXX || f_icode == `ICALL)
        begin
            f_predPC = f_valC;
        end
        else
        begin
            f_predPC = f_valP;
        end

        // Stat logic
        if(f_icode < `IHALT || f_icode > `IPOPQ)
        begin
            f_stat = `SINS;
        end
        else if (imem_errorw == 1)
        begin
            f_stat = `SADR;
        end
        else 
        begin
            f_stat = `SAOK;
        end

        if (f_icode == `IHALT)
        begin
            f_stat = `SHLT;
        end

        // if ((icode == `IHALT || icode == `INOP || icode == `IIRMOVQ || icode == `IRMMOVQ || icode == `IMRMOVQ || icode == `ICALL || icode == `IRET || icode == `IPUSHQ || icode == `IPOPQ) && ifun != `FNONE)
        // begin
        //     instr_valid = 0;
        // end   
    
        // if (((icode == `IRRMOVQ || icode == `IJXX) && ifun>6) || (icode == `IOPQ && ifun>3))
        // begin
        //     instr_valid = 0;
        // end 
    end
endmodule