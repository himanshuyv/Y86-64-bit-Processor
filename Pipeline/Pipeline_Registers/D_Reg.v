`define INOP 1
`define FNONE 0

module D_Reg(D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,D_stall,D_bubble,clk);
    output reg [2:0] D_stat;
    output reg [3:0] D_icode;
    output reg [3:0] D_ifun;
    output reg [3:0] D_rA;
    output reg [3:0] D_rB;
    output reg [63:0] D_valC;
    output reg [63:0] D_valP;
    input [2:0] f_stat;
    input [3:0] f_icode;
    input [3:0] f_ifun;
    input [3:0] f_rA;
    input [3:0] f_rB;
    input [63:0] f_valC;
    input [63:0] f_valP;
    input D_stall;
    input D_bubble;
    input clk;
    always @(posedge clk)
    begin
        if (D_stall != 1 && D_bubble != 1)
        begin
            D_stat = f_stat;
            D_icode = f_icode;
            D_ifun = f_ifun;
            D_rA = f_rA;
            D_rB = f_rB;
            D_valC = f_valC;
            D_valP = f_valP;
        end
        else if (D_bubble == 1)
        begin
            D_icode = `INOP;
            D_ifun = `FNONE;
        end
    end
endmodule