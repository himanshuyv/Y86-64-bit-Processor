module M_Reg(M_stat,M_icode,M_Cnd,M_valE,M_valA,M_dstE,M_dstM,e_stat,e_icode,e_Cnd,e_valE,e_valA,e_dstE,e_dstM,clk);
    output reg [2:0] e_stat;
    output reg [3:0] e_icode;
    output reg e_Cnd;
    output reg [63:0] e_valE;
    output reg [63:0] e_valA;
    output reg [3:0] e_dstE;
    output reg [3:0] e_dstM;
    input [2:0] M_stat;
    input [3:0] M_icode;
    input M_Cnd;
    input [63:0] M_valE;
    input [63:0] M_valA;
    input [3:0] M_dstE;
    input [3:0] M_dstM;
    input clk;
    always @(*)
    begin
        M_stat = e_stat;
        M_icode = e_icode;
        M_Cnd = e_Cnd;
        M_valE = e_valE;
        M_valA = e_valA;
        M_dstE = e_dstE;
        M_dstM = e_dstM;
    end
endmodule