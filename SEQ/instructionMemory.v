module instructionMemory(valRead0,valRead1,valRead2,valRead3,valRead4,valRead5,valRead6,valRead7,valRead8,valRead9,imem_error,PC);
    output reg [7:0] valRead0;
    output reg [7:0] valRead1;
    output reg [7:0] valRead2;
    output reg [7:0] valRead3;
    output reg [7:0] valRead4;
    output reg [7:0] valRead5;
    output reg [7:0] valRead6;
    output reg [7:0] valRead7;
    output reg [7:0] valRead8;
    output reg [7:0] valRead9;
    output reg imem_error;
    input [63:0] PC;
    reg [7:0] instructionMem [0:200];
    initial
    begin
        $readmemb("./../TestCases/t2.txt",instructionMem);
    end
    always @(*)
    begin
        imem_error = 0;
        if (PC>200)
        begin
            imem_error = 1;
        end
        else
        begin
            valRead0 = instructionMem[PC];
            valRead1 = instructionMem[PC+1];
            valRead2 = instructionMem[PC+2];
            valRead3 = instructionMem[PC+3];
            valRead4 = instructionMem[PC+4];
            valRead5 = instructionMem[PC+5];
            valRead6 = instructionMem[PC+6];
            valRead7 = instructionMem[PC+7];
            valRead8 = instructionMem[PC+8];
            valRead9 = instructionMem[PC+9];
        end
    end

endmodule