`include "ALU_Wrapper.v"

module execute(OF,ZF,SF,valE,valA,valB,valC,icode,ifun);
    output reg [63:0] valE;
    output reg OF;
    output reg ZF;
    output reg SF;
    input [63:0] valA;
    input [63:0] valB;
    input [63:0] valC;
    input [3:0] icode;
    input [3:0] ifun;
    wire [63:0] aluOut;
    wire aluOF;
    reg [63:0] aluA;
    reg [63:0] aluB;
    reg [1:0] aluFun;

    ALU_Wrapper X1(aluOF,aluOut,aluFun,aluA,aluB);
    
    initial begin
        OF <= 0;
        ZF <= 0;
        SF <= 0;
    end

    always @(*)
    begin
        if (icode == 2 || icode == 6)
        begin
            aluA = valA;
        end
        else if (icode == 3 || icode == 4 || icode == 5)
        begin
            aluA  = valC;
        end
        else if (icode == 8 || icode == 10)
        begin 
            aluA = -8;
        end
        else if (icode == 9 || icode == 11)
        begin 
            aluA = 8;
        end

        if (icode == 4 || icode == 5 || icode == 6 || icode == 8 || icode == 9 || icode == 10 || icode == 11)
        begin 
            aluB = valB;
        end
        else if (icode == 2 || icode == 3)
        begin 
            aluB = 0;
        end

        if (icode == 6)
        begin 
            aluFun = ifun[1:0];
        end
        else
        begin
            aluFun = 0;
        end

        valE <= aluOut;
        OF <= aluOF;

        if (valE[63] == 1)
        begin
            SF = 1;
        end
        else
        begin
            SF = 0;    
        end

        if (valE == 0)
        begin
            ZF = 1;
        end
        else
        begin
            ZF = 0;    
        end
    end

endmodule