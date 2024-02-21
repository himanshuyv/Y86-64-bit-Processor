`include "execute.v"

module tb_execute;
    wire [63:0] valE;
    wire Cnd;
    reg [63:0] valA;
    reg [63:0] valB;
    reg [63:0] valC;
    reg [3:0] icode;
    reg [3:0] ifun;
    reg clk;
    execute DUT(Cnd,valE,valA,valB,valC,icode,ifun,clk);
    
    initial begin
        $dumpfile("tb_execute.vcd");
        $dumpvars(0,tb_execute);
    end

    always
    begin
        #5
        clk = ~clk;
    end

    initial begin
        clk <= 0;
        valA <= 5;
        valB <= 3;
        valC <= 7;
        icode <= 2;
        ifun <= 0;
        #5
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
        valB <= 5;
        #10
        valB <= 7;
        #10
        valB <= 1;
        #10
        ifun <= 2;
        #10
        ifun <= 3;
        #10
        icode <= 2;
        ifun <= 0;
        valA <= 0;
        #10
        ifun <= 1;
        #10
        icode <= 6;
        ifun <= 1;
        valA <= 6;
        valB <= 6;
        #10 
        icode <= 2;
        ifun <= 1;
        #5
        icode <= 6;
        valB <= 1;
        #5
        icode <= 6;
        valB <= 6;
        #10
        icode <= 2;
        ifun <= 2;
        #10
        ifun <= 3;
        #10
        ifun <= 4;
        #10
        ifun <= 5;
        #10
        ifun <= 6;
        #10
        icode <= 6;
        ifun <= 1;
        valA <= 8;
        valB <= 6;
        #10
        icode <= 2;
        ifun <= 1;
        #10
        ifun <= 2;
        #10
        ifun <= 3;
        #10
        ifun <= 4;
        #10
        ifun <= 5;
        #10
        ifun <= 6;
        #10
        icode <= 6;
        ifun <= 1;
        valA <= 4;
        valB <= 6;
        #10
        icode <= 2;
        ifun <= 1;
        #10
        ifun <= 2;
        #10
        ifun <= 3;
        #10
        ifun <= 4;
        #10
        ifun <= 5;
        #10
        ifun <= 6;
        #10
        $finish;
    end


endmodule