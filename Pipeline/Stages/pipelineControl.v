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

module pipelineControl(F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall, set_CC, D_icode, d_srcA, d_srcB, E_icode, E_dstM, e_Cnd, M_icode, m_stat, W_stat);
    output reg F_stall;
    output reg D_stall;
    output reg D_bubble;
    output reg E_bubble;
    output reg M_bubble;
    output reg W_stall;
    output reg set_CC;
    input [3:0] D_icode;
    input [3:0] d_srcA;
    input [3:0] d_srcB;
    input [3:0] E_icode;
    input [3:0] E_dstM;
    input e_Cnd;
    input [3:0] M_icode;
    input [2:0] m_stat;
    input [2:0] W_stat;
    
    always @(*)
    begin
        if (((E_icode == `IMRMOVQ || E_icode == `IPOPQ) && (E_dstM == d_srcA || E_dstM == d_srcB)) || (D_icode == `IRET || E_icode == `IRET || M_icode == `IRET))
        begin
            F_stall = 1;
        end
        else
        begin
            F_stall = 0;
        end

        if ((E_icode == `IMRMOVQ || E_icode == `IPOPQ) && (E_dstM == d_srcA || E_dstM == d_srcB))
        begin
            D_stall = 1;
        end
        else 
        begin
            D_stall = 0;
        end


        if ((E_icode == `IJXX && e_Cnd == 0) || !((E_icode == `IMRMOVQ || E_icode == `IPOPQ) && (E_dstM == d_srcA || E_dstM == d_srcB)) && (D_icode == `IRET || E_icode == `IRET || M_icode == `IRET))
        begin
            D_bubble = 1;
        end
        else
        begin
            D_bubble = 0;
        end

        if ((E_icode == `IJXX && e_Cnd == 0) || ((E_icode == `IMRMOVQ || E_icode == `IPOPQ) && (E_dstM == d_srcA || E_dstM == d_srcB)))
        begin
            E_bubble = 1;
        end
        else
        begin
            E_bubble = 0;
        end

        if (m_stat == `SADR || m_stat == `SINS || m_stat == `SHLT || W_stat == `SADR || W_stat == `SINS || W_stat == `SHLT)
        begin
            M_bubble = 1;
        end
        else
        begin
            M_bubble = 0;
        end

        if (W_stat == `SADR || W_stat == `SINS || W_stat == `SHLT)
        begin
            W_stall = 1;
        end
        else
        begin
            W_stall = 0;
        end

        if (E_icode == `IOPQ &&  !(m_stat == `SADR || m_stat == `SINS || m_stat == `SHLT || W_stat == `SADR || W_stat == `SINS || W_stat == `SHLT))
        begin
            set_CC = 1;
        end
        else
        begin
            set_CC = 0;
        end

    end

    initial
    begin
        $monitor("F_stall = %d, D_stall = %d, D_bubble = %d, E_bubble= %d, M_bubble = %d, W_stall = %d",F_stall,D_stall,D_bubble,E_bubble,M_bubble,W_stall);
    end
endmodule