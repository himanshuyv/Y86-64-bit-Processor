`include "ALU_Wrapper.v"

module execute(Cnd,valE,valA,valB,valC,icode,ifun,clk);
    output reg [63:0] valE;
    output reg Cnd;
    input [63:0] valA;
    input [63:0] valB;
    input [63:0] valC;
    input [3:0] icode;
    input [3:0] ifun;
    input clk;
    reg ZF;
    reg SF;
    reg OF;
    wire [63:0] aluOut;
    wire aluOF;
    reg [63:0] aluA;
    reg [63:0] aluB;
    reg [1:0] aluFun;

    ALU_Wrapper X1(aluOF,aluOut,aluFun,aluB, aluA);
    
    initial begin
        OF = 0;
        ZF = 0;
        SF = 0;
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
        else
        begin
            aluA = 0;
        end

        if (icode == 4 || icode == 5 || icode == 6 || icode == 8 || icode == 9 || icode == 10 || icode == 11)
        begin 
            aluB = valB;
        end
        else if (icode == 2 || icode == 3)
        begin 
            aluB = 0;
        end
        else
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

        valE = aluOut;

        if (icode == 2 || icode == 7)
        begin
            if (ifun == 0)
            begin
                Cnd = 1;
            end
            else if (ifun == 1)
            begin
                Cnd = (SF^OF)|ZF;
            end
            else if (ifun == 2)
            begin
                Cnd  = SF^OF;
            end
            else if (ifun == 3)
            begin
                Cnd = ZF;
            end
            else if (ifun == 4)
            begin
                Cnd = ~ZF;
            end
            else if (ifun == 5)
            begin
                Cnd = ~(SF^OF);
            end
            else if (ifun == 6)
            begin
                Cnd = ~(SF^OF) & ~ZF;
            end
        end
        else
        begin
            Cnd = 0;
        end
    end
    always @(negedge clk)
    begin
        if (icode == 6)
        begin 
            OF = aluOF;
            if (aluOut[63] == 1)
            begin
                SF = 1;
            end
            else
            begin
                SF = 0;    
            end

            if (aluOut == 0)
            begin
                ZF = 1;
            end
            else
            begin
                ZF = 0;    
            end
        end
    end
endmodule