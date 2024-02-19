module(icode, valP, valC, valM, PC, Cnd);
input [3:0] icode;
input reg [63:0] valC;
input reg [63:0] valP;
input reg [63:0] valM;
input wire [63:0] PC;
input reg Cnd;
    if(icode == 7)
    begin
        if(Cnd)
        begin
            PC<=valC;
        end
        else
        begin
            PC <= valP;
        end
    end
    else if(icode == 8)
    begin 
        PC <= valC;
    end
    else if(icode == 9)
    begin
        PC<=valM;
    end
    else
    begin
        PC <= valP;
    end
endmodule