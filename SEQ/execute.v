`include "ALU_Wrapper.v"

module execute(OF,ZF,SF,valE,valA,valB,valC,icode,ifun);
    output reg [63:0] valE;
    output reg OF;
    output reg ZF;
    output reg SF;
    input wire [63:0] valA;
    input wire [63:0] valB;
    input wire [63:0] valC;
    input wire [3:0] icode;
    input wire [3:0] ifun;
    wire [63:0] aluA;
    wire [63:0] aluB;
    wire [3:0] aluFun;

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
            aluFun = ifun;
        end
        else
        begin
            aluFun = 0;
        end

        ALU_Wrapper X1(OF,valE,aluFun,aluA,aluB);

        if (valE[63] == 1)
        begin
            SF = 1;
        end

        if (valE == 0)
        begin
            ZF = 1;
        end
    end

endmodule