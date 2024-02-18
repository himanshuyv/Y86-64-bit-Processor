module fetch(icode,ifun,rA,rB,valC,valP,stat,PC,clk);
    output reg [3:0] icode;
    output reg [3:0] ifun;
    output reg [3:0] rA;
    output reg [3:0] rB;
    output reg [63:0] valC;
    output reg [63:0] valP;
    output reg [7:0] stat;
    input wire [63:0] PC;
    input wire clk;
    reg [7:0] instructionMem [0:21];
    initial
    begin
        $readmemb("./../SampleTestcase/1.txt",instructionMem);
        stat <= 1;
    end

    always @(*)
    begin
        icode <= instructionMem[PC][7:4];
        ifun <= instructionMem[PC][3:0];   
        if (PC>21)
        begin
            stat<=3;
        end

        if (icode==0 && ifun==0)
        begin
            valP = PC + 1;
            stat <= 2;
        end
        
        else if (icode==1 && ifun==0)
        begin
            valP = PC + 1;
        end   
         
        else if (icode==2 && (ifun>=0 && ifun<=6))
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valP = PC + 2;
        end   
         
        else if (icode==3 && ifun==0)
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valC[7:0] <= instructionMem[PC+2];
            valC[15:8] <= instructionMem[PC+3];
            valC[23:16] <= instructionMem[PC+4];
            valC[31:24] <= instructionMem[PC+5];
            valC[39:32] <= instructionMem[PC+6];
            valC[47:40] <= instructionMem[PC+7];
            valC[55:48] <= instructionMem[PC+8];
            valC[63:56] <= instructionMem[PC+9];
            valP = PC + 10;
        end   
         
        else if (icode==4 && ifun==0)
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valC[7:0] <= instructionMem[PC+2];
            valC[15:8] <= instructionMem[PC+3];
            valC[23:16] <= instructionMem[PC+4];
            valC[31:24] <= instructionMem[PC+5];
            valC[39:32] <= instructionMem[PC+6];
            valC[47:40] <= instructionMem[PC+7];
            valC[55:48] <= instructionMem[PC+8];
            valC[63:56] <= instructionMem[PC+9];
            valP = PC + 10;
        end   
         
        else if (icode==5 && ifun==0)
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valC[7:0] <= instructionMem[PC+2];
            valC[15:8] <= instructionMem[PC+3];
            valC[23:16] <= instructionMem[PC+4];
            valC[31:24] <= instructionMem[PC+5];
            valC[39:32] <= instructionMem[PC+6];
            valC[47:40] <= instructionMem[PC+7];
            valC[55:48] <= instructionMem[PC+8];
            valC[63:56] <= instructionMem[PC+9];
            valP = PC + 10;
        end   
         
        else if (icode==6 && (ifun>=0 && ifun<=3))
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valP = PC + 2;
        end   
         
        else if (icode==7 && (ifun>=0 && ifun<=6))
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valC[7:0] <= instructionMem[PC+2];
            valC[15:8] <= instructionMem[PC+3];
            valC[23:16] <= instructionMem[PC+4];
            valC[31:24] <= instructionMem[PC+5];
            valC[39:32] <= instructionMem[PC+6];
            valC[47:40] <= instructionMem[PC+7];
            valC[55:48] <= instructionMem[PC+8];
            valC[63:56] <= instructionMem[PC+9];
            valP = PC + 10;
        end   
         
        else if (icode==8 && ifun==0)
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valC[7:0] <= instructionMem[PC+2];
            valC[15:8] <= instructionMem[PC+3];
            valC[23:16] <= instructionMem[PC+4];
            valC[31:24] <= instructionMem[PC+5];
            valC[39:32] <= instructionMem[PC+6];
            valC[47:40] <= instructionMem[PC+7];
            valC[55:48] <= instructionMem[PC+8];
            valC[63:56] <= instructionMem[PC+9];
            valP = PC + 10;
        end

        else if(icode == 9 && ifun==0)
        begin
            valP = PC+1;
        end

        else if (icode==10 && ifun==0)
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valP = PC + 2;
        end   
         
        else if (icode==11 && ifun==0)
        begin
            rA <= instructionMem[PC+1][7:4];
            rB <= instructionMem[PC+1][3:0];
            valP = PC + 2;
        end

        else
        begin
            stat <= 4;
        end        

    end
    
endmodule