`include "fetch.v"

module tb_fetch;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB;
    wire [63:0] valC;
    wire [63:0] valP;
    wire [7:0] stat;
    reg [63:0] PC;
    reg clk;
    fetch DUT(icode,ifun,rA,rB,valC,valP,stat,PC,clk);
    
    initial begin
        $dumpfile("tb_fetch.vcd");
        $dumpvars(0,tb_fetch);
    end

    always begin
        clk = ~clk;
        #5;
    end
    
    initial begin
        clk <=0;
        PC <= 0;
        #20
        PC <= valP;
        #20
        PC <= valP;
        #20
        PC <= valP;
        #10
        PC <= valP;
        #10
        PC <= valP;
        #10
        PC <= valP;
        #10
        PC <= valP;
        #10
        PC <= valP;
        #10
        $finish;
    end

endmodule