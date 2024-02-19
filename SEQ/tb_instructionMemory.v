`include "instructionMemory.v"

module tb_instructionMemory;
    wire [7:0] valRead0;
    wire [7:0] valRead1;
    wire [7:0] valRead2;
    wire [7:0] valRead3;
    wire [7:0] valRead4;
    wire [7:0] valRead5;
    wire [7:0] valRead6;
    wire [7:0] valRead7;
    wire [7:0] valRead8;
    wire [7:0] valRead9;
    wire imem_error;
    reg [63:0] PC;
    instructionMemory DUT(valRead0,valRead1,valRead2,valRead3,valRead4,valRead5,valRead6,valRead7,valRead8,valRead9,imem_error,PC);
    
    initial begin
        $dumpfile("tb_instructionMemory.vcd");
        $dumpvars(0,tb_instructionMemory);
    end

    initial begin
        PC <= 0;
        #10
        PC <= 5;
        #10
        PC <= 11;
        #10
        PC <= 150;
        #10
        $finish;
    end


endmodule