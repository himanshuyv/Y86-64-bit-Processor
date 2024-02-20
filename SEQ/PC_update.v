module PC_update(PC, icode, valP, valC, valM, Cnd, clk);
    output reg [63:0] PC;
    input [3:0] icode;
    input clk;
    input [63:0] valC;
    input [63:0] valP;
    input [63:0] valM;
    input Cnd;
    always @(*)
    begin
        if(icode == 7)
        begin
            if(Cnd == 1)
            begin
                PC=valC;
            end
            else
            begin
                PC = valP;
            end
        end
        else if(icode == 8)
        begin 
            PC = valC;
        end
        else if(icode == 9)
        begin
            PC=valM;
        end
        else
        begin
            PC = valP;
        end
    end
endmodule