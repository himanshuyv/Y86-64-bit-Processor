`include "fetch.v"

module tb_fetch;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB;
    wire [63:0] valC;
    wire [63:0] valP;
    wire instr_valid;
    wire imem_error;
    reg [63:0] PC;
    reg clk;
    fetch DUT(icode,ifun,rA,rB,valC,valP,instr_valid,imem_error,clk,PC);
    
    initial begin
        $dumpfile("tb_fetch.vcd");
        $dumpvars(0,tb_fetch);
    end

    always begin
        clk = ~clk;
        #5;
    end

    always @(negedge clk)
    begin
        PC <= valP;
    end

    initial begin
        clk <= 0;
        PC <= 0;
        #300
        $finish;
    end


endmodule