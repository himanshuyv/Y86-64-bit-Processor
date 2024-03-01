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

module data_memory(M_stat, M_icode, M_Cnd, M_valE, M_valA, M_dstE, M_dstM, m_stat, m_icode, m_dstE, m_dstM, m_valE, m_valM);
    output reg [2:0] m_stat;
    output reg [3:0] m_icode;
    output reg [63:0] m_valE;
    output reg [63:0] m_valM;
    output reg [3:0] m_dstE;
    output reg [3:0] m_dstM;
    input [2:0] M_stat;
    input [3:0] M_icode;
    input M_Cnd;
    input [63:0] M_valE;
    input [63:0] M_valA;
    input [3:0] M_dstE;
    input [3:0] M_dstM;
    input clk;
    reg [63:0] memReg[0:8191];
    genvar i;
    generate
        for (i=0; i<64;i = i+1)begin
            initial begin
                memReg[i] = 0;
            end
        end
    endgenerate
    reg [63:0] mem_addr;
    reg [63:0] mem_data;
    reg mem_read;
    reg mem_write;
    always @(posedge clk)
    begin
        if(M_icode == `IPUSHQ || M_icode == `ICALL || M_icode == `IRMMOVQ || M_icode == `IMRMOVQ)
        begin
            mem_addr = M_valE;
        end
        else if(M_icode == `IPOPQ || M_icode == `IRET)
        begin 
            mem_addr = M_valA;
        end

        if (M_icode == `IRMMOVQ || M_icode == `IPUSHQ || M_icode == `ICALL)
        begin
            mem_data = M_valA;
        end

        if (M_icode == `IMRMOVQ || M_icode == `IRET || M_icode == `IPOPQ)
        begin
            mem_read = 1;
        end
        else
        begin
            mem_read = 0;
        end

        if (M_icode == `IRMMOVQ || M_icode == `ICALL || M_icode == `IPUSHQ)
        begin
            mem_write = 1;
        end
        else
        begin
            mem_write = 0;
        end

        if (mem_read == 1)
        begin
            m_valM = memReg[mem_addr];
        end

        if(mem_addr > 8191)
        begin
            m_stat = `SADR;
        end
        else
        begin
            m_stat = M_stat;
        end
    end
endmodule
