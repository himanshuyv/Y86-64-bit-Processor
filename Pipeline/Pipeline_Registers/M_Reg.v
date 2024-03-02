`define INOP 1

module M_Reg(M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,M_bubble,clk);
    output reg [2:0] M_stat;
    output reg [3:0] M_icode;
    output reg M_Cnd;
    output reg [63:0] M_valE;
    output reg [63:0] M_valA;
    output reg [3:0] M_dstE;
    output reg [3:0] M_dstM;
    input [2:0] e_stat;
    input [3:0] e_icode;
    input e_Cnd;
    input [63:0] e_valE;
    input [63:0] e_valA;
    input [3:0] e_dstE;
    input [3:0] e_dstM;
    input M_bubble;
    input clk;
    always @(posedge clk)
    begin
        if (M_bubble != 1)
        begin
            M_stat = e_stat;
            M_icode = e_icode;
            M_Cnd = e_Cnd;
            M_valE = e_valE;
            M_valA = e_valA;
            M_dstE = e_dstE;
            M_dstM = e_dstM;
        end
        else
        begin
            M_icode = `INOP;
        end
    end
endmodule