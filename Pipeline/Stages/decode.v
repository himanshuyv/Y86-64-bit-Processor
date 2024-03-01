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

module decode(D_stat, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP, e_dstE, e_valE, M_dstE, M_valE, M_dstM, m_valM, W_dstM, W_valM, W_dstE, W_valE, d_valA, d_valB, d_valC, d_dstE, d_dstM, clk);
    output reg [2:0] d_stat;
    output reg [3:0] d_icode;
    output reg [3:0] d_ifun;
    output reg [63:0] d_valC;
    output reg [63:0] d_valA;
    output reg [63:0] d_valB;
    output reg [3:0] d_dstE;
    output reg [3:0] d_dstM;
    output reg [3:0] d_srcA;
    output reg [3:0] d_srcB;
    input [2:0] D_stat;
    input [3:0] D_icode;
    input [3:0] D_ifun;
    input [3:0] D_rA;
    input [3:0] D_rB;
    input [63:0] D_valC;
    input [63:0] D_valP;
    input [3:0] e_dstE;
    input [63:0] e_valE;
    input [3:0] M_dstE;
    input [63:0] M_valE;
    input [3:0] M_dstM;
    input [63:0] m_valM;
    input [3:0] W_dstM;
    input [63:0] W_valM;
    input [3:0] W_dstE;
    input [63:0] W_valE;
    input clk;
    reg [63:0] d_rvalA;
    reg [63:0] d_rvalB;

    reg [63:0] reg_file[15:0];
    genvar i;
    generate
        for (i=0; i<16;i = i+1)begin
            initial begin
                reg_file[i] = i;
            end
        end
    endgenerate

    always@(negedge clk)
    begin
        d_stat = D_stat;
        d_icode = D_icode;
        d_ifun = D_ifun;
        if(D_icode == `IRRMOVQ || D_icode ==`IRMMOVQ || D_icode == `IOPQ || D_icode == `IPUSHQ)
            begin
                d_srcA = D_rA;
            end
        else if(D_icode == `IPOPQ || D_icode == `IRET)
            begin
                d_srcA = 4;
            end
        else
            begin
                d_srcA = 15;
            end
        if(D_icode == `IRRMOVQ || D_icode == `IMRMOVQ || D_icode == `IOPQ)
            begin
                d_srcB = D_rB;
            end
        else if(D_icode == `IPUSHQ || D_icode == `IPOPQ || D_icode == `ICALL || D_icode == `IRET)
            begin
                d_srcB = 4;
            end
        else
            begin 
                d_srcB = 15;
            end
        d_rvalA = reg_file[d_srcA];
        d_rvalB = reg_file[d_srcB];

        if(D_icode == `ICALL || D_icode == `IJXX)
        begin
            d_valA = D_valP;
        end
        else if(d_srcA == e_dstE)
        begin
            d_valA = e_valE;
        end
        else if(d_srcA == M_dstM)
        begin
            d_valA = m_valM;
        end
        else if(d_srcA == M_dstE)
        begin
            d_valA = M_valE;
        end
        else if(d_srcA == W_dstM)
        begin
            d_valA = W_valM;
        end
        else if(d_srcA == W_dstE)
        begin
            d_valA = W_valE;
        end
        else
        begin
            d_valA = d_rvalA;
        end

        if(d_srcB == e_dstE)
        begin
            d_valB = e_valE;
        end
        else if(d_srcB == M_dstM)
        begin
            d_valB = m_valM;
        end
        else if(d_srcB == M_dstE)
        begin
            d_valB = M_valE;
        end
        else if(d_srcB == W_dstM)
        begin
            d_valB = W_valM;
        end
        else if(d_srcB == W_dstE)
        begin
            d_valB = W_valE;
        end
        else
        begin
            d_valB = d_rvalB;
        end
    end

    always @(posedge clk)
    begin
        if(D_icode == `IOPQ || D_icode == `IIRMOVQ)
        begin
            d_dstE = D_rB;
        end
        else if(D_icode == `IRRMOVQ)
        begin
            d_dstE = D_rB;
        end
        else if(D_icode == `IPUSHQ || D_icode == `IPOPQ || D_icode == `ICALL || D_icode == `IRET)
        begin
            d_dstE = 4;
        end
        else
        begin
            d_dstE = 15;
        end
        if(D_icode == `IMRMOVQ || D_icode == `IPOPQ)
        begin
            d_dstM = D_rA;
        end
        else
        begin
            d_dstM = 15;
        end
        reg_file[d_dstE] = W_valE;
        reg_file[d_dstM] = W_valM;
    end

endmodule