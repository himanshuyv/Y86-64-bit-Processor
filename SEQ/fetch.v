module fetch(icode,ifun,rA,rB,valC,valP,stat,PC);
    output reg [3:0] icode;
    output reg [3:0] ifun;
    output reg [3:0] rA;
    output reg [3:0] rB;
    output reg [63:0] valC;
    output reg [63:0] valP;
    output reg [3:0] stat;
    input wire [63:0] PC;
    input wire clk;
    reg [7:0] instructionMem [0:131];
    reg need_regids;
    reg need_valC;
    initial
    begin
        $readmemb("./../TestCases/fetch.txt",instructionMem);
    end

    always @(*)
    begin
        stat <= 0;
        if (PC>131)
        begin
            stat<=2;
        end

        icode <= instructionMem[PC][7:4];
        ifun <= instructionMem[PC][3:0];   

        if(icode == 2 || icode == 3 || icode == 4 || icode == 5 ||icode == 6 || icode == 10 || icode == 11) 
        begin
            need_regids = 1; 
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
        end
        else
        begin
            need_regids = 0;
            rA <= 15;
            rB <= 15;
        end

        if (icode == 3 || icode == 4 || icode == 5 || icode == 7 || icode == 8)
        begin
            need_valC = 1;
            valC[7:0] <= instructionMem[PC+need_regids+1];
            valC[15:8] <= instructionMem[PC+need_regids+2];
            valC[23:16] <= instructionMem[PC+need_regids+3];
            valC[31:24] <= instructionMem[PC+need_regids+4];
            valC[39:32] <= instructionMem[PC+need_regids+5];
            valC[47:40] <= instructionMem[PC+need_regids+6];
            valC[55:48] <= instructionMem[PC+need_regids+7];
            valC[63:56] <= instructionMem[PC+need_regids+8];
        end
        else
        begin
            need_valC = 0;
        end


        valP = PC + 1 + need_regids + 8*need_valC;
        
        if (icode == 0 || icode == 1 || icode == 9)
        begin
            if (icode == 0)
            begin
                stat <= 1;
            end

            if (ifun != 0)
            begin
                stat <= 3;
            end
        end   
         
        else if (icode == 2 || icode == 6 || icode == 10 || icode == 11)
        begin
            if ((icode == 2 && (ifun<0 || ifun>6)) || ((icode==6) && (ifun<0 || ifun>3)) || ((icode == 10 || icode == 11) && (rB != 15 || ifun!=0)))
            begin
                stat <= 3;
            end
        end   
         
        else if (icode == 3 || icode == 4 || icode == 5 || icode ==7 || icode==8)
        begin
            if (icode != 7 && icode != 8)
            begin
                if ((icode == 3 && rA != 15) || ifun!=0)
                begin
                    stat <= 3;
                end
            end
            else
            begin
                if ((icode == 7 && (ifun<0 || ifun>6)) || (icode == 8 && ifun != 0))
                begin
                    stat <= 3;
                end
            end
        end

        else
        begin
            stat <= 3;
        end


    end
    
endmodule