module data_memory(valM, dmemError, stat, valA, valP, valE, icode, instr_valid, imem_error);
    input reg [63:0] valA;
    input reg [63:0] valP;
    input reg [63:0] valE;
    input reg [3:0] icode;
    output reg [2:0] stat;
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
    if(instr_valid == 1)
    begin
        stat <= 1;
    end
    else if(intr_valid == 0)
    begin
        stat <= 3;
    end
    else if(imem_error == 1 || dmemError == 1)
    begin
        stat <= 2;
    end
    if(icode == 0)
    begin
        stat <= 4;
    end
endmodule