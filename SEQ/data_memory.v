module data_memory(valM, dmemError, valA, valP, valE, icode)
    input reg [63:0] valA;
    input reg [63:0] valP;
    input reg [63:0] valE;
    input reg [3:0] icode;
    output reg [63:0] valM;
    reg [63:0] memReg[0:8191];
    wire reg [63:0] mem_address;
    output reg dmemError;
    if(icode == 10 || icode == 8)
    begin
        mem_address <= valE;
    end
    else if(icode == 11 || icode == 9)
    begin 
        mem_address <= valA;
    end
    dmemError <=0;
    if(mem_address > 8191)
    begin
        dmemError <= 1;
    end
    if(icode == 10 || icode == 8)
    begin
        memReg[valE] <= valP;
    end
    else if(icode == 11 || icode == 9)
    begin 
        valM <= [valA];
    end
endmodule