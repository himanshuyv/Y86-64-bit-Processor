`include "./ALU/ALU_Wrapper.v"
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

module execute(e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,E_srcA,E_srcB,m_stat,W_stat,clk);
    output reg [2:0] e_stat;
    output reg [3:0] e_icode;
    output reg e_Cnd;
    output reg [63:0] e_valE;
    output reg [63:0] e_valA;
    output reg [3:0] e_dstE;
    output reg [3:0] e_dstM;
    input [2:0] E_stat;
    input [3:0] E_icode;
    input [3:0] E_ifun;
    input [63:0] E_valC;
    input [63:0] E_valA;
    input [63:0] E_valB;
    input [3:0] E_dstE;
    input [3:0] E_dstM;
    input [3:0] E_srcA;
    input [3:0] E_srcB;
    input [2:0] m_stat;
    input [2:0] W_stat;
    input clk;
    reg ZF;
    reg SF;
    reg OF;
    wire [63:0] aluOut;
    wire aluOF;
    reg [63:0] aluA;
    reg [63:0] aluB;
    reg [1:0] aluFun;
    reg set_CC;
    ALU_Wrapper X1(aluOF,aluOut,aluFun,aluB, aluA);
    
    initial begin
        OF = 0;
        ZF = 0;
        SF = 0;
    end


    always @(*)
    begin
        e_icode = E_icode;
        e_stat = E_stat;
        e_dstE = E_dstE;
        e_dstM = E_dstM;
        e_valA = E_valA;
        if (E_icode == `IRRMOVQ || E_icode == `IOPQ)
        begin
            aluA = E_valA;
        end
        else if (E_icode == `IIRMOVQ || E_icode == `IRMMOVQ || E_icode == `IMRMOVQ)
        begin
            aluA  = E_valC;
        end
        else if (E_icode == `ICALL || E_icode == `IPUSHQ)
        begin 
            aluA = -8;
        end
        else if (E_icode == `IRET || E_icode == `IPOPQ)
        begin 
            aluA = 8;
        end
        else
        begin
            aluA = 0;
        end

        if (E_icode == `IRMMOVQ || E_icode == `IMRMOVQ || E_icode == `IOPQ || E_icode == `ICALL || E_icode == `IRET || E_icode == `IPUSHQ || E_icode == `IPOPQ)
        begin 
            aluB = E_valB;
        end
        else if (E_icode == `IRRMOVQ || E_icode == `IIRMOVQ)
        begin 
            aluB = 0;
        end
        else
        begin
            aluB = 0;
        end

        if (E_icode == `IOPQ)
        begin 
            aluFun = E_ifun[1:0];
        end
        else
        begin
            aluFun = `ALUADD;
        end

        e_valE = aluOut;

        // Set CC logic 


        if (set_CC==1)
        begin
            OF = aluOF;
            if (e_valE[63] == 1)
            begin
                SF = 1;
            end
            else
            begin
                SF = 0;    
            end

            if (e_valE == 0)
            begin
                ZF = 1;
            end
            else
            begin
                ZF = 0;    
            end
        end

        if (E_icode == `IRRMOVQ || E_icode == `IJXX)
        begin
            if (E_ifun == 0)
            begin
                e_Cnd = 1;
            end
            else if (E_ifun == 1)
            begin
                e_Cnd = (SF^OF)|ZF;
            end
            else if (E_ifun == 2)
            begin
                e_Cnd  = SF^OF;
            end
            else if (E_ifun == 3)
            begin
                e_Cnd = ZF;
            end
            else if (E_ifun == 4)
            begin
                e_Cnd = ~ZF;
            end
            else if (E_ifun == 5)
            begin
                e_Cnd = ~(SF^OF);
            end
            else if (E_ifun == 6)
            begin
                e_Cnd = ~(SF^OF) & ~ZF;
            end
        end
        else
        begin
            e_Cnd = 0;
        end

        if (E_icode == `IRRMOVQ && e_Cnd != 1)
        begin
            e_dstE = `RNONE;
        end
    end
endmodule