`include "execute.v"

module tb_execute;
    wire [63:0] valE;
    wire OF;
    wire ZF;
    wire SF;
    reg [63:0] valA;
    reg [63:0] valB;
    reg [63:0] valC;
    reg [3:0] icode;
    reg [3:0] ifun;
    execute DUT(OF,ZF,SF,valE,valA,valB,valC,icode,ifun);
    
    initial begin
        $dumpfile("tb_execute.vcd");
        $dumpvars(0,tb_execute);
    end

    initial begin
        valA <= 5;
        valB <= 3;
        valC <= 7;
        icode <= 2;
        ifun <= 0;
        #10
        icode <= 3;
        #10
        icode <= 4;
        #10
        icode <= 5;
        #10
        icode <= 8;
        #10
        icode <= 9;
        #10
        icode <= 10;
        #10 
        icode <= 11;
        #10
        icode <= 6;
        #10
        ifun <= 1;
        #10
        ifun <= 2;
        #10
        ifun <= 3;
        #10
        $finish;
    end


endmodule