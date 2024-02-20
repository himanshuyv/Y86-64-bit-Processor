module data_memory(valM, stat, valA, valP, valE, icode, instr_valid, imem_error, clk);
    output reg [2:0] stat;
    output reg [63:0] valM;
    input clk;
    input [63:0] valA;
    input [63:0] valP;
    input [63:0] valE;
    input [3:0] icode;
    input instr_valid;
    input imem_error;
    reg dmemError;
    reg [63:0] memReg[0:8191];
    genvar i;
    generate
        for (i=0; i<64;i = i+1)begin
            initial begin
                memReg[i] = 0;
            end
        end
    endgenerate
    reg [63:0] mem_address;
    always @(*)
    begin
        if(icode == 10 || icode == 8)
        begin
            mem_address = valE;
        end
        else if(icode == 11 || icode == 9)
        begin 
            mem_address = valA;
        end
        dmemError =0;
        if(mem_address > 8191)
        begin
            dmemError = 1;
        end
        if(icode == 10 || icode == 8)
        begin
            memReg[valE] = valP;
        end
        else if(icode == 11 || icode == 9)
        begin 
            valM = memReg[valA];
        end
        if(instr_valid == 1)
        begin
            stat = 1;
        end
        else if(instr_valid == 0)
        begin
            stat = 3;
        end

        if(imem_error == 1 || dmemError == 1)
        begin
            stat = 2;
        end
        if(icode == 0)
        begin
            stat = 4;
        end
    end
endmodule